vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_4
vlib modelsim_lib/msim/processing_system7_vip_v1_0_6
vlib modelsim_lib/msim/xlconstant_v1_1_5
vlib modelsim_lib/msim/xlconcat_v2_1_1
vlib modelsim_lib/msim/lib_cdc_v1_0_2
vlib modelsim_lib/msim/proc_sys_reset_v5_0_13
vlib modelsim_lib/msim/smartconnect_v1_0
vlib modelsim_lib/msim/generic_baseblocks_v2_1_0
vlib modelsim_lib/msim/axi_register_slice_v2_1_18
vlib modelsim_lib/msim/fifo_generator_v13_2_3
vlib modelsim_lib/msim/axi_data_fifo_v2_1_17
vlib modelsim_lib/msim/axi_crossbar_v2_1_19
vlib modelsim_lib/msim/axi_lite_ipif_v3_0_4
vlib modelsim_lib/msim/v_tc_v6_1_13
vlib modelsim_lib/msim/v_vid_in_axi4s_v4_0_9
vlib modelsim_lib/msim/v_axi4s_vid_out_v4_0_10
vlib modelsim_lib/msim/lib_pkg_v1_0_2
vlib modelsim_lib/msim/lib_fifo_v1_0_12
vlib modelsim_lib/msim/blk_mem_gen_v8_4_2
vlib modelsim_lib/msim/lib_bmg_v1_0_11
vlib modelsim_lib/msim/lib_srl_fifo_v1_0_2
vlib modelsim_lib/msim/axi_datamover_v5_1_20
vlib modelsim_lib/msim/axi_vdma_v6_3_6
vlib modelsim_lib/msim/interrupt_control_v3_1_4
vlib modelsim_lib/msim/axi_iic_v2_0_21
vlib modelsim_lib/msim/axi_intc_v4_1_12
vlib modelsim_lib/msim/axi_protocol_converter_v2_1_18

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_4 modelsim_lib/msim/axi_vip_v1_1_4
vmap processing_system7_vip_v1_0_6 modelsim_lib/msim/processing_system7_vip_v1_0_6
vmap xlconstant_v1_1_5 modelsim_lib/msim/xlconstant_v1_1_5
vmap xlconcat_v2_1_1 modelsim_lib/msim/xlconcat_v2_1_1
vmap lib_cdc_v1_0_2 modelsim_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 modelsim_lib/msim/proc_sys_reset_v5_0_13
vmap smartconnect_v1_0 modelsim_lib/msim/smartconnect_v1_0
vmap generic_baseblocks_v2_1_0 modelsim_lib/msim/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_18 modelsim_lib/msim/axi_register_slice_v2_1_18
vmap fifo_generator_v13_2_3 modelsim_lib/msim/fifo_generator_v13_2_3
vmap axi_data_fifo_v2_1_17 modelsim_lib/msim/axi_data_fifo_v2_1_17
vmap axi_crossbar_v2_1_19 modelsim_lib/msim/axi_crossbar_v2_1_19
vmap axi_lite_ipif_v3_0_4 modelsim_lib/msim/axi_lite_ipif_v3_0_4
vmap v_tc_v6_1_13 modelsim_lib/msim/v_tc_v6_1_13
vmap v_vid_in_axi4s_v4_0_9 modelsim_lib/msim/v_vid_in_axi4s_v4_0_9
vmap v_axi4s_vid_out_v4_0_10 modelsim_lib/msim/v_axi4s_vid_out_v4_0_10
vmap lib_pkg_v1_0_2 modelsim_lib/msim/lib_pkg_v1_0_2
vmap lib_fifo_v1_0_12 modelsim_lib/msim/lib_fifo_v1_0_12
vmap blk_mem_gen_v8_4_2 modelsim_lib/msim/blk_mem_gen_v8_4_2
vmap lib_bmg_v1_0_11 modelsim_lib/msim/lib_bmg_v1_0_11
vmap lib_srl_fifo_v1_0_2 modelsim_lib/msim/lib_srl_fifo_v1_0_2
vmap axi_datamover_v5_1_20 modelsim_lib/msim/axi_datamover_v5_1_20
vmap axi_vdma_v6_3_6 modelsim_lib/msim/axi_vdma_v6_3_6
vmap interrupt_control_v3_1_4 modelsim_lib/msim/interrupt_control_v3_1_4
vmap axi_iic_v2_0_21 modelsim_lib/msim/axi_iic_v2_0_21
vmap axi_intc_v4_1_12 modelsim_lib/msim/axi_intc_v4_1_12
vmap axi_protocol_converter_v2_1_18 modelsim_lib/msim/axi_protocol_converter_v2_1_18

