#include "stdio.h"
#include "xparameters.h"
#include "xaxivdma.h"
#include "xaxivdma_i.h"
#include "xil_cache.h"
#include "xil_io.h"
#include "xtime_l.h"
#include "xgpiops.h"
#include "sleep.h"

#include "sys_intr.h"
#include "vdma_api.h"

#include "ov5640_init.h"
#include "xil_camif.h"
#include "xil_isp_lite.h"
#include "xil_vip.h"

#define ISP_BITS		9
#define CAM_WIDTH 		2560
#define CAM_HEIGHT 		1920

#define LCD_WIDTH 		800
#define LCD_HEIGHT 		480
#define DVI_WIDTH 		1280
#define DVI_HEIGHT 		720

#define  GPIOPS_ID  XPAR_XGPIOPS_0_DEVICE_ID  //PS 端 GPIO 器件 ID
XGpioPs  gpiops_inst; //PS 端 GPIO 驱动实例
#define PS_KEY0		(12)
#define PS_KEY1		(11)
#define PL_RESET	(54)
#define PL_KEY0		(55)
#define PL_KEY1		(56)
#define PS_LED0		(7)
#define PS_LED1		(8)
#define PL_LED0		(57)
#define PL_LED1		(58)

static volatile unsigned cam_frame_int = 0;
static void camif_isr(UINTPTR isr_context)
{
	XIL_CAMIF_mWriteReg(isr_context, CAMIF_REG_INT_STATUS, 0);
	cam_frame_int ++;
	{
		static int led = 0;
		XGpioPs_WritePin(&gpiops_inst, PL_LED0, led);
		led = !led;
	}
}

static volatile unsigned isp_frame_int = 0;
static void isp_isr(UINTPTR isr_context)
{
	XIL_ISP_LITE_mWriteReg(isr_context, ISP_REG_INT_STATUS, 0);
	isp_frame_int ++;
	{
		static int led = 0;
		XGpioPs_WritePin(&gpiops_inst, PL_LED1, led);
		led = !led;
	}
}

static volatile unsigned vip_frame_int = 0;
static void vip_isr(UINTPTR isr_context)
{
	XIL_VIP_mWriteReg(isr_context, VIP_REG_INT_STATUS, 0);
	vip_frame_int ++;
	{
		static int led = 0;
		XGpioPs_WritePin(&gpiops_inst, PS_LED0, led);
		led = !led;
	}
}

#define CAMIF_BASE      XPAR_XIL_CAMIF_0_S00_AXI_BASEADDR
#define ISP_BASE        XPAR_XIL_ISP_LITE_0_S00_AXI_BASEADDR
#define VIP_LCD_BASE    XPAR_XIL_VIP_0_S00_AXI_BASEADDR
#define VIP_DVI_BASE    XPAR_XIL_VIP_1_S00_AXI_BASEADDR

