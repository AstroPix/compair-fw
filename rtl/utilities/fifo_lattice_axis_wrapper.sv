/**

Wrapper to use Lattice FIFO with axis signals
tlast , read and write data count not supported yet
*/
module  fifo_lattice_axis_wrapper #(parameter DWIDTH=8,parameter AWIDTH=8) (

    // Write interface -> AXIS Slave
    input  wire                 s_axis_aclk,
    input  wire                 s_axis_aresetn,
    input  wire [DWIDTH-1:0]    s_axis_tdata,
    input  wire                 s_axis_tvalid,
    output wire                 s_axis_tready,

    input  wire                 s_axis_tlast,
    output wire [31:0]          axis_wr_data_count,


    // Read interface -> AXIS Master
    input  wire                 m_axis_aclk,
    output logic [DWIDTH-1:0]    m_axis_tdata,
    input  wire                 m_axis_tready,
    output logic                 m_axis_tvalid,

    output wire                 m_axis_tlast,
    output wire [31:0]          axis_rd_data_count

   
);


    // Instantiate
    //-------------------
    /*wire empty;
    wire full;
    assign m_axis_tvalid = !empty;
    assign s_axis_tready = !full;

   
    fifo_2clk_64e fifo (
        .wr_clk_i   (s_axis_aclk),
        .rd_clk_i   (m_axis_aclk),
        .rst_i      (!s_axis_aresetn),
        .rp_rst_i   (!s_axis_aresetn ),

        .wr_en_i    (s_axis_tvalid),
        .wr_data_i  (s_axis_tdata),
        .full_o     (full),

        .rd_en_i    (m_axis_tready),
        .rd_data_o  (m_axis_tdata),
        .empty_o    (empty )
        
        .almost_full_o( ),
        .almost_empty_o( )
        
    );
    */

    /**
        Make the AXIS output stage as replacement for FWFT mode

    */
    /*wire empty;
    wire full;
    //assign m_axis_tvalid = !empty;
    assign s_axis_tready = !full;

    // FIFO Read
    wire [DWIDTH-1:0] fifo_data;
    reg fifo_read;
    reg fifo_read_data_valid;
    wire almost_empty;
    wire fifo_read_valid = fifo_read && !empty;
    

    // AXIS state
    wire axis_master_stage_stalled = m_axis_tvalid && !m_axis_tready;
    wire axis_master_stage_valid = m_axis_tvalid && m_axis_tready;

    // The output stage will be free, so we can read and keep working
    wire axis_master_stage_free_next = !m_axis_tvalid || axis_master_stage_valid;

    always @(posedge m_axis_aclk) begin
        if (!s_axis_aresetn) begin
            fifo_read <= 1'b0;
            fifo_read_data_valid <= 1'b0;
            m_axis_tvalid <= 1'b0;
        end
        else begin
            
            // FIFO
            //-----------

            // Data is valid after read
            //if (fifo_read_valid)
            //    m_axis_tvalid <= 1'b1;
            //else if (axis_master_stage_valid && empty ) begin
            //    m_axis_tvalid <= 1'b0;
            //end
            if (fifo_read_data_valid)
                m_axis_tvalid <= 1'b1;
            else if (axis_master_stage_valid && !fifo_read_data_valid ) begin
                m_axis_tvalid <= 1'b0;
            end

            // Data valid
            fifo_read_data_valid <= axis_master_stage_stalled ?fifo_read_data_valid : fifo_read;
            if (fifo_read_data_valid && !axis_master_stage_stalled) begin 
                m_axis_tdata <= fifo_data;
            end

            // Read empty ||
            // 1: if fifo empty
            // 1: if fifo data is valid and output stage is not stalled
   
            if (!empty && axis_master_stage_free_next && !(fifo_read && almost_empty) ) begin //&& !(fifo_read && !m_axis_tready)
                fifo_read <= 1'b1;
            end 
            else begin
                fifo_read <= 1'b0;
            end

            
        end
    end
   
    fifo_2clk_64e fifo (
        .wr_clk_i   (s_axis_aclk),
        .rd_clk_i   (m_axis_aclk),
        .rst_i      (!s_axis_aresetn),
        .rp_rst_i   (!s_axis_aresetn ),

        .wr_en_i    (s_axis_tvalid),
        .wr_data_i  (s_axis_tdata),
        .full_o     (full),

        .rd_en_i    (fifo_read),
        .rd_data_o  (fifo_data),
        .empty_o    (empty ),
        
        //.almost_full_o( ),
        .almost_empty_o(almost_empty )
        
    );*/


    // DC Fifo in normal read mode, with a small FWFT single clock cache fifo for the read path
    //-----------------------------
    wire [DWIDTH-1:0] fifo_data;
    reg fifo_read;
    reg fifo_read_data_valid;
    wire empty, almost_empty,full;
    assign s_axis_tready = !full;
    fifo_2clk_64e fifo (
        .wr_clk_i   (s_axis_aclk),
        .rd_clk_i   (m_axis_aclk),
        .rst_i      (!s_axis_aresetn),
        .rp_rst_i   (!s_axis_aresetn ),

        .wr_en_i    (s_axis_tvalid),
        .wr_data_i  (s_axis_tdata),
        .full_o     (full),

        .rd_en_i    (fifo_read),
        .rd_data_o  (fifo_data),
        .empty_o    (empty ),
        
        //.almost_full_o( ),
        .almost_empty_o(almost_empty )
        
    );

    //-- Read path Caching FIFO
    wire [DWIDTH-1:0] cache_fifo_data_out;
    reg cache_fifo_write;
    wire cache_fifo_read;
    wire cache_fifo_almost_empty, cache_fifo_almost_full,cache_fifo_empty,cache_fifo_full;
    assign m_axis_tvalid = !cache_fifo_empty;
    mini_fwft_fifo # (
    .AWIDTH(2),.DWIDTH(DWIDTH)
    )
    read_cache_fifo (
        .clk(m_axis_aclk),
        .resn(s_axis_aresetn),
        .full(cache_fifo_full),
        .almost_full(cache_fifo_almost_full),
        .empty(cache_fifo_empty),
        .almost_empty(cache_fifo_almost_empty),
        .write(fifo_read_data_valid),
        .read(m_axis_tready),
        .data_in(fifo_data),
        .data_out(m_axis_tdata)
    );
    
    //-- DC_FIFo to cache FIFO path
    always @(posedge m_axis_aclk) begin
        if (!s_axis_aresetn) begin
            cache_fifo_write <= 1'b0;
            fifo_read <= 1'b0;
            fifo_read_data_valid <= 1'b0;
        end
        else begin
            
            fifo_read_data_valid <= cache_fifo_full ? fifo_read_data_valid : fifo_read;

            // If Source FIFO Is not empty, write to cache fifo
            if (!empty && !(fifo_read && almost_empty) && !(cache_fifo_almost_full && !m_axis_tready)  ) begin
                fifo_read <= 1'b1;
            end 
            else begin
                fifo_read <= 1'b0;
            end

        end
    end



    GSR GSR_INST ( .GSR_N(1'b1), .CLK(m_axis_aclk));


endmodule