vlog -work xilinx_vip -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_4 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/98af/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_6 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_processing_system7_0_0/sim/design_1_processing_system7_0_0.v" \

vlog -work xlconstant_v1_1_5 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/4649/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_cmos_pwdn_0/sim/design_1_cmos_pwdn_0.v" \
"../../../bd/design_1/ip/design_1_cmos_rst_n_0/sim/design_1_cmos_rst_n_0.v" \

vlog -work xlconcat_v2_1_1 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_xlconcat_0_0/sim/design_1_xlconcat_0_0.v" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/sim/bd_afc3.v" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_0/sim/bd_afc3_one_0.v" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_1/sim/bd_afc3_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/c012/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_2/sim/bd_afc3_arsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_3/sim/bd_afc3_rsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_4/sim/bd_afc3_awsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_5/sim/bd_afc3_wsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_6/sim/bd_afc3_bsw_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/f85e/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_7/sim/bd_afc3_s00mmu_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ca72/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_8/sim/bd_afc3_s00tr_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/9ade/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_9/sim/bd_afc3_s00sic_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b89e/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_10/sim/bd_afc3_s00a2s_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_11/sim/bd_afc3_sarn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_12/sim/bd_afc3_srn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_13/sim/bd_afc3_s01mmu_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_14/sim/bd_afc3_s01tr_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_15/sim/bd_afc3_s01sic_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_16/sim/bd_afc3_s01a2s_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_17/sim/bd_afc3_sawn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_18/sim/bd_afc3_swn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_19/sim/bd_afc3_sbn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_20/sim/bd_afc3_s02mmu_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_21/sim/bd_afc3_s02tr_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_22/sim/bd_afc3_s02sic_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_23/sim/bd_afc3_s02a2s_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_24/sim/bd_afc3_sarn_1.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_25/sim/bd_afc3_srn_1.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_26/sim/bd_afc3_s03mmu_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_27/sim/bd_afc3_s03tr_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_28/sim/bd_afc3_s03sic_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_29/sim/bd_afc3_s03a2s_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_30/sim/bd_afc3_sawn_1.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_31/sim/bd_afc3_swn_1.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_32/sim/bd_afc3_sbn_1.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_33/sim/bd_afc3_s04mmu_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_34/sim/bd_afc3_s04tr_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_35/sim/bd_afc3_s04sic_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_36/sim/bd_afc3_s04a2s_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_37/sim/bd_afc3_sarn_2.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_38/sim/bd_afc3_srn_2.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_39/sim/bd_afc3_s05mmu_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_40/sim/bd_afc3_s05tr_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_41/sim/bd_afc3_s05sic_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_42/sim/bd_afc3_s05a2s_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_43/sim/bd_afc3_sawn_2.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_44/sim/bd_afc3_swn_2.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_45/sim/bd_afc3_sbn_2.sv" \

vlog -work smartconnect_v1_0 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/7005/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_46/sim/bd_afc3_m00s2a_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_47/sim/bd_afc3_m00arn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_48/sim/bd_afc3_m00rn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_49/sim/bd_afc3_m00awn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_50/sim/bd_afc3_m00wn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_51/sim/bd_afc3_m00bn_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b387/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_52/sim/bd_afc3_m00e_0.sv" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/sim/design_1_axi_smc_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_rst_ps7_0_100M_0/sim/design_1_rst_ps7_0_100M_0.vhd" \

vlog -work generic_baseblocks_v2_1_0 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_18 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/cc23/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_3 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/64f4/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_3 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_3 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_17 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/c4fd/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_19 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/6c9d/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_xbar_0/sim/design_1_xbar_0.v" \
"../../../bd/design_1/ip/design_1_lcd_bl_0/sim/design_1_lcd_bl_0.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_1_0/design_1_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_1_0/design_1_clk_wiz_1_0.v" \
"../../../bd/design_1/ipshared/31a1/src/asyn_rst_syn.v" \
"../../../bd/design_1/ipshared/31a1/src/dvi_encoder.v" \
"../../../bd/design_1/ipshared/31a1/src/serializer_10_to_1.v" \
"../../../bd/design_1/ipshared/31a1/src/dvi_transmitter_top.v" \
"../../../bd/design_1/ip/design_1_DVI_Transmitter_0_0/sim/design_1_DVI_Transmitter_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work v_tc_v6_1_13 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/a92c/hdl/v_tc_v6_1_vh_rfs.vhd" \

vlog -work v_vid_in_axi4s_v4_0_9 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2aa/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \

vlog -work v_axi4s_vid_out_v4_0_10 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/a87e/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_v_axi4s_vid_out_2_0/sim/design_1_v_axi4s_vid_out_2_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_v_tc_2_0/sim/design_1_v_tc_2_0.vhd" \

vcom -work lib_pkg_v1_0_2 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_fifo_v1_0_12 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/544a/hdl/lib_fifo_v1_0_rfs.vhd" \

vlog -work blk_mem_gen_v8_4_2 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/37c2/simulation/blk_mem_gen_v8_4.v" \

vcom -work lib_bmg_v1_0_11 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/556c/hdl/lib_bmg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_20 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/dfb3/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vlog -work axi_vdma_v6_3_6 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl/axi_vdma_v6_3_rfs.v" \

vcom -work axi_vdma_v6_3_6 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl/axi_vdma_v6_3_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_axi_vdma_2_0/sim/design_1_axi_vdma_2_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_v_vid_in_axi4s_2_0/sim/design_1_v_vid_in_axi4s_2_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_v_tc_1_0/sim/design_1_v_tc_1_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_vdma_1_0/sim/design_1_axi_vdma_1_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_v_vid_in_axi4s_1_0/sim/design_1_v_vid_in_axi4s_1_0.v" \
"../../../bd/design_1/ip/design_1_v_axi4s_vid_out_1_0/sim/design_1_v_axi4s_vid_out_1_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_axi_vdma_0_0/sim/design_1_axi_vdma_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_v_vid_in_axi4s_0_0/sim/design_1_v_vid_in_axi4s_0_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_v_tc_0_0/sim/design_1_v_tc_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_v_axi4s_vid_out_0_0/sim/design_1_v_axi4s_vid_out_0_0.v" \

vcom -work interrupt_control_v3_1_4 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/a040/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_iic_v2_0_21 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/304c/hdl/axi_iic_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_axi_iic_0/sim/design_1_axi_iic_0.vhd" \

vcom -work axi_intc_v4_1_12 -64 -93 \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/31e4/hdl/axi_intc_v4_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_axi_intc_0_0/sim/design_1_axi_intc_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ipshared/xil_isp_lite_1.0/hdl/isp_lite/isp_utils.v" \
"../../../bd/design_1/ipshared/48bb/hdl/vip/vip_crop.v" \
"../../../bd/design_1/ipshared/48bb/hdl/vip/vip_dscale.v" \
"../../../bd/design_1/ipshared/48bb/hdl/vip/vip_hist_equ.v" \
"../../../bd/design_1/ipshared/48bb/hdl/vip/vip_sobel.v" \
"../../../bd/design_1/ipshared/48bb/hdl/vip/vip_top.v" \
"../../../bd/design_1/ipshared/48bb/hdl/vip/vip_yuv2rgb.v" \
"../../../bd/design_1/ipshared/48bb/hdl/xil_vip_v1_0_S00_AXI.v" \
"../../../bd/design_1/ipshared/48bb/hdl/xil_vip_v1_0.v" \
"../../../bd/design_1/ip/design_1_xil_vip_0_0/sim/design_1_xil_vip_0_0.v" \
"../../../bd/design_1/ip/design_1_xil_vip_1_0/sim/design_1_xil_vip_1_0.v" \
"../../../bd/design_1/ipshared/c5cf/hdl/dvp_raw_timing_colorbar.v" \
"../../../bd/design_1/ipshared/c5cf/hdl/xil_camif_v1_0_S00_AXI.v" \
"../../../bd/design_1/ipshared/c5cf/hdl/xil_camif_v1_0.v" \
"../../../bd/design_1/ip/design_1_xil_camif_0_0/sim/design_1_xil_camif_0_0.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_blc.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_bnr.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_ccm.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_csc.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_demosaic.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_dgain.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_dpc.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_ee.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_gamma.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_stat_ae.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_stat_awb.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_top.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/isp_lite/isp_wb.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/xil_isp_lite_v1_0_S00_AXI.v" \
"../../../bd/design_1/ipshared/5ebd/hdl/xil_isp_lite_v1_0.v" \
"../../../bd/design_1/ip/design_1_xil_isp_lite_0_0/sim/design_1_xil_isp_lite_0_0.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work axi_protocol_converter_v2_1_18 -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/7a04/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/70cf/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/979d/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/b2d0/hdl/verilog" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ipshared/58e2/hdl" "+incdir+../../../../zynq_camera_vdma_lcd.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