//中断初始化
int camera_intr_init()
{
#ifdef XPAR_INTC_0_DEVICE_ID
	XIntc *intc = sys_intr_inst();
	XIntc_Connect(intc, XPAR_AXI_INTC_0_XIL_CAMIF_0_IRQ_INTR, (XInterruptHandler) camif_isr, (void*)CAMIF_BASE);
	XIntc_Connect(intc, XPAR_AXI_INTC_0_XIL_ISP_LITE_0_IRQ_INTR, (XInterruptHandler) isp_isr, (void*)ISP_BASE);
	XIntc_Connect(intc, XPAR_AXI_INTC_0_XIL_VIP_0_IRQ_INTR, (XInterruptHandler) vip_isr, (void*)VIP_LCD_BASE);
	XIntc_Connect(intc, XPAR_AXI_INTC_0_XIL_VIP_1_IRQ_INTR, (XInterruptHandler) vip_isr, (void*)VIP_DVI_BASE);
	XIntc_Enable(intc, XPAR_AXI_INTC_0_XIL_CAMIF_0_IRQ_INTR);
	XIntc_Enable(intc, XPAR_AXI_INTC_0_XIL_ISP_LITE_0_IRQ_INTR);
	XIntc_Enable(intc, XPAR_AXI_INTC_0_XIL_VIP_0_IRQ_INTR);
	XIntc_Enable(intc, XPAR_AXI_INTC_0_XIL_VIP_1_IRQ_INTR);
#else
	XScuGic *intc = sys_intr_inst();
    XScuGic_Connect(intc, XPAR_FABRIC_XIL_CAMIF_0_IRQ_INTR, (Xil_ExceptionHandler) camif_isr, (void*)CAMIF_BASE);
    XScuGic_Connect(intc, XPAR_FABRIC_XIL_ISP_LITE_0_IRQ_INTR, (Xil_ExceptionHandler) isp_isr, (void*)ISP_BASE);
    XScuGic_Connect(intc, XPAR_FABRIC_XIL_VIP_0_IRQ_INTR, (Xil_ExceptionHandler) vip_isr, (void*)VIP_LCD_BASE);
    XScuGic_Connect(intc, XPAR_FABRIC_XIL_VIP_1_IRQ_INTR, (Xil_ExceptionHandler) vip_isr, (void*)VIP_DVI_BASE);
    XScuGic_Enable(intc, XPAR_FABRIC_XIL_CAMIF_0_IRQ_INTR);
    XScuGic_Enable(intc, XPAR_FABRIC_XIL_ISP_LITE_0_IRQ_INTR);
    XScuGic_Enable(intc, XPAR_FABRIC_XIL_VIP_0_IRQ_INTR);
    XScuGic_Enable(intc, XPAR_FABRIC_XIL_VIP_1_IRQ_INTR);
#endif
    return XST_SUCCESS;
}


