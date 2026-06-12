// Module to generate obi requests

module obi_manager#(
    parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
    parameter type obi_req_t = logic,
    parameter type obi_rsp_t = logic,
    
    parameter string orders_file_name = ""
) (
    input logic clk_i,
    input logic rst_ni,

    output obi_req_t obi_req_o,
    input obi_rsp_t obi_rsp_i,
    output logic done
);
    `include "common_cells/registers.svh"

    typedef struct packed {
        int addr;
        int value;
        int attr;
    } obi_orders_t;

    obi_orders_t orders[];
    initial begin
        int fd;
        int code;
        assert (ObiCfg.AddrWidth == 'd32);
        assert (ObiCfg.DataWidth == 'd32);

        fd = $fopen(orders_file_name, "rb");
        if(fd == 0) $error("File %s not found", orders_file_name);
        orders = new [0];
        while ($feof(fd)) begin
            orders = new [orders.size() + 1](orders);
            code = $fscanf(fd, "%z", orders[orders.size() - 1].addr);
            if(code == -1) $error("eof reached");
            code = $fscanf(fd, "%z", orders[orders.size() - 1].value);
            if(code == -1) $error("eof reached");
            code = $fscanf(fd, "%z", orders[orders.size() - 1].attr);
            if(code == -1) $error("eof reached");
        end

        $fclose(fd);
    end

    logic [31:0] outgoing_idx_d, outgoing_idx_q;
    `FF(outgoing_idx_q, outgoing_idx_d, '0, clk_i, rst_ni)
    logic [31:0] incoming_idx_d, incoming_idx_q;
    `FF(incoming_idx_q, incoming_idx_d, '0, clk_i, rst_ni)
    
    assign outgoing_idx_d = obi_req_o.req & obi_rsp_i.gnt ? outgoing_idx_q + 'h1 : outgoing_idx_q;

    always_comb begin : obi_manager_outgoing
        int trx_type;
        obi_req_o.a.addr = '0;
        obi_req_o.a.we = '0;
        obi_req_o.a.be = '0;
        obi_req_o.a.wdata = '0;
        obi_req_o.a.aid = '0;
        
        obi_req_o.req = '0;
        if(outgoing_idx_q < orders.size) begin
            trx_type = (orders[outgoing_idx_q].attr) & 32'hFF;
            obi_req_o.a.addr = orders[outgoing_idx_q].addr;
            obi_req_o.a.be = 4'(orders[outgoing_idx_q].attr >> 28);
            obi_req_o.req = '1;
            case (trx_type)
                'h0: begin
                    obi_req_o.a.we = '0;
                    obi_req_o.a.aid = '0;
                end
                'h1: begin
                    obi_req_o.a.we = '1;
                    obi_req_o.a.wdata = orders[outgoing_idx_q].value;
                    obi_req_o.a.aid = '1;
                end
                default: begin
                    $error("Encountered trx_type 0x%X at %d", trx_type, outgoing_idx_q);
                end
            endcase
        end
    end

    always_comb begin : obi_manager_incoming
        done = '0;
        incoming_idx_d = incoming_idx_q;
        if(incoming_idx_q < orders.size) begin
            incoming_idx_d++;
            if(obi_rsp_i.rvalid == '1) begin
                if(obi_rsp_i.r.err) begin
                    $error("Encountered rid 0x%X", obi_rsp_i.r.rid);
                end else case(obi_rsp_i.r.rid)
                    '0: begin
                        $display("Read back %d %x ", incoming_idx_q, obi_rsp_i.r.rdata);
                    end
                    '1: begin
                    end
                    default: begin
                        $error("Encountered rid 0x%X at %d", obi_rsp_i.r.rid, incoming_idx_q);
                    end
                endcase
            end
        end else begin
            done = '1;
        end
    end

endmodule