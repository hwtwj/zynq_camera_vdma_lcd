
`timescale 1 ns / 1 ps

	module xil_vip_v1_0_S00_AXI #
	(
		// Users to add parameters here
		parameter BITS = 8,
		parameter WIDTH = 1280,
		parameter HEIGHT = 960,
		parameter FEATURE_FULL = 0, //全特性开启(会降低频率)
		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 6
	)
	(
		// Users to add ports here
		input pclk,
		input rst_n,

		input in_href,
		input in_vsync,
		input [BITS*3-1:0] in_yuv,
		
		output out_pclk,
		output out_href,
		output out_vsync,
		output [BITS*3-1:0] out_rgb,

		output irq,
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 3;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 16
	localparam REG_RESET = 0;
	localparam REG_TOP_EN = 1;
	localparam REG_EQU_MIN = 2;
	localparam REG_EQU_MAX = 3;
	localparam REG_CROP_X = 4;
	localparam REG_CROP_Y = 5;
	localparam REG_CROP_W = 6;
	localparam REG_CROP_H = 7;
	localparam REG_DSCALE_H = 8;
	localparam REG_DSCALE_V = 9;
	localparam REG_INT_STATUS = 10;
	localparam REG_INT_MASK = 11;
	
	reg module_reset;
	reg hist_equ_en, sobel_en, yuv2rgb_en, crop_en, dscale_en;

	reg [15:0] crop_x;
	reg [15:0] crop_y;
	reg [15:0] crop_w;
	reg [15:0] crop_h;
	reg [BITS-1:0] equ_min;
	reg [BITS-1:0] equ_max;
	reg [3:0] dscale_h;
	reg [3:0] dscale_v;

	reg int_frame_done;
	reg int_mask_frame_done;
	
	assign irq = int_frame_done&(~int_mask_frame_done);

	reg prev_vsync;
	always @ (posedge S_AXI_ACLK) prev_vsync <= out_vsync;

	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;
	reg	 aw_en;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      aw_en <= 1'b1;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	          aw_en <= 1'b0;
	        end
	        else if (S_AXI_BREADY && axi_bvalid)
	            begin
	              aw_en <= 1'b1;
	              axi_awready <= 1'b0;
	            end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
			module_reset <= 1;
			hist_equ_en <= 0;
			sobel_en <= 0;
			yuv2rgb_en <= 1;
			crop_en <= 0;
			dscale_en <= 0;
			equ_min <= 8'd40 << (BITS-8);
			equ_max <= 8'd220 << (BITS-8);
			crop_x <= 0;
			crop_y <= 0;
			crop_w <= WIDTH;
			crop_h <= HEIGHT;
			dscale_h <= 4'd1;//1/2
			dscale_v <= 4'd1;//1/2
			int_frame_done <= 0;
			int_mask_frame_done <= 1;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
				REG_RESET: module_reset <= S_AXI_WDATA[0];
				REG_TOP_EN: {dscale_en, crop_en, yuv2rgb_en, sobel_en, hist_equ_en} <= S_AXI_WDATA[4:0];
				REG_EQU_MIN: equ_min <= S_AXI_WDATA[BITS-1:0];
				REG_EQU_MAX: equ_max <= S_AXI_WDATA[BITS-1:0];
				REG_CROP_X: crop_x <= S_AXI_WDATA[15:0];
				REG_CROP_Y: crop_y <= S_AXI_WDATA[15:0];
				REG_CROP_W: crop_w <= S_AXI_WDATA[15:0];
				REG_CROP_H: crop_h <= S_AXI_WDATA[15:0];
				REG_DSCALE_H: dscale_h <= S_AXI_WDATA[3:0];
				REG_DSCALE_V: dscale_v <= S_AXI_WDATA[3:0];
				REG_INT_STATUS: int_frame_done <= 1'd0;
				REG_INT_MASK: int_mask_frame_done <= S_AXI_WDATA[0];
				default:;
	        endcase
	      end
		if (out_vsync & (~prev_vsync)) int_frame_done <= 1'b1;
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
			REG_RESET: reg_data_out <= {31'd0, module_reset};
			REG_TOP_EN: reg_data_out <= {27'd0, dscale_en, crop_en, yuv2rgb_en, sobel_en, hist_equ_en};
			REG_EQU_MIN: reg_data_out <= equ_min;
			REG_EQU_MAX: reg_data_out <= equ_max;
			REG_CROP_X: reg_data_out <= {16'd0, crop_x};
			REG_CROP_Y: reg_data_out <= {16'd0, crop_y};
			REG_CROP_W: reg_data_out <= {16'd0, crop_w};
			REG_CROP_H: reg_data_out <= {16'd0, crop_h};
			REG_DSCALE_H: reg_data_out <= {28'd0, dscale_h};
			REG_DSCALE_V: reg_data_out <= {28'd0, dscale_v};
			REG_INT_STATUS: reg_data_out <= {31'd0, int_frame_done};
			REG_INT_MASK: reg_data_out <= {31'd0, int_mask_frame_done};
			default: reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here
	// shadow config registers
	reg s_module_reset;
	reg s_hist_equ_en, s_sobel_en, s_yuv2rgb_en, s_crop_en, s_dscale_en;

	reg [15:0] s_crop_x;
	reg [15:0] s_crop_y;
	reg [15:0] s_crop_w;
	reg [15:0] s_crop_h;
	reg [BITS-1:0] s_equ_min;
	reg [BITS-1:0] s_equ_max;
	reg [3:0] s_dscale_h;
	reg [3:0] s_dscale_v;

	reg prev_vsync_r;
	always @ (posedge pclk) prev_vsync_r <= in_vsync;

	wire frame_start = (~in_vsync) & prev_vsync_r;
	wire reset_n = rst_n & (~s_module_reset);

	always @ (posedge pclk) begin
		s_module_reset <= module_reset;
		if (frame_start) begin
			s_hist_equ_en <= FEATURE_FULL ? hist_equ_en : 0;
			s_sobel_en <= sobel_en;
			s_yuv2rgb_en <= yuv2rgb_en;
			s_crop_en <= crop_en;
			s_dscale_en <= dscale_en;
			s_equ_min <= equ_min;
			s_equ_max <= equ_max;
			s_crop_x <= crop_x;
			s_crop_y <= crop_y;
			s_crop_w <= crop_w;
			s_crop_h <= crop_h;
			s_dscale_h <= dscale_h;
			s_dscale_v <= dscale_v;
		end
		else begin
			s_hist_equ_en <= s_hist_equ_en;
			s_sobel_en <= s_sobel_en;
			s_yuv2rgb_en <= s_yuv2rgb_en;
			s_crop_en <= s_crop_en;
			s_dscale_en <= s_dscale_en;
			s_equ_min <= s_equ_min;
			s_equ_max <= s_equ_max;
			s_crop_x <= s_crop_x;
			s_crop_y <= s_crop_y;
			s_crop_w <= s_crop_w;
			s_crop_h <= s_crop_h;
			s_dscale_h <= s_dscale_h;
			s_dscale_v <= s_dscale_v;
		end
	end

	vip_top #(BITS, WIDTH, HEIGHT) vip_top_i0 (
			.pclk(pclk),
			.rst_n(reset_n),
			
			.in_href(in_href),
			.in_vsync(in_vsync),
			.in_y(in_yuv[(BITS*2)+:BITS]),
			.in_u(in_yuv[(BITS*1)+:BITS]),
			.in_v(in_yuv[(BITS*0)+:BITS]),
			
			.out_pclk(out_pclk),
			.out_href(out_href),
			.out_vsync(out_vsync),
			.out_r(out_rgb[(BITS*2)+:BITS]),
			.out_g(out_rgb[(BITS*1)+:BITS]),
			.out_b(out_rgb[(BITS*0)+:BITS]),
			
			.hist_equ_en(s_hist_equ_en),
			.sobel_en(s_sobel_en),
			.yuv2rgb_en(s_yuv2rgb_en),
			.crop_en(s_crop_en),
			.dscale_en(s_dscale_en),
			.equ_min(s_equ_min),
			.equ_max(s_equ_max),
			.crop_x(s_crop_x),
			.crop_y(s_crop_y),
			.crop_w(s_crop_w),
			.crop_h(s_crop_h),
			.dscale_h(s_dscale_h),
			.dscale_v(s_dscale_v)
		);
	// User logic ends

	endmodule