static void init_camif_isp_vip()
{
	XIL_CAMIF_mWriteReg(CAMIF_BASE, CAMIF_REG_RESET, 1);
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_RESET, 1);
	XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_RESET, 1);
	XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_RESET, 1);

	XIL_CAMIF_mWriteReg(CAMIF_BASE, CAMIF_REG_INT_MASK, 0xffff);
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_INT_MASK, 0xffff);
	XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_INT_MASK, 0xffff);
	XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_INT_MASK, 0xffff);
	usleep(100000);

	XIL_CAMIF_mWriteReg(CAMIF_BASE, CAMIF_REG_COLORBAR_EN, 0);

	unsigned int isp_top_en = 0;
	isp_top_en |= ISP_REG_TOP_EN_BIT_DPC_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_BLC_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_BNR_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_DGAIN_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_DEMOSIC_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_WB_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_CCM_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_CSC_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_GAMMA_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_EE_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_STAT_AE_EN;
	isp_top_en |= ISP_REG_TOP_EN_BIT_STAT_AWB_EN;
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_TOP_EN, isp_top_en);

	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_NR_LEVEL, 2);
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_DGAIN_GAIN, 0x10);//1.0x
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_DGAIN_OFFSET, 30<<(ISP_BITS-8));
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_STAT_AE_RECT_X, CAM_WIDTH/4);
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_STAT_AE_RECT_Y, CAM_HEIGHT/4);
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_STAT_AE_RECT_W, CAM_WIDTH/2);
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_STAT_AE_RECT_H, CAM_HEIGHT/2);

	//LCD VIP
	unsigned int vip_top_en = 0;
	unsigned scale_h = CAM_WIDTH / LCD_WIDTH;
	unsigned scale_v = CAM_HEIGHT / LCD_HEIGHT;
	//vip_top_en |= VIP_REG_TOP_EN_BIT_HIST_EQU_EN;
	//vip_top_en |= VIP_REG_TOP_EN_BIT_SOBEL_EN;
	vip_top_en |= VIP_REG_TOP_EN_BIT_YUV2RGB_EN;
	vip_top_en |= VIP_REG_TOP_EN_BIT_CROP_EN;
	if (scale_h > 1 && scale_v > 1) {
		vip_top_en |= VIP_REG_TOP_EN_BIT_DSCALE_EN;
	}
	XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_TOP_EN, vip_top_en);

	if (vip_top_en & VIP_REG_TOP_EN_BIT_DSCALE_EN) {
		unsigned scale_val = scale_h < scale_v ? scale_h : scale_v;
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_CROP_X, (CAM_WIDTH-LCD_WIDTH*scale_val)/2);
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_CROP_Y, (CAM_HEIGHT-LCD_HEIGHT*scale_val)/2);
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_CROP_W, LCD_WIDTH*scale_val);
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_CROP_H, LCD_HEIGHT*scale_val);
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_DSCALE_H, scale_val-1);
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_DSCALE_V, scale_val-1);
	} else {
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_CROP_X, (CAM_WIDTH-LCD_WIDTH)/2);
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_CROP_Y, (CAM_HEIGHT-LCD_HEIGHT)/2);
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_CROP_W, LCD_WIDTH);
		XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_CROP_H, LCD_HEIGHT);
	}

	//DVI VIP
	vip_top_en = 0;
	scale_h = CAM_WIDTH / DVI_WIDTH;
	scale_v = CAM_HEIGHT / DVI_HEIGHT;
	//vip_top_en |= VIP_REG_TOP_EN_BIT_HIST_EQU_EN;
	//vip_top_en |= VIP_REG_TOP_EN_BIT_SOBEL_EN;
	vip_top_en |= VIP_REG_TOP_EN_BIT_YUV2RGB_EN;
	vip_top_en |= VIP_REG_TOP_EN_BIT_CROP_EN;
	if (scale_h > 1 && scale_v > 1) {
		vip_top_en |= VIP_REG_TOP_EN_BIT_DSCALE_EN;
	}
	XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_TOP_EN, vip_top_en);
	XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_HIST_EQU_MIN, 20);
	XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_HIST_EQU_MAX, 200);

	if (vip_top_en & VIP_REG_TOP_EN_BIT_DSCALE_EN) {
		unsigned scale_val = scale_h < scale_v ? scale_h : scale_v;
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_CROP_X, (CAM_WIDTH-DVI_WIDTH*scale_val)/2);
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_CROP_Y, (CAM_HEIGHT-DVI_HEIGHT*scale_val)/2);
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_CROP_W, DVI_WIDTH*scale_val);
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_CROP_H, DVI_HEIGHT*scale_val);
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_DSCALE_H, scale_val-1);
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_DSCALE_V, scale_val-1);
	} else {
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_CROP_X, (CAM_WIDTH-DVI_WIDTH)/2);
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_CROP_Y, (CAM_HEIGHT-DVI_HEIGHT)/2);
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_CROP_W, DVI_WIDTH);
		XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_CROP_H, DVI_HEIGHT);
	}

	XIL_CAMIF_mWriteReg(CAMIF_BASE, CAMIF_REG_RESET, 0);
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_RESET, 0);
	XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_RESET, 0);
	XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_RESET, 0);
	printf("vi_reset  = %08lX\n", XIL_CAMIF_mReadReg(CAMIF_BASE, CAMIF_REG_RESET));
	printf("isp_reset = %08lX\n", XIL_ISP_LITE_mReadReg(ISP_BASE, ISP_REG_RESET));
	printf("vip_reset = %08lX\n", XIL_VIP_mReadReg(VIP_LCD_BASE, VIP_REG_RESET));
	printf("vip_reset = %08lX\n", XIL_VIP_mReadReg(VIP_DVI_BASE, VIP_REG_RESET));

	camera_intr_init();
	XIL_CAMIF_mWriteReg(CAMIF_BASE, CAMIF_REG_INT_MASK, ~0x1);
	XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_INT_MASK, ~ISP_REG_INT_MASK_BIT_FRAME_DONE);
	XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_INT_MASK, ~VIP_REG_INT_MASK_BIT_FRAME_DONE);
	XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_INT_MASK, ~VIP_REG_INT_MASK_BIT_FRAME_DONE);
}


