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

class Gate:
    def __init__(self, sv_rhs_template: str, eval_fn: Callable[[bool, bool], bool]) -> None:
        self.sv_rhs_template : str = sv_rhs_template
        self.eval_fn: Callable[[bool, bool], bool] = eval_fn

    def __call__(self, a: bool, b: bool) -> bool:
        return self.eval_fn(a, b)

    def to_sv_rhs(self, a: str, b: str) -> str:
        return self.sv_rhs_template.replace("a",a).replace("b", b)
class Gates(Gate, Enum):
    NAND = "~(a & b)", lambda a,b: not (a and b) # type: ignore
    NOR = "~(a | b)", lambda a,b: not (a or b) # type: ignore
    XNOR = "~(a ^ b)", bool.__eq__
    AND = "(a & b)", bool.__and__
    OR = "(a | b)", bool.__or__
    XOR = "(a ^ b)", lambda a,b: a != b # type: ignore
    ONE = "'1", lambda _a,_b: True # type: ignore
    ZERO = "'0", lambda _a,_b: False # type: ignore

STAGE_COUNT : int = 2
FF_PER_STAGE : int = 32

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

type CombFF = tuple[Gate, tuple[int, int]]

type StageState = list[bool]

def gen_random_combff(rng: Random) -> CombFF:
    # return (Gates.NAND, (0,1))
    return (rng.choice(list(Gates)), (rng.randint(0,FF_PER_STAGE-1),rng.randint(0,FF_PER_STAGE-1)))

class Stage:
    def __init__(self, size: int):
        self.size : int = size
        self.state : list[bool] = [False for _ in range(size)]
        rng = Random()
        self.gates : list[CombFF] = [gen_random_combff(rng) for _ in range(size)]
    def logic_function(self, input: list[bool]) -> list[bool]:
        return [g[0](input[g[1][0]], input[g[1][1]]) for g in self.gates]
    
    def next_step(self, input: list[bool]) -> "Stage":
        s : Stage = Stage(self.size)
        s.gates = self.gates
        s.state = self.logic_function(input)
        return s


class Machine:
    def __init__(self) -> None:
        self.stages_q : list[Stage] = [Stage(FF_PER_STAGE) for _ in range(STAGE_COUNT)]

    def run(self, stim: list[list[bool]]) -> list[list[bool]]:
        res : list[list[bool]] = list()
        
        for s in stim:
            stages_d : list[Stage] = [Stage(FF_PER_STAGE) for _ in range(STAGE_COUNT)]
            stages_d[0] = self.stages_q[0].next_step(s)
            for i in range(1, len(stages_d)):
                stages_d[i] = self.stages_q[i].next_step(self.stages_q[i-1].state)

            self.stages_q = stages_d
            res.append(self.stages_q[-1].state)
        return res
    
    def modified_clone(self, mutation_prob: float, rng: Random = Random()) -> "Machine":
        m = Machine()
        for i in range(len(m.stages_q)):
            s = m.stages_q[i]
            for ii in range(len(s.gates)):
                if rng.random() < mutation_prob:
                    m.stages_q[i].gates[ii] = gen_random_combff(rng)
                else:
                    m.stages_q[i].gates[ii] = self.stages_q[i].gates[ii]
        return m

    def to_system_verilog(self, module_name: str) -> str:
        logic_decls = ""
        comb_stmts = ""
        ff_stms = ""
        prev_stage_q : str = "data_i"
        for i in range(len(self.stages_q)):
            stage = self.stages_q[i]
            logic_decls += f"\tlogic [{len(stage.gates) - 1}:0] state_{i}_d, state_{i}_q;\n"
            ff_stms += f"\t\tstate_{i}_q <= rst_ni ? state_{i}_d : 'b0;\n"

            for ii in range(0, len(stage.gates)):
                g = stage.gates[ii]
                rhs_a = f"{prev_stage_q}[{g[1][0]}]"
                rhs_b = f"{prev_stage_q}[{g[1][1]}]"
                rhs = g[0].to_sv_rhs(rhs_a, rhs_b)
                comb_stmts += f"\t\tstate_{i}_d[{ii}] = {rhs};\n"
            prev_stage_q = f"state_{i}_q"
        comb_stmts += f"\t\tdata_o = state_{len(self.stages_q) - 1}_q;"
        return SV_TEMPLATE.replace(
            "%MODULE_NAME%", module_name).replace(
            "%WIDTH_IN%", str(FF_PER_STAGE - 1)).replace(
            "%WIDTH_OUT%", str(FF_PER_STAGE - 1)).replace(
            "%LOGIC_DECL%", logic_decls).replace(
            "%COMB%", comb_stmts).replace(
            "%FLIPFLOP%", ff_stms)
