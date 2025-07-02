`ifndef ASTEP_IFS
`define ASTEP_IFS

typedef logic [7:0] byte_t;
typedef logic [15:0] word_t;

package axi_ifs;
endpackage

/// An AXIS Interface
interface AXIS #(
    parameter int unsigned AXIS_ADDR_WIDTH = 4,
    parameter int unsigned AXIS_ID_WIDTH = 2,
    parameter int unsigned AXIS_USER_WIDTH = 4,
    parameter int unsigned AXIS_DATA_WIDTH = 8
  );
  
    localparam int unsigned AXIS_STRB_WIDTH = AXIS_DATA_WIDTH / 8;

    typedef logic [3:0] addr_t;
    typedef logic [1:0]   id_t;
    typedef logic [3:0] user_t;
    typedef logic [7:0] data_t;

    addr_t    tdest;
    id_t      tid;
    data_t    tdata;
    logic     tkeep;
    logic     tvalid;
    logic     tlast;
    logic     tready;
    user_t    tuser;


    modport master (
        output tdata,tdest,tid,tuser, tvalid,tlast,
        input tready
    );

    modport master_without_sideband (
        output tdata, tvalid,tlast,
        input tready
    );

        modport slave (
        input tdata,tdest,tid,tuser, tvalid,tlast,
        output tready
    );

    task reset_master();
        
        tdest   <= 0;
        tid     <= 0;
        tuser   <= 0;
        tvalid  <= 1'b0;
        tlast   <= 1'b0;
        

    endtask

    task reset_slave();
        tready <= 1'b0;
    endtask

    task m_write_start(input addr_t dest,input id_t vid, input data_t data);
        
        tvalid <= 1'b1;
        tdest   <= dest;
        tid     <= vid;
        tdata   <= data;

    endtask

    task m_write_single(input addr_t dest,input id_t vid, input data_t data);
        
        tvalid  <= 1'b1;
        tlast   <= 1'b1;
        tdest   <= dest;
        tid     <= vid;
        tdata   <= data;

    endtask

    task m_write_last(input data_t data);
        
        tvalid <= 1'b1;
        tlast   <= 1'b1;
        tdata   <= data;

    endtask

    task m_invalid();
        
        tvalid  <= 1'b0;
        tlast   <= 1'b0;

    endtask

    task m_last();
        tlast   <= 1'b1;
    endtask

    task m_write_data(input data_t data);
        
        tvalid <= 1'b1;
        tdata   <= data;

    endtask

    task s_accept();
        tready <= 1'b1;
    endtask

    task s_not_ready();
        tready <= 1'b0;
    endtask
    /*
    // task master_write(input clk,
    task master_single_write(input addr_t address,input data_t data);
        aw_valid    <= 1'b1;
        aw_addr     <= address;
        w_data      <= data;
        w_valid     <= 1'b1;
    endtask

    task master_write_done();
        aw_valid <= 1'b0;
        w_valid <= 1'b0;
    endtask

    task master_read(input addr_t address);
        ar_valid    <= 1'b1;
        ar_addr     <= address;
    endtask
    task master_read_done();
        ar_valid    <= 1'b0;
    endtask*/


endinterface

// Copied from https://github.com/pulp-platform/axi/blob/master/src/axi_intf.sv
/// An AXI4-Lite interface.
interface AXI_LITE #(
  parameter int unsigned AXI_ADDR_WIDTH = 4,
  parameter int unsigned AXI_DATA_WIDTH = 32
);

  localparam int unsigned AXI_STRB_WIDTH = AXI_DATA_WIDTH / 8;

  typedef logic [AXI_ADDR_WIDTH-1:0] addr_t;
  typedef logic [AXI_DATA_WIDTH-1:0] data_t;
  typedef logic [AXI_STRB_WIDTH-1:0] strb_t;

  // AW channel
  addr_t          aw_addr;
  logic           aw_valid;
  logic           aw_ready;

  data_t          w_data;
  strb_t          w_strb;
  logic           w_valid;
  logic           w_ready;


  logic           b_valid;
  logic           b_ready;

  addr_t          ar_addr;
  logic           ar_valid;
  logic           ar_ready;

  data_t          r_data;
  logic           r_valid;
  logic           r_ready;

  modport Master (
    output aw_addr, aw_valid, input aw_ready,
    output w_data, w_strb, w_valid, input w_ready,
    input  b_valid, output b_ready,
    output ar_addr,  ar_valid, input ar_ready,
    input r_data,  r_valid, output r_ready
  );

  modport Slave (
    input aw_addr, aw_valid, output aw_ready,
    input w_data, w_strb, w_valid, output w_ready,
    output  b_valid, input b_ready,
    input ar_addr,  ar_valid, output ar_ready,
    output r_data,  r_valid, input r_ready
  );

    function reset_master();
        // Write
        aw_valid <= 1'b0;
        aw_addr <= 0;
        w_data <= 0;
        w_strb <= 32'h000000ff;
        w_valid <= 1'b0;

        
        // Resp 
        b_ready <= 1'b1;
        r_ready <= 1'b1;

        // Read
        ar_valid = 1'b0; 

    endfunction
  
    // task master_write(input clk,
    task master_single_write(input addr_t address,input data_t data);
        aw_valid    <= 1'b1;
        aw_addr     <= address;
        w_data      <= data;
        w_valid     <= 1'b1;
    endtask
    
    task master_write_done();
        aw_valid <= 1'b0;
        w_valid <= 1'b0;
    endtask
    
    task master_read(input addr_t address);
        ar_valid    <= 1'b1;
        ar_addr     <= address;
    endtask
    task master_read_done();
        ar_valid    <= 1'b0;
    endtask

    // Verification helpers
    `ifdef SIMULATION
    task automatic  v_master_write(ref clk,input addr_t address,input data_t data);
        @(posedge clk);
        master_single_write(address,data);
        @(posedge clk);
        wait(aw_ready == 1);
        master_write_done();
        @(posedge clk);
    endtask
    task automatic  v_master_read(ref clk,input addr_t address);
        @(posedge clk);
        master_read(address);
        @(posedge clk);
        wait(ar_ready == 1);
        master_read_done();
        @(posedge clk);
        //data = r_data;
    endtask
    `endif

endinterface



`endif 