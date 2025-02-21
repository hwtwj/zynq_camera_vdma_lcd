
`timescale 1 ns / 1 ps

`define DVP_RAW_1280x960_30_56MHz 1

	module xil_camif_v1_0 #
	(
		// Users to add parameters here
		parameter BITS = 8,
`ifdef DVP_RAW_1280x960_30_56MHz
		parameter COLORBAR_H_FRONT = 100,
		parameter COLORBAR_H_PULSE = 416,
		parameter COLORBAR_H_BACK = 100,
		parameter COLORBAR_H_DISP = 1280,
		parameter COLORBAR_V_FRONT = 2,
		parameter COLORBAR_V_PULSE = 20,
		parameter COLORBAR_V_BACK = 2,
		parameter COLORBAR_V_DISP = 960,
`endif
`ifdef DVP_RAW_960x544_30_56MHz
		parameter COLORBAR_H_FRONT = 200,
		parameter COLORBAR_H_PULSE = 536,
		parameter COLORBAR_H_BACK = 200,
		parameter COLORBAR_H_DISP = 960,
		parameter COLORBAR_V_FRONT = 100,
		parameter COLORBAR_V_PULSE = 240,
		parameter COLORBAR_V_BACK = 100,
		parameter COLORBAR_V_DISP = 544,
`endif
		parameter COLORBAR_BAYER = 0, //0:RGGB 1:GRBG 2:GBRG 3:BGGR
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here
		output            irq,

		input cam_xclk,
		input cam_pclk,
		input cam_href,
		input cam_vsync,
		input [BITS-1:0] cam_data,

		output out_pclk,
		output out_href,
		output out_vsync,
		output [BITS-1:0] out_raw,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	xil_camif_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
		.BITS              (BITS            ),
		.COLORBAR_H_FRONT  (COLORBAR_H_FRONT),
		.COLORBAR_H_PULSE  (COLORBAR_H_PULSE),
		.COLORBAR_H_BACK   (COLORBAR_H_BACK ),
		.COLORBAR_H_DISP   (COLORBAR_H_DISP ),
		.COLORBAR_V_FRONT  (COLORBAR_V_FRONT),
		.COLORBAR_V_PULSE  (COLORBAR_V_PULSE),
		.COLORBAR_V_BACK   (COLORBAR_V_BACK ),
		.COLORBAR_V_DISP   (COLORBAR_V_DISP ),
		.COLORBAR_BAYER    (COLORBAR_BAYER  )
	) xil_camif_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		.irq         (irq       ),
		.cam_xclk    (cam_xclk ),
		.cam_pclk    (cam_pclk ),
		.cam_href    (cam_href ),
		.cam_vsync   (cam_vsync),
		.cam_data      (cam_data   ),
		.out_pclk    (out_pclk  ),
		.out_href    (out_href  ),
		.out_vsync   (out_vsync ),
		.out_raw     (out_raw   )
	);

	// Add user logic here

	// User logic ends

	endmodule