static int cam_buff = XPAR_PS7_DDR_0_S_AXI_BASEADDR+0x1000000; //RAW8
static int lcd_buff = XPAR_PS7_DDR_0_S_AXI_BASEADDR+0x2000000; //RGB888
static int dvi_buff = XPAR_PS7_DDR_0_S_AXI_BASEADDR+0x3000000; //RGB888

#if 0
#include "ff.h"

static FATFS fatfs;                         //文件系统

//初始化文件系统
static int platform_init_fs()
{
	FRESULT status;
	TCHAR *Path = "0:/";
	BYTE work[FF_MAX_SS];

    //注册一个工作区(挂载分区文件系统)
    //在使用任何其它文件函数之前，必须使用f_mount函数为每个使用卷注册一个工作区
	status = f_mount(&fatfs, Path, 1);  //挂载SD卡
	if (status != FR_OK) {
		xil_printf("Volume is not FAT formated; formating FAT\r\n");
		return -1;
		//格式化SD卡
		status = f_mkfs(Path, FM_FAT32, 0, work, sizeof work);
		if (status != FR_OK) {
			xil_printf("Unable to format FATfs\r\n");
			return -1;
		}
		//格式化之后，重新挂载SD卡
		status = f_mount(&fatfs, Path, 1);
		if (status != FR_OK) {
			xil_printf("Unable to mount FATfs\r\n");
			return -1;
		}
	}
	return 0;
}

//SD卡写数据
static int sd_write_data(char *file_name,u32 src_addr,u32 byte_len)
{
    FIL fil;         //文件对象
    UINT bw;         //f_write函数返回已写入的字节数

    //打开一个文件,如果不存在，则创建一个文件
    f_open(&fil,file_name,FA_CREATE_ALWAYS | FA_WRITE);
    //移动打开的文件对象的文件读/写指针     0:指向文件开头
    f_lseek(&fil, 0);
    //向文件中写入数据
    f_write(&fil,(void*) src_addr,byte_len,&bw);
    //关闭文件
    f_close(&fil);
    return 0;
}
#endif

static int fs_init = 0;

static void gpio_init()
{
	XGpioPs_Config *gpiops_cfg_ptr; //PS 端 GPIO 配置信息

	//根据器件 ID 查找配置信息
	gpiops_cfg_ptr = XGpioPs_LookupConfig(GPIOPS_ID);
	//初始化器件驱动
	XGpioPs_CfgInitialize(&gpiops_inst, gpiops_cfg_ptr, gpiops_cfg_ptr->BaseAddr);

	//Gpio LED
	XGpioPs_SetDirectionPin(&gpiops_inst, PS_LED0, 1);
	XGpioPs_SetDirectionPin(&gpiops_inst, PS_LED1, 1);
	XGpioPs_SetDirectionPin(&gpiops_inst, PL_LED0, 1);
	XGpioPs_SetDirectionPin(&gpiops_inst, PL_LED1, 1);
	XGpioPs_SetOutputEnablePin(&gpiops_inst, PS_LED0, 1);
	XGpioPs_SetOutputEnablePin(&gpiops_inst, PS_LED1, 1);
	XGpioPs_SetOutputEnablePin(&gpiops_inst, PL_LED0, 1);
	XGpioPs_SetOutputEnablePin(&gpiops_inst, PL_LED1, 1);
	XGpioPs_WritePin(&gpiops_inst, PS_LED0, 1);
	XGpioPs_WritePin(&gpiops_inst, PS_LED1, 1);
	XGpioPs_WritePin(&gpiops_inst, PL_LED0, 1);
	XGpioPs_WritePin(&gpiops_inst, PL_LED1, 1);

	//Gpio KEY
	XGpioPs_SetDirectionPin(&gpiops_inst, PS_KEY0, 0);
	XGpioPs_SetDirectionPin(&gpiops_inst, PS_KEY1, 0);
	XGpioPs_SetDirectionPin(&gpiops_inst, PL_RESET, 0);
	XGpioPs_SetDirectionPin(&gpiops_inst, PL_KEY0, 0);
	XGpioPs_SetDirectionPin(&gpiops_inst, PL_KEY1, 0);
}

