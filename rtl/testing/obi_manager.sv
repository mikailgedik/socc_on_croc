// Module to generate obi requests

module obi_manager#(
    parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
    parameter type obi_req_t = logic,
    parameter type obi_rsp_t = logic
) (
    input logic clk_i,
    input logic rst_ni,

    output obi_req_t obi_req_o,
    input obi_rsp_t obi_rsp_i,
    output logic done
);
    `include "common_cells/registers.svh"
    `include "obi_testing_values.svh"
    // `include ".gitignore"

    logic [31:0] outgoing_idx_d, outgoing_idx_q;
    `FF(outgoing_idx_q, outgoing_idx_d, '0, clk_i, rst_ni)
    logic [31:0] incoming_idx_d, incoming_idx_q;
    `FF(incoming_idx_q, incoming_idx_d, '0, clk_i, rst_ni)
    
    assign outgoing_idx_d = obi_req_o.req & obi_rsp_i.gnt ? outgoing_idx_q + 'h1 : outgoing_idx_q;

    always_comb begin : obi_manager_outgoing
        int trx_type;
        obi_orders_t order;
        obi_req_o.a.addr = '0;
        obi_req_o.a.we = '0;
        obi_req_o.a.be = '0;
        obi_req_o.a.wdata = '0;
        obi_req_o.a.aid = '0;
        obi_req_o.req = '0;

        if(rst_ni) begin
            if(outgoing_idx_q < MAX_OBI_ORDERS) begin
                order = get_obi_order(outgoing_idx_q);
                trx_type = (order.attr) & 32'hFF;
                obi_req_o.a.addr = order.addr;
                obi_req_o.a.be = 4'(order.attr >> 28);
                obi_req_o.req = '1;
                case (trx_type)
                    'h0: begin
                        obi_req_o.a.we = '0;
                        obi_req_o.a.aid = '0;
                    end
                    'h1: begin
                        obi_req_o.a.we = '1;
                        obi_req_o.a.wdata = order.value;
                        obi_req_o.a.aid = '1;
                    end
                    default: begin
                        $error("Encountered trx_type 0x%X at %d", trx_type, outgoing_idx_q);
                    end
                endcase
            end
        end
    end

    always_comb begin : obi_manager_incoming
        done = '0;
        incoming_idx_d = incoming_idx_q;
        if(incoming_idx_q < MAX_OBI_ORDERS) begin
            if(obi_rsp_i.rvalid == '1) begin
                incoming_idx_d++;
            end
        end else begin
            done = '1;
        end
    end

    always_ff @( posedge clk_i ) begin : debug_printer
        if(incoming_idx_q < MAX_OBI_ORDERS) begin
            if(obi_rsp_i.rvalid == '1) begin
                if(obi_rsp_i.r.err) begin
                    $error("Encountered err at 0x%X", incoming_idx_q);
                end else case(obi_rsp_i.r.rid)
                    'h0: begin
                        $display("Read:  %x -> %x ", get_obi_order(incoming_idx_q).addr, obi_rsp_i.r.rdata);
                    end
                    'h1: begin
                        $display("Wrote: %x -> %x", get_obi_order(incoming_idx_q).addr, get_obi_order(incoming_idx_q).value);
                    end
                    default: begin
                        $error("Encountered rid 0x%X at %d", obi_rsp_i.r.rid, incoming_idx_q);
                    end
                endcase
            end
        end else begin
            if(obi_rsp_i.rvalid) begin
                $error("Superflous response");
            end
        end
    end

endmodule