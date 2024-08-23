
`include "../includes/axi_ifs.sv"

/**
UART Driver module to interface to Lattice UART IP with an Axi Stream interface
*/
module uart_lattice_axis_driver #(
    parameter DEST_WIDTH = 8,
    parameter ID_WIDTH = 8,
    parameter USER_WIDTH = 1,
    parameter DATA_WIDTH = 8,
    parameter C_M_AXI_ADDR_WIDTH = 4,
    parameter C_M_AXI_DATA_WIDTH = 32,
    parameter AXIS_DEST = 0,
    parameter AXIS_SOURCE = 0
    ) (

    input wire clk,
    input wire resn,


    // Axi Stream Side for Interconnect
    //-----------------------
    
    // AXI Stream master port, for received bytes to be written out
    output reg [7:0]              m_axis_tdata,
    output reg                    m_axis_tvalid,
    input  wire                   m_axis_tready,
    output wire [ID_WIDTH-1:0]    m_axis_tid, // Source ID for RFG to route back
    output wire [DEST_WIDTH-1:0]  m_axis_tdest, // Destination for RFG Switch

    
    // AXIS slave for received bytes to send out to UART
    // Written to by crossbar in NOC design
    input  wire [7:0]             s_axis_tdata,
    input  wire                   s_axis_tvalid,
    output reg                    s_axis_tready,
    
    // AXI4-Lite Master to drive the UART Lite core
    //--------------

    output reg                      apb_penable_i,
    output reg                      apb_psel_i ,
    output reg                      apb_pwrite_i ,

    output reg [5:0]               apb_paddr_i , 
    output reg [31:0]              apb_pwdata_i ,

    input wire                      apb_pready_o ,
    input wire                      apb_pslverr_o ,
    input wire [31:0]               apb_prdata_o , // Read data from module

    // Sideband signals
    //-----------------
    input wire read_reg,
    input wire interrupt_uart,
    output reg uart_init_done,
    output reg uart_got_byte,
    output reg [7:0]    uart_rcv_byte
);

    // Defaults
    //-----------
    assign m_axis_tid = AXIS_SOURCE;
    assign m_axis_tdest = AXIS_DEST;

    // UART Receive stage, will be read by AXIS side
    //-------------
    //reg [7:0]    uart_axi_data;
    reg          uart_rcv_byte_valid;

    typedef struct packed {
        bit rcvr_fifo_err;
        bit xmitr_empty;
        bit thr_empty;
        bit break_cond;
        bit framing_err;
        bit parity_err;
        bit overrun_err;
        bit data_rdy;
    } uart_status_t;
    uart_status_t uart_status;
    reg           uart_status_updated;

    // AXIS Receive stage, will be transmitted to UART via AXI
    //----------------
    byte_t uart_byte_to_send;


    // Core initialisation
    //----------------
    typedef enum {
        INIT,
        INIT_SETUP,
        INIT_DONE, 
        IDLE,
        WRITE_FIFO,
        WAIT_STATUS,
        READ_STATUS,
        READ_FIFO,
        WAIT_READY
    }  uart_states;
    uart_states   uart_state;
    uart_states   uart_state_next;

    // AXI Read: Status and Data read
    //---------

    // 1 if UART core gives interrupt or we are writting data
    // This will trigger reader the status of core to ensure we are not overruning it
    wire axi_start_read = interrupt_uart || uart_state == WRITE_FIFO;

    wire axis_master_stalled = m_axis_tvalid && ! m_axis_tready;

    always@(posedge clk) begin
        if (resn==0) begin
          
            uart_init_done           <= 0;
            
            // UART <-> APB
            uart_state                      <= INIT;
            uart_rcv_byte                   <= 8'h00;
            uart_rcv_byte_valid             <= 1'b0;
            

            uart_status_updated             <= 1'b0;

            // AXIS -> UART (uart send, axis slave)
            s_axis_tready <= 'b1;
            

            apb_penable_i   <= 'b0;
            apb_psel_i      <= 'b0;
            apb_pwrite_i    <= 'b0;
            apb_paddr_i     <= 'b0;
            
            uart_status <= 'h00;

        end
        else begin

            // APB Read/Write Path to Core
            //--------------------
            case (uart_state)
                INIT: begin
                    uart_state <= READ_STATUS;
                end
        

                IDLE: begin
                    
                    uart_init_done <= 1'b1;

                    /*if (read_reg) begin
                        uart_write_state <= UFW_INIT_SETUP;
                    end*/

                    // Accept Stream byte for UART core if valid asserted and status has no tx fifo full
                    //--------
                    s_axis_tready       <= uart_status.thr_empty;

                    // Transmit if possible
                    if (s_axis_tvalid && s_axis_tready && uart_status.thr_empty == 1'b1) begin
                        
                        s_axis_tready       <= 1'b0;
                        uart_byte_to_send   <= s_axis_tdata;
                        uart_state          <=  WRITE_FIFO;
                    end
                    // Read if possible
                    else if (axi_start_read && !axis_master_stalled) begin
                        uart_state <= READ_STATUS;
                    end
                    // If transmit fifo is not empty, keep checking status
                    else if (uart_status.thr_empty==1'b0) begin
                        uart_state <= READ_STATUS;
                    end
                    
                end

                // Read States
                //-------------
                // Read Status of Module to see if there are data
                //------------
                READ_STATUS: begin
                    
                    apb_psel_i      <= 'b1;
                    apb_penable_i   <= apb_psel_i;
                    apb_paddr_i     <= 6'h14; // Line status register
                    apb_pwrite_i    <= 1'b0;

                    if (apb_psel_i && apb_penable_i) begin
                        uart_state      <= WAIT_READY;
                        uart_state_next <= READ_FIFO;
                    end
                    
                end
            
                // Read Byte from FIFO
                //-----------------
                READ_FIFO: begin
                
                    // Read fifo is preceded by status read
                    // If status shows no data, don't read and go back to waiting
                    if (apb_prdata_o[0]==1'b1 && !axis_master_stalled) // Data available
                    begin

                        apb_psel_i      <= 'b1;
                        apb_penable_i   <= apb_psel_i;
                        apb_paddr_i     <= 6'h0; // Data Reg
                        apb_pwrite_i    <= 1'b0;

                        if (apb_psel_i && apb_penable_i) begin
                            uart_state <= WAIT_READY;
                            uart_state_next <= READ_STATUS;
                        end
                        
                    end
                    else if (apb_prdata_o[0]==1'b1 && !axis_master_stalled)
                        uart_state <= READ_FIFO;
                    else begin
                        uart_state <= interrupt_uart ? READ_STATUS : IDLE;
                    end
                    
                
                    
                end

                // Write States
                //-----------
                
                WRITE_FIFO: begin

                    apb_psel_i      <= 'b1;
                    apb_penable_i   <= apb_psel_i;
                    apb_paddr_i     <= 6'h0; // Line status register
                    apb_pwdata_i    <= uart_byte_to_send;
                    apb_pwrite_i    <= 1'b1;

                    if (apb_psel_i && apb_penable_i) begin
                        uart_state      <= WAIT_READY;
                        uart_state_next <= READ_STATUS;
                    end
                 
                end

                WAIT_READY: begin 
                    if (apb_pready_o) begin
                        uart_state <= uart_state_next; 
                        apb_psel_i <= 'b0;
                        apb_penable_i <= 'b0;
                    end
                end
                
            

            endcase;

            //---------------------------
            // Data path UART Byte out of core
            //---------------------------
            case (uart_state)
                WAIT_READY: begin 
                    

                    if (apb_pready_o && apb_pwrite_i == 1'b0) begin
            
                        // Was reading byte
                        if (apb_paddr_i==4'h0) begin
                            uart_rcv_byte       <= apb_prdata_o[7:0];
                            uart_rcv_byte_valid <= 1'b1;
                            //uart_got_byte       <= !uart_got_byte;
                        end
                        // Was reading status
                        else  begin
                            uart_status_updated <= 1'b1;
                            uart_status         <= apb_prdata_o[7:0];
                        end
                    end
                end

                // The bytes received should be reset, unless the axis stage was stalled
                default: begin
                    if (uart_rcv_byte_valid && !axis_master_stalled) begin
                        uart_rcv_byte_valid <= 1'b0;
                    end
                    
                end

            endcase
        
        end     
    end

    // AXI Stream Master output (UART RX -> RFG)
    //----------------------
    always @(posedge clk)
    begin

        // Reset or wait for initialisation || !uart_init_done
        if (!resn) begin

            // AXIS <- UART (uart receive, axis master)
            m_axis_tvalid <= 'b0;

            uart_got_byte                   <= 1'b0;
        end
        else begin
            
            if (uart_rcv_byte_valid && !m_axis_tvalid) begin
                m_axis_tdata <= uart_rcv_byte;
                m_axis_tvalid <= 1'b1;
                uart_got_byte <= 1'b1;
            end else if (m_axis_tvalid && m_axis_tready) begin
                m_axis_tvalid <= 'b0;
            end
            
        end

    end


endmodule