static void key_control()
{
	{
		static int reset = 0;
		if (reset != !XGpioPs_ReadPin(&gpiops_inst, PL_RESET)) {
			reset = !XGpioPs_ReadPin(&gpiops_inst, PL_RESET);
			printf("reset = %d\n", reset);
			XIL_CAMIF_mWriteReg(CAMIF_BASE, CAMIF_REG_RESET, reset);
			XIL_ISP_LITE_mWriteReg(ISP_BASE, ISP_REG_RESET, reset);
			XIL_VIP_mWriteReg(VIP_LCD_BASE, VIP_REG_RESET, reset);
			XIL_VIP_mWriteReg(VIP_DVI_BASE, VIP_REG_RESET, reset);
		}
	}
	if (fs_init && 0 == XGpioPs_ReadPin(&gpiops_inst, PL_KEY0)) {
		printf("writing dump_cam_raw.bin ... ");
		Xil_DCacheInvalidateRange(cam_buff, CAM_WIDTH * CAM_HEIGHT);
		//sd_write_data("dump_cam_raw.bin", cam_buff, CAM_WIDTH * CAM_HEIGHT);
		printf("done\n");
	}
	if (fs_init && 0 == XGpioPs_ReadPin(&gpiops_inst, PL_KEY1)) {
		printf("writing dump_dvi_rgb888.bin ... ");
		Xil_DCacheInvalidateRange(dvi_buff, DVI_WIDTH * DVI_HEIGHT * 3);
		//sd_write_data("dump_dvi_rgb888.bin", dvi_buff, DVI_WIDTH * DVI_HEIGHT * 3);
		printf("done\n");
	}
	if (fs_init && 0 == XGpioPs_ReadPin(&gpiops_inst, PS_KEY0)) {

	}
	{
		static int colorbar_en = 0;
		if (colorbar_en != !XGpioPs_ReadPin(&gpiops_inst, PS_KEY1)) {
			colorbar_en = !XGpioPs_ReadPin(&gpiops_inst, PS_KEY1);
			printf("colorbar_en = %d\n", colorbar_en);
			XIL_CAMIF_mWriteReg(CAMIF_BASE, CAMIF_REG_COLORBAR_EN, colorbar_en);
		}
	}

}

