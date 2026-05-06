from typing import Callable
from enum import Enum
from random import Random
### NAIVE implementation of (lossy) compression of data inside a ROM.
# Simple diagram of what we're trying to achieve. stages=2 (each stage as logic and ff)
#             |-------|       |-------|       |-------|       |-------|
# DATA IN-----| L     |       | F     |       | L     |       | F     |
#             | O     |       | F     |       | O     |       | F     |
#             | G     |-------|       |-------| G     |-------|       |----DATA OUT
#             | I     |       |       |       | I     |       |       |
#             | C     |       |       |       | C     |       |       |
# RST---------|       |       |       |       |       |       |       |
# CLK---------|-------|       |-------|       |-------|       |-------|

class Gates(int, Enum):
    ZERO = 0b000
    XOR = 0b001
    AND = 0b010
    OR = 0b011
    ONE = 0b100
    XNOR = 0b101
    NAND = 0b110
    NOR = 0b111

SV_TEMPLATE : str = """
module %MODULE_NAME% #(
)(
    input  logic                 clk_i,
    input  logic                 rst_ni,
    input  logic [%WIDTH_IN%:0] data_i,
    output logic [%WIDTH_OUT%:0] data_o
);
%LOGIC_DECL%
    always_ff @( posedge clk_i, negedge rst_ni ) begin : assign_ffs
%FLIPFLOP%
    end

    always_comb begin
%COMB%
    end
endmodule
"""

def get_src_bits(input: bytes, bit_indexes: tuple[int, ...]) -> bytes:
    assert len(bit_indexes) % 8 == 0
    return bytes([
        (((input[bit_indexes[8*i + 0] // 8] >> (bit_indexes[8*i + 0] % 8)) & 1) << 0) |
        (((input[bit_indexes[8*i + 1] // 8] >> (bit_indexes[8*i + 1] % 8)) & 1) << 1) |
        (((input[bit_indexes[8*i + 2] // 8] >> (bit_indexes[8*i + 2] % 8)) & 1) << 2) |
        (((input[bit_indexes[8*i + 3] // 8] >> (bit_indexes[8*i + 3] % 8)) & 1) << 3) |
        (((input[bit_indexes[8*i + 4] // 8] >> (bit_indexes[8*i + 4] % 8)) & 1) << 4) |
        (((input[bit_indexes[8*i + 5] // 8] >> (bit_indexes[8*i + 5] % 8)) & 1) << 5) |
        (((input[bit_indexes[8*i + 6] // 8] >> (bit_indexes[8*i + 6] % 8)) & 1) << 6) |
        (((input[bit_indexes[8*i + 7] // 8] >> (bit_indexes[8*i + 7] % 8)) & 1) << 7)
        for i in range(len(bit_indexes)//8)
    ])


class StageComb8:
    """
    Combinatorial logic of n*eight inputs at once. Funny business
    The output is calculated as follows:
    (((A ^ B) & c1) + ((A & B) & c2)) ^ c3
    This enables all basic operations (AND, OR, XOR, ZERO and its negated counterparts)
    """
    def __init__(self,
                gates: int,
                prev_stage_size: int | None = None) -> None:
        self.gates = gates
        # bytes is always a multiple of 4
        self.bytes = ((gates + 31) // 32) * 4

        if prev_stage_size is None:        
            self.xor_enable = bytes(self.bytes)
            self.and_enable = bytes(self.bytes)
            self.inv_enable = bytes(self.bytes)
            # Index in the previous stage for the sources
            self.sourceA = tuple([0 for _ in range(self.bytes * 8)])
            self.sourceB = tuple([0 for _ in range(self.bytes * 8)])
        else:
            """Initialize it with ORs of all previous gates"""
            self.xor_enable = bytes(255 for _ in range(self.bytes))
            self.and_enable = bytes(255 for _ in range(self.bytes))
            self.inv_enable = bytes(self.bytes)
            # Index in the previous stage for the sources
            self.sourceA = tuple([i if i < prev_stage_size else 0 for i in range(self.bytes * 8)])
            self.sourceB = tuple([i if i < prev_stage_size else 0 for i in range(self.bytes * 8)])

    def next_stage(self, input: bytes) -> bytes:
        # assert len(input) == self.bytes, f"{len(input)}, {self.bytes}"
        sourceA_bits = get_src_bits(input, self.sourceA)
        sourceB_bits = get_src_bits(input, self.sourceB)

        return bytes([
            (((sourceA_bits[i] ^ sourceB_bits[i]) & self.xor_enable[i]) |
             ((sourceA_bits[i] & sourceB_bits[i]) & self.and_enable[i])) ^ self.inv_enable[i]
            for i in range(self.bytes)])
    
    def to_sv_rhs(self) -> list[str]:
        def bits_to_sv_rhs(bits: int) -> str:
            match bits:
                case 0b000: return "'0"
                case 0b001: return "(a ^ b)"
                case 0b010: return "(a & b)"
                case 0b011: return "(a | b)"
                case 0b100: return "'1"
                case 0b101: return "~(a ^ b)"
                case 0b110: return "~(a & b)"
                case 0b111: return "~(a | b)"
                case _: raise ValueError("Unsupported bits!")

        return [
            bits_to_sv_rhs(
                (((self.xor_enable[i // 8] >> (i % 8)) & 1) << 0) |
                (((self.and_enable[i // 8] >> (i % 8)) & 1) << 1) |
                (((self.inv_enable[i // 8] >> (i % 8)) & 1) << 2)
            ) for i in range(8 * self.bytes)
        ]
    
    def randomize_stage(self, prev_stage_len: int, mutation_prob: float, rng:Random) -> "StageComb8":
        n = StageComb8(self.gates)
        nxor_enable = bytearray(self.xor_enable)
        nand_enable = bytearray(self.and_enable)
        ninv_enable = bytearray(self.inv_enable)

        for i in range(self.gates):
            if rng.random() < mutation_prob:
                nxor_enable[i // 8] ^= (rng.randint(0,1) & 1) << (i % 8)
                nand_enable[i // 8] ^= (rng.randint(0,1) & 1) << (i % 8)
                ninv_enable[i // 8] ^= (rng.randint(0,1) & 1) << (i % 8)

        nsourceA = [rng.randint(0, prev_stage_len - 1) if rng.random() < mutation_prob else self.sourceA[i] for i in range(self.bytes * 8)]
        nsourceB = [rng.randint(0, prev_stage_len - 1) if rng.random() < mutation_prob else self.sourceB[i] for i in range(self.bytes * 8)]

        n.xor_enable = bytes(nxor_enable)
        n.and_enable = bytes(nand_enable)
        n.inv_enable = bytes(ninv_enable)
        n.sourceA = tuple(nsourceA)
        n.sourceB = tuple(nsourceB)
        return n

type StageState = bytes

class Machine:
    INPUT_WIDTH = 32
    FF_PER_STAGE = (64,64,64,64,32)

    def __init__(self) -> None:
        self.stages_q : tuple[bytes, ...] = tuple([bytes(Machine.FF_PER_STAGE[i]) for i in range(len(Machine.FF_PER_STAGE))])
        self.stage_input_width : dict[int, int]= {i:self.FF_PER_STAGE[i-1] for i in range(1, len(self.FF_PER_STAGE))}
        self.stage_input_width[0] = Machine.INPUT_WIDTH
        self.stage_comb : tuple[StageComb8, ...] = tuple(
            StageComb8(Machine.FF_PER_STAGE[i], self.stage_input_width[i]) for i in range(len(Machine.FF_PER_STAGE)))

    def run(self, stim: list[bytes]) -> list[bytes]:
        res : list[bytes] = list()
        
        for s in stim:
            stages_d : list[StageState] = [bytes(0) for _ in range(len(Machine.FF_PER_STAGE))]
            stages_d[0] = self.stage_comb[0].next_stage(s)
            for i in range(1, len(stages_d)):
                stages_d[i] = self.stage_comb[i].next_stage(self.stages_q[i-1])

            self.stages_q = tuple(stages_d)
            res.append(self.stages_q[-1])
        return res
    
    def modified_clone(self, mutation_prob: float, stages : list[int] | None, rng: Random) -> "Machine":
        m = Machine()
        
        if stages is None:
            stages = list(range(len(self.stage_comb)))

        m.stage_comb = tuple([self.stage_comb[i].randomize_stage(self.stage_input_width[i], mutation_prob if i in stages else 0, rng) 
                               for i in range(len(self.stage_comb))])

        return m

    def to_system_verilog(self, module_name: str) -> str:
        logic_decls = ""
        comb_stmts = ""
        ff_stms = ""
        prev_stage_q : str = "data_i"
        for i in range(len(self.stage_comb)):
            stage = self.stage_comb[i]
            logic_decls += f"\tlogic [{stage.gates - 1}:0] state_{i}_d, state_{i}_q;\n"
            ff_stms += f"\t\tstate_{i}_q <= rst_ni ? state_{i}_d : 'b0;\n"

            stage_rhs : list[str] = stage.to_sv_rhs()

            for ii in range(0, stage.gates):
                rhs_a = f"{prev_stage_q}[{stage.sourceA[ii]}]"
                rhs_b = f"{prev_stage_q}[{stage.sourceB[ii]}]"
                rhs = stage_rhs[ii].replace("a", rhs_a).replace("b", rhs_b)
                comb_stmts += f"\t\tstate_{i}_d[{ii}] = {rhs};\n"
            prev_stage_q = f"state_{i}_q"
        comb_stmts += f"\t\tdata_o = state_{len(self.stages_q) - 1}_q;"
        return SV_TEMPLATE.replace(
            "%MODULE_NAME%", module_name).replace(
            "%WIDTH_IN%", str(Machine.INPUT_WIDTH - 1)).replace(
            "%WIDTH_OUT%", str(Machine.FF_PER_STAGE[-1] - 1)).replace(
            "%LOGIC_DECL%", logic_decls).replace(
            "%COMB%", comb_stmts).replace(
            "%FLIPFLOP%", ff_stms)