int main()
{
	XAxiVdma cam_vdma_inst;
	XAxiVdma lcd_vdma_inst;
	XAxiVdma dvi_vdma_inst;

	sys_intr_init();
	gpio_init();

//	fs_init = 0 == platform_init_fs();

	u32 status;
	u16 cmos_h_pixel = CAM_WIDTH;   //ov5640 DVP 输出水平像素点数
	u16 cmos_v_pixel = CAM_HEIGHT;   //ov5640 DVP 输出垂直像素点数
	u16 total_v_std = 0;

	status = ov5640_init(cmos_h_pixel, cmos_v_pixel, &total_v_std); //初始化ov5640
	if(status == 0)
		xil_printf("OV5640 detected successful!\r\n");
	else
		xil_printf("OV5640 detected failed!\r\n");

	xil_printf("cmos size %u x %u\r\n", cmos_h_pixel, cmos_v_pixel);
	cmos_set_exposure(total_v_std);
	cmos_set_gain(0x010);

	init_camif_isp_vip();

	run_triple_frame_buffer(&cam_vdma_inst, XPAR_AXIVDMA_0_DEVICE_ID,
			CAM_WIDTH, CAM_HEIGHT, cam_buff, 0, 0, BOTH);
	run_triple_frame_buffer(&lcd_vdma_inst, XPAR_AXIVDMA_1_DEVICE_ID,
			LCD_WIDTH, LCD_HEIGHT, lcd_buff, 0, 0, BOTH);
	run_triple_frame_buffer(&dvi_vdma_inst, XPAR_AXIVDMA_2_DEVICE_ID,
			DVI_WIDTH, DVI_HEIGHT, dvi_buff, 0, 0, BOTH);

	printf("initialize ok\r\n");

	unsigned prev_frame_cnt = 0, prev_cam_int = 0, prev_isp_int = 0, prev_vip_int = 0;
	u64 prev_time = 0;
	XTime_GetTime(&prev_time);
	printf("prev_time %llu\n", prev_time);
	while(1) {
		u64 now_time = 0;
		do {
			unsigned curr_isp_int = isp_frame_int;
			XTime_GetTime(&now_time);
			while (curr_isp_int == isp_frame_int && now_time < prev_time + COUNTS_PER_SECOND)
			{
				XTime_GetTime(&now_time);
			}
			if (isp_frame_int % 2 == 0) {
				isp_ae_handler(ISP_BASE, 75<<(ISP_BITS-8), total_v_std*2, 0x3ff);
				isp_awb_handler(ISP_BASE);
			}
		} while (now_time < prev_time + COUNTS_PER_SECOND);
		prev_time = now_time;
		unsigned long long pix_cnt = XIL_ISP_LITE_mReadReg(ISP_BASE, ISP_REG_STAT_AE_PIX_CNT_L) | ((unsigned long long)XIL_ISP_LITE_mReadReg(ISP_BASE, ISP_REG_STAT_AE_PIX_CNT_H) << 32);
		unsigned long long val_sum = XIL_ISP_LITE_mReadReg(ISP_BASE, ISP_REG_STAT_AE_SUM_L) | ((unsigned long long)XIL_ISP_LITE_mReadReg(ISP_BASE, ISP_REG_STAT_AE_SUM_H) << 32);
		printf("pix_cnt %llu, pix_sum %llu, avg_luma %llu\n", pix_cnt, val_sum, (val_sum/pix_cnt)>>(ISP_BITS-8));
		
		unsigned frame_cnt = XIL_CAMIF_mReadReg(CAMIF_BASE, CAMIF_REG_FRAME_CNT);
		unsigned cam_int = cam_frame_int, isp_int = isp_frame_int, vip_int = vip_frame_int;
		printf("%lu x %lu, fps %u, interrupt camif %u, isp %u, vip %u\n",
				XIL_CAMIF_mReadReg(CAMIF_BASE, CAMIF_REG_WIDTH),
				XIL_CAMIF_mReadReg(CAMIF_BASE, CAMIF_REG_HEIGHT),
				frame_cnt - prev_frame_cnt,
				cam_int - prev_cam_int,
				isp_int - prev_isp_int,
				vip_int - prev_vip_int);
		prev_frame_cnt = frame_cnt;
		prev_cam_int = cam_int;
		prev_isp_int = isp_int;
		prev_vip_int = vip_int;

#if 1
		unsigned i, sum;
		printf("AE HIST [");
		for (sum = 0, i = 0; i < ISP_REG_STAT_AE_HIST_SIZE(ISP_BITS); i+=4) {
			unsigned data = XIL_ISP_LITE_mReadReg(ISP_BASE, ISP_REG_STAT_AE_HIST_ADDR(ISP_BITS)+i);
			sum += data;
			if (i >= 96*4 && i < 96*4 + 8*4)
				printf("%u, ", data);
		}
		printf("] total %u\n", sum);//sum may be error, because of reading hist in vsync time
		printf("AWB HIST [");
		for (sum = 0, i = 0; i < ISP_REG_STAT_AWB_HIST_SIZE(ISP_BITS); i+=4) {
			unsigned data = XIL_ISP_LITE_mReadReg(ISP_BASE, ISP_REG_STAT_AWB_HIST_ADDR(ISP_BITS)+i);
			sum += data;
			if (i >= 96*4 && i < 96*4 + 8*4)
				printf("%u, ", data);
		}
		printf("] total %u\n", sum);//sum may be error, because of reading hist in vsync time
#endif
		key_control();
	}

	return 0;
}

