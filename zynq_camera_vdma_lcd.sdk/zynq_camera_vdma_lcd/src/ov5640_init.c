
#include "stdio.h"
#include "sleep.h"
#include <xiic.h>
#include <xparameters.h>
#include <xil_exception.h>
#include "sys_intr.h"

#define  OV5640_ID    0x78   //OV5640的ID

static unsigned total_v_std = 0;

static XIic iic;

static volatile u8 TransmitComplete;
static volatile u8 ReceiveComplete;

static void SendHandler(XIic *InstancePtr)
{
	TransmitComplete = 0;
}

static void ReceiveHandler(XIic *InstancePtr)
{
	ReceiveComplete = 0;
}

static void StatusHandler(XIic *InstancePtr, int Event)
{

}

static int iic_init(void)
{
	int rc;

	XIic_Config *cfg_ptr = XIic_LookupConfig(XPAR_AXI_IIC_DEVICE_ID);
	if (!cfg_ptr) {
		xil_printf("[iic] XIic_LookupConfig() failed\r\n");
		return XST_FAILURE;
	}

	rc = XIic_CfgInitialize(&iic, cfg_ptr, cfg_ptr->BaseAddress);
	if (rc != XST_SUCCESS) {
		xil_printf("[iic] XIic_CfgInitialize() failed\r\n");
		return rc;
	}

	XIic_SetSendHandler(&iic, &iic, (XIic_Handler) SendHandler);
	XIic_SetRecvHandler(&iic, &iic, (XIic_Handler) ReceiveHandler);
	XIic_SetStatusHandler(&iic, &iic, (XIic_StatusHandler) StatusHandler);

#ifdef XPAR_INTC_0_DEVICE_ID
	XIntc_Connect(sys_intr_inst(), XPAR_INTC_0_IIC_0_VEC_ID, (XInterruptHandler) XIic_InterruptHandler, &iic);
	XIntc_Enable(sys_intr_inst(), XPAR_INTC_0_IIC_0_VEC_ID);
#else
	XScuGic_Connect(sys_intr_inst(), XPAR_FABRIC_AXI_IIC_IIC2INTC_IRPT_INTR, (Xil_InterruptHandler)XIic_InterruptHandler, &iic);
    XScuGic_Enable(sys_intr_inst(), XPAR_FABRIC_AXI_IIC_IIC2INTC_IRPT_INTR);
#endif

	return XST_SUCCESS;
}

static int iic_set_slave_addr(u8 addr)
{
	int rc;
	rc = XIic_SetAddress(&iic, XII_ADDR_TO_SEND_TYPE, addr);
	if (rc != XST_SUCCESS) {
		xil_printf("XIic_SetAddress FAILURE\n");
		return rc;
	}
	return XST_SUCCESS;
}

static int iic_write_data(const u8 *WriteBuffer, int len)
{
	int Status;
	unsigned timecnt = 1000000;

	TransmitComplete = 1;
	iic.Stats.TxErrors = 0;

	Status = XIic_Start(&iic);
	if (Status != XST_SUCCESS) {
		printf("iic_write_data XIic_Start fail %d\n", Status);
		return XST_FAILURE;
	}

	Status = XIic_MasterSend(&iic, (u8*)WriteBuffer, len);
	if (Status != XST_SUCCESS) {
		printf("iic_write_data XIic_MasterSend fail %d\n", Status);
		return XST_FAILURE;
	}

	while (((TransmitComplete) || (XIic_IsIicBusy(&iic) == TRUE)) && --timecnt) {
		usleep(1);
		//xil_printf(".");
	}
	if (TransmitComplete) {
		printf("iic_write_data timeout!!!\n");
	}

	Status = XIic_Stop(&iic);
	if (Status != XST_SUCCESS) {
		printf("iic_write_data XIic_Stop fail %d\n", Status);
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

static int iic_read_data(u8 *BufferPtr, int len)
{
	int Status;
	unsigned timecnt = 1000000;

	ReceiveComplete = 1;

	Status = XIic_Start(&iic);
	if (Status != XST_SUCCESS) {
		printf("iic_read_data XIic_Start fail %d\n", Status);
		return XST_FAILURE;
	}

	Status = XIic_MasterRecv(&iic, BufferPtr, len);
	if (Status != XST_SUCCESS) {
		printf("iic_read_data XIic_MasterRecv fail %d\n", Status);
		return XST_FAILURE;
	}

	while (((ReceiveComplete) || (XIic_IsIicBusy(&iic) == TRUE)) && --timecnt) {
		usleep(1);
		//xil_printf(".");
	}
	if (ReceiveComplete) {
		printf("iic_read_data timeout!!!\n");
	}

	Status = XIic_Stop(&iic);
	if (Status != XST_SUCCESS) {
		printf("iic_read_data XIic_Stop fail %d\n", Status);
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

static void sccb_init()
{
	iic_init();
	iic_set_slave_addr(OV5640_ID>>1);
	printf("SCCB initialized ok\n");
}

void sccb_write_reg16(u16 addr , u8 data)
{
  	u8 TxBuffer[3] = {addr >> 8, addr & 0x00FF, data};
	iic_write_data(TxBuffer, sizeof(TxBuffer));
}

u8 sccb_read_reg16(u16 addr )
{
  	u8 TxBuffer[2] = {addr >> 8, addr & 0x00FF};
  	u8 RxBuffer[1] = {0};
	int Status = iic_write_data(TxBuffer, sizeof(TxBuffer));
	if (Status == XST_SUCCESS) {
		Status = iic_read_data(RxBuffer, sizeof(RxBuffer));
	}
	if (Status != XST_SUCCESS) {
		return 0;
	}
	return RxBuffer[0];
}

int ov5640_init_96mhz_raw_960p_45fps(void)
{
//	sccb_write_reg16(0x3103, 0x11);
//	sccb_write_reg16(0x3008, 0x82);
	sccb_write_reg16(0x3008, 0x42);
	sccb_write_reg16(0x3103, 0x03);
	sccb_write_reg16(0x3017, 0xff);
	sccb_write_reg16(0x3018, 0xff);
	sccb_write_reg16(0x3034, 0x1a);
	//系统时钟分频 Bit[7:4]:系统时钟分频 input clock =24Mhz, PCLK = 96Mhz
	sccb_write_reg16(0x3035,0x11);
//	sccb_write_reg16(0x3036,0x3c); //PLL倍频  //48M
//	sccb_write_reg16(0x3036, 0x5A); //PLL倍频  //72M
	sccb_write_reg16(0x3036, 0x78); //PLL倍频  //96M
	sccb_write_reg16(0x3037, 0x13); //PLL分频控制
	sccb_write_reg16(0x3108, 0x01); //系统根分频器
	sccb_write_reg16(0x3630, 0x36);
	sccb_write_reg16(0x3631, 0x0e);
	sccb_write_reg16(0x3632, 0xe2);
	sccb_write_reg16(0x3633, 0x12);
	sccb_write_reg16(0x3621, 0xe0);
	sccb_write_reg16(0x3704, 0xa0);
	sccb_write_reg16(0x3703, 0x5a);
	sccb_write_reg16(0x3715, 0x78);
	sccb_write_reg16(0x3717, 0x01);
	sccb_write_reg16(0x370b, 0x60);
	sccb_write_reg16(0x3705, 0x1a);
	sccb_write_reg16(0x3905, 0x02);
	sccb_write_reg16(0x3906, 0x10);
	sccb_write_reg16(0x3901, 0x0a);
	sccb_write_reg16(0x3731, 0x12);
	sccb_write_reg16(0x3600, 0x08);
	sccb_write_reg16(0x3601, 0x33);
	sccb_write_reg16(0x302d, 0x60);
	sccb_write_reg16(0x3620, 0x52);
	sccb_write_reg16(0x371b, 0x20);
	sccb_write_reg16(0x471c, 0x50);
	sccb_write_reg16(0x3a13, 0x43);
	sccb_write_reg16(0x3a18, 0x00);
	sccb_write_reg16(0x3a19, 0xf8);
	sccb_write_reg16(0x3635, 0x13);
	sccb_write_reg16(0x3636, 0x03);
	sccb_write_reg16(0x3634, 0x40);
	sccb_write_reg16(0x3622, 0x01);
	sccb_write_reg16(0x3c01, 0x34);
	sccb_write_reg16(0x3c04, 0x28);
	sccb_write_reg16(0x3c05, 0x98);
	sccb_write_reg16(0x3c06, 0x00);
	sccb_write_reg16(0x3c07, 0x08);
	sccb_write_reg16(0x3c08, 0x00);
	sccb_write_reg16(0x3c09, 0x1c);
	sccb_write_reg16(0x3c0a, 0x9c);
	sccb_write_reg16(0x3c0b, 0x40);
	sccb_write_reg16(0x3820, 0x42);
	sccb_write_reg16(0x3821, 0x01); //binning enable

	//设置输出像素个数
	sccb_write_reg16(0x3800, 0x00);
	sccb_write_reg16(0x3801, 0x00);
	sccb_write_reg16(0x3802, 0x00);
	sccb_write_reg16(0x3803, 0x04);
	sccb_write_reg16(0x3804, 0x0a);
	sccb_write_reg16(0x3805, 0x3f);
	sccb_write_reg16(0x3806, 0x07);
	sccb_write_reg16(0x3807, 0x9b);
	sccb_write_reg16(0x3808, 0x05);  //DVP 输出水平像素点数高4位
	sccb_write_reg16(0x3809, 0x00);  //DVP 输出水平像素点数低8位
	sccb_write_reg16(0x380a, 0x03);  //DVP 输出垂直像素点数高3位
	sccb_write_reg16(0x380b, 0xc0);  //DVP 输出垂直像素点数低8位
	sccb_write_reg16(0x380c, 0x08);  //水平总像素大小高5位
	sccb_write_reg16(0x380d, 0x00);  //水平总像素大小低8位
	sccb_write_reg16(0x380e, 0x04);  //垂直总像素大小高5位
	sccb_write_reg16(0x380f, 0x00);  //垂直总像素大小低8位
	sccb_write_reg16(0x3810, 0x00);
	sccb_write_reg16(0x3811, 0x10);
	sccb_write_reg16(0x3812, 0x00);
	sccb_write_reg16(0x3813, 0x07);
	sccb_write_reg16(0x3814, 0x31); //Horizontal subsample
	sccb_write_reg16(0x3815, 0x31); //Vertical subsample

	sccb_write_reg16(0x3618, 0x00);
	sccb_write_reg16(0x3612, 0x29);
	sccb_write_reg16(0x3708, 0x64);
	sccb_write_reg16(0x3709, 0x52);
	sccb_write_reg16(0x370c, 0x03);
	sccb_write_reg16(0x3a02, 0x03);
	sccb_write_reg16(0x3a03, 0xd8);
	sccb_write_reg16(0x3a08, 0x01);
	sccb_write_reg16(0x3a09, 0x27);
	sccb_write_reg16(0x3a0a, 0x00);
	sccb_write_reg16(0x3a0b, 0xf6);
	sccb_write_reg16(0x3a0e, 0x03);
	sccb_write_reg16(0x3a0d, 0x04);
	sccb_write_reg16(0x3a14, 0x03);
	sccb_write_reg16(0x3a15, 0xd8);
	sccb_write_reg16(0x4001, 0x02);
	sccb_write_reg16(0x4004, 0x02);
	sccb_write_reg16(0x3000, 0x00);
	sccb_write_reg16(0x3002, 0x1c);
	sccb_write_reg16(0x3004, 0xff);
	sccb_write_reg16(0x3006, 0xc3);
	sccb_write_reg16(0x300e, 0x58);
	sccb_write_reg16(0x302e, 0x00);
	sccb_write_reg16(0x4300, 0xf8);
	sccb_write_reg16(0x501f, 0x03);
	sccb_write_reg16(0x4713, 0x03);
	sccb_write_reg16(0x4407, 0x04);
	sccb_write_reg16(0x440e, 0x00);
	sccb_write_reg16(0x460b, 0x37);
	sccb_write_reg16(0x460c, 0x20);
	sccb_write_reg16(0x4837, 0x22); //DVP CLK divider
	sccb_write_reg16(0x3824, 0x02); //DVP CLK divider
	sccb_write_reg16(0x5000, 0x00);
	sccb_write_reg16(0x5001, 0x00);
	sccb_write_reg16(0x3a0f, 0x36);
	sccb_write_reg16(0x3a10, 0x2e);
	sccb_write_reg16(0x3a1b, 0x38);
	sccb_write_reg16(0x3a1e, 0x2c);
	sccb_write_reg16(0x3a11, 0x70);
	sccb_write_reg16(0x3a1f, 0x18);
	sccb_write_reg16(0x3008, 0x02);
	sccb_write_reg16(0x3400, 0x04);
	sccb_write_reg16(0x3401, 0x00);
	sccb_write_reg16(0x3402, 0x04);
	sccb_write_reg16(0x3403, 0x00);
	sccb_write_reg16(0x3404, 0x04);
	sccb_write_reg16(0x3405, 0x00);
	sccb_write_reg16(0x3406, 0x01);
	sccb_write_reg16(0x4000, 0x88);
	sccb_write_reg16(0x3503, 0x03);

	unsigned int cmos_exposure = 0x300;
	unsigned int cmos_gain = 0xa0;
    sccb_write_reg16(0x3500, 0x00);// Exposure [19:16]
	sccb_write_reg16(0x3501, (cmos_exposure>>4)&0x3f);// Exposure [15:8]
	sccb_write_reg16(0x3502, (cmos_exposure&0x0f)<<4);// Exposure [7:0]
	sccb_write_reg16(0x350a, (cmos_gain>>8)&0x3);// Real gain[9:8]
	sccb_write_reg16(0x350b, cmos_gain&0x0ff);// Real gain[7:0]

	total_v_std = 0x400;

	printf("=== ov5640_init_96mhz_raw_960p_45fps initialize OK!\n");
	return 0;
}


int ov5640_init_96mhz_raw_1080p_30fps(void)
{
//	sccb_write_reg16(0x3103, 0x11);
//	sccb_write_reg16(0x3008, 0x82);
	sccb_write_reg16(0x3008, 0x42);
	sccb_write_reg16(0x3103, 0x03);
	sccb_write_reg16(0x3017, 0xff);
	sccb_write_reg16(0x3018, 0xff);
	sccb_write_reg16(0x3034, 0x1a);
	//系统时钟分频 Bit[7:4]:系统时钟分频 input clock =24Mhz, PCLK = 96Mhz
	sccb_write_reg16(0x3035,0x11);
//	sccb_write_reg16(0x3036,0x3c); //PLL倍频  //48M
//	sccb_write_reg16(0x3036, 0x5A); //PLL倍频  //72M
	sccb_write_reg16(0x3036, 0x78); //PLL倍频  //96M
	sccb_write_reg16(0x3037, 0x13); //PLL分频控制
	sccb_write_reg16(0x3108, 0x01); //系统根分频器
	sccb_write_reg16(0x3630, 0x36);
	sccb_write_reg16(0x3631, 0x0e);
	sccb_write_reg16(0x3632, 0xe2);
	sccb_write_reg16(0x3633, 0x12);
	sccb_write_reg16(0x3621, 0xe0);
	sccb_write_reg16(0x3704, 0xa0);
	sccb_write_reg16(0x3703, 0x5a);
	sccb_write_reg16(0x3715, 0x78);
	sccb_write_reg16(0x3717, 0x01);
	sccb_write_reg16(0x370b, 0x60);
	sccb_write_reg16(0x3705, 0x1a);
	sccb_write_reg16(0x3905, 0x02);
	sccb_write_reg16(0x3906, 0x10);
	sccb_write_reg16(0x3901, 0x0a);
	sccb_write_reg16(0x3731, 0x12);
	sccb_write_reg16(0x3600, 0x08);
	sccb_write_reg16(0x3601, 0x33);
	sccb_write_reg16(0x302d, 0x60);
	sccb_write_reg16(0x3620, 0x52);
	sccb_write_reg16(0x371b, 0x20);
	sccb_write_reg16(0x471c, 0x50);
	sccb_write_reg16(0x3a13, 0x43);
	sccb_write_reg16(0x3a18, 0x00);
	sccb_write_reg16(0x3a19, 0xf8);
	sccb_write_reg16(0x3635, 0x13);
	sccb_write_reg16(0x3636, 0x03);
	sccb_write_reg16(0x3634, 0x40);
	sccb_write_reg16(0x3622, 0x01);
	sccb_write_reg16(0x3c01, 0x34);
	sccb_write_reg16(0x3c04, 0x28);
	sccb_write_reg16(0x3c05, 0x98);
	sccb_write_reg16(0x3c06, 0x00);
	sccb_write_reg16(0x3c07, 0x08);
	sccb_write_reg16(0x3c08, 0x00);
	sccb_write_reg16(0x3c09, 0x1c);
	sccb_write_reg16(0x3c0a, 0x9c);
	sccb_write_reg16(0x3c0b, 0x40);
	sccb_write_reg16(0x3820, 0x46);
	sccb_write_reg16(0x3821, 0x00);

	//设置输出像素个数
	sccb_write_reg16(0x3800, 0x01);
	sccb_write_reg16(0x3801, 0x50);
	sccb_write_reg16(0x3802, 0x01);
	sccb_write_reg16(0x3803, 0xb2);
	sccb_write_reg16(0x3804, 0x08);
	sccb_write_reg16(0x3805, 0xef);
	sccb_write_reg16(0x3806, 0x05);
	sccb_write_reg16(0x3807, 0xf1);
	sccb_write_reg16(0x3808, 0x07);  //DVP 输出水平像素点数高4位
	sccb_write_reg16(0x3809, 0x80);  //DVP 输出水平像素点数低8位
	sccb_write_reg16(0x380a, 0x04);  //DVP 输出垂直像素点数高3位
	sccb_write_reg16(0x380b, 0x38);  //DVP 输出垂直像素点数低8位
	sccb_write_reg16(0x380c, 0x09);  //水平总像素大小高5位
	sccb_write_reg16(0x380d, 0xc4);  //水平总像素大小低8位
	sccb_write_reg16(0x380e, 0x05);  //垂直总像素大小高5位
	sccb_write_reg16(0x380f, 0x00);  //垂直总像素大小低8位
	sccb_write_reg16(0x3810, 0x00);
	sccb_write_reg16(0x3811, 0x10);
	sccb_write_reg16(0x3812, 0x00);
	sccb_write_reg16(0x3813, 0x04);
	sccb_write_reg16(0x3814, 0x11);
	sccb_write_reg16(0x3815, 0x11);

	sccb_write_reg16(0x3618, 0x00);
	sccb_write_reg16(0x3612, 0x29);
	sccb_write_reg16(0x3708, 0x64);
	sccb_write_reg16(0x3709, 0x52);
	sccb_write_reg16(0x370c, 0x03);
	sccb_write_reg16(0x3a02, 0x03);
	sccb_write_reg16(0x3a03, 0xd8);
	sccb_write_reg16(0x3a08, 0x01);
	sccb_write_reg16(0x3a09, 0x27);
	sccb_write_reg16(0x3a0a, 0x00);
	sccb_write_reg16(0x3a0b, 0xf6);
	sccb_write_reg16(0x3a0e, 0x03);
	sccb_write_reg16(0x3a0d, 0x04);
	sccb_write_reg16(0x3a14, 0x03);
	sccb_write_reg16(0x3a15, 0xd8);
	sccb_write_reg16(0x4001, 0x02);
	sccb_write_reg16(0x4004, 0x02);
	sccb_write_reg16(0x3000, 0x00);
	sccb_write_reg16(0x3002, 0x1c);
	sccb_write_reg16(0x3004, 0xff);
	sccb_write_reg16(0x3006, 0xc3);
	sccb_write_reg16(0x300e, 0x58);
	sccb_write_reg16(0x302e, 0x00);
	sccb_write_reg16(0x4300, 0xf8);
	sccb_write_reg16(0x501f, 0x03);
	sccb_write_reg16(0x4713, 0x03);
	sccb_write_reg16(0x4407, 0x04);
	sccb_write_reg16(0x440e, 0x00);
	sccb_write_reg16(0x460b, 0x37);
	sccb_write_reg16(0x460c, 0x20);
	sccb_write_reg16(0x4837, 0x22); //DVP CLK divider
	sccb_write_reg16(0x3824, 0x02); //DVP CLK divider
	sccb_write_reg16(0x5000, 0x00);
	sccb_write_reg16(0x5001, 0x00);
	sccb_write_reg16(0x3a0f, 0x36);
	sccb_write_reg16(0x3a10, 0x2e);
	sccb_write_reg16(0x3a1b, 0x38);
	sccb_write_reg16(0x3a1e, 0x2c);
	sccb_write_reg16(0x3a11, 0x70);
	sccb_write_reg16(0x3a1f, 0x18);
	sccb_write_reg16(0x3008, 0x02);
	sccb_write_reg16(0x3400, 0x04);
	sccb_write_reg16(0x3401, 0x00);
	sccb_write_reg16(0x3402, 0x04);
	sccb_write_reg16(0x3403, 0x00);
	sccb_write_reg16(0x3404, 0x04);
	sccb_write_reg16(0x3405, 0x00);
	sccb_write_reg16(0x3406, 0x01);
	sccb_write_reg16(0x4000, 0x88);
	sccb_write_reg16(0x3503, 0x03);

	unsigned int cmos_exposure = 0x300;
	unsigned int cmos_gain = 0xa0;
    sccb_write_reg16(0x3500, 0x00);// Exposure [19:16]
	sccb_write_reg16(0x3501, (cmos_exposure>>4)&0x3f);// Exposure [15:8]
	sccb_write_reg16(0x3502, (cmos_exposure&0x0f)<<4);// Exposure [7:0]
	sccb_write_reg16(0x350a, (cmos_gain>>8)&0x3);// Real gain[9:8]
	sccb_write_reg16(0x350b, cmos_gain&0x0ff);// Real gain[7:0]

	total_v_std = 0x500;

	printf("=== ov5640_init_96mhz_raw_1080p_30fps initialize OK!\n");
	return 0;
}

//2560x1920
int ov5640_init_96mhz_raw_5mp_15fps(void)
{
//	sccb_write_reg16(0x3103, 0x11);
//	sccb_write_reg16(0x3008, 0x82);
	sccb_write_reg16(0x3008, 0x42);
	sccb_write_reg16(0x3103, 0x03);
	sccb_write_reg16(0x3017, 0xff);
	sccb_write_reg16(0x3018, 0xff);
	sccb_write_reg16(0x3034, 0x1a);
	//系统时钟分频 Bit[7:4]:系统时钟分频 input clock =24Mhz, PCLK = 96Mhz
	sccb_write_reg16(0x3035,0x11);
//	sccb_write_reg16(0x3036,0x3c); //PLL倍频  //48M
//	sccb_write_reg16(0x3036, 0x5A); //PLL倍频  //72M
	sccb_write_reg16(0x3036, 0x78); //PLL倍频  //96M
	sccb_write_reg16(0x3037, 0x13); //PLL分频控制
	sccb_write_reg16(0x3108, 0x01); //系统根分频器
	sccb_write_reg16(0x3630, 0x36);
	sccb_write_reg16(0x3631, 0x0e);
	sccb_write_reg16(0x3632, 0xe2);
	sccb_write_reg16(0x3633, 0x12);
	sccb_write_reg16(0x3621, 0xe0);
	sccb_write_reg16(0x3704, 0xa0);
	sccb_write_reg16(0x3703, 0x5a);
	sccb_write_reg16(0x3715, 0x78);
	sccb_write_reg16(0x3717, 0x01);
	sccb_write_reg16(0x370b, 0x60);
	sccb_write_reg16(0x3705, 0x1a);
	sccb_write_reg16(0x3905, 0x02);
	sccb_write_reg16(0x3906, 0x10);
	sccb_write_reg16(0x3901, 0x0a);
	sccb_write_reg16(0x3731, 0x12);
	sccb_write_reg16(0x3600, 0x08);
	sccb_write_reg16(0x3601, 0x33);
	sccb_write_reg16(0x302d, 0x60);
	sccb_write_reg16(0x3620, 0x52);
	sccb_write_reg16(0x371b, 0x20);
	sccb_write_reg16(0x471c, 0x50);
	sccb_write_reg16(0x3a13, 0x43);
	sccb_write_reg16(0x3a18, 0x00);
	sccb_write_reg16(0x3a19, 0xf8);
	sccb_write_reg16(0x3635, 0x13);
	sccb_write_reg16(0x3636, 0x03);
	sccb_write_reg16(0x3634, 0x40);
	sccb_write_reg16(0x3622, 0x01);
	sccb_write_reg16(0x3c01, 0x34);
	sccb_write_reg16(0x3c04, 0x28);
	sccb_write_reg16(0x3c05, 0x98);
	sccb_write_reg16(0x3c06, 0x00);
	sccb_write_reg16(0x3c07, 0x08);
	sccb_write_reg16(0x3c08, 0x00);
	sccb_write_reg16(0x3c09, 0x1c);
	sccb_write_reg16(0x3c0a, 0x9c);
	sccb_write_reg16(0x3c0b, 0x40);
	sccb_write_reg16(0x3820, 0x46);
	sccb_write_reg16(0x3821, 0x00);

	//设置输出像素个数
	sccb_write_reg16(0x3800, 0x00);
	sccb_write_reg16(0x3801, 0x10);
	sccb_write_reg16(0x3802, 0x00);
	sccb_write_reg16(0x3803, 0x04);
	sccb_write_reg16(0x3804, 0x0a);
	sccb_write_reg16(0x3805, 0x2f);
	sccb_write_reg16(0x3806, 0x07);
	sccb_write_reg16(0x3807, 0x9b);
	sccb_write_reg16(0x3808, 0x0a);  //DVP 输出水平像素点数高4位
	sccb_write_reg16(0x3809, 0x00);  //DVP 输出水平像素点数低8位
	sccb_write_reg16(0x380a, 0x07);  //DVP 输出垂直像素点数高3位
	sccb_write_reg16(0x380b, 0x80);  //DVP 输出垂直像素点数低8位
	sccb_write_reg16(0x380c, 0x0b);  //水平总像素大小高5位
	sccb_write_reg16(0x380d, 0x1c);  //水平总像素大小低8位
	sccb_write_reg16(0x380e, 0x07);  //垂直总像素大小高5位
	sccb_write_reg16(0x380f, 0xb0);  //垂直总像素大小低8位
	sccb_write_reg16(0x3810, 0x00);
	sccb_write_reg16(0x3811, 0x10);
	sccb_write_reg16(0x3812, 0x00);
	sccb_write_reg16(0x3813, 0x04);
	sccb_write_reg16(0x3814, 0x11);
	sccb_write_reg16(0x3815, 0x11);

	sccb_write_reg16(0x3618, 0x00);
	sccb_write_reg16(0x3612, 0x29);
	sccb_write_reg16(0x3708, 0x64);
	sccb_write_reg16(0x3709, 0x52);
	sccb_write_reg16(0x370c, 0x03);
	sccb_write_reg16(0x3a02, 0x03);
	sccb_write_reg16(0x3a03, 0xd8);
	sccb_write_reg16(0x3a08, 0x01);
	sccb_write_reg16(0x3a09, 0x27);
	sccb_write_reg16(0x3a0a, 0x00);
	sccb_write_reg16(0x3a0b, 0xf6);
	sccb_write_reg16(0x3a0e, 0x03);
	sccb_write_reg16(0x3a0d, 0x04);
	sccb_write_reg16(0x3a14, 0x03);
	sccb_write_reg16(0x3a15, 0xd8);
	sccb_write_reg16(0x4001, 0x02);
	sccb_write_reg16(0x4004, 0x02);
	sccb_write_reg16(0x3000, 0x00);
	sccb_write_reg16(0x3002, 0x1c);
	sccb_write_reg16(0x3004, 0xff);
	sccb_write_reg16(0x3006, 0xc3);
	sccb_write_reg16(0x300e, 0x58);
	sccb_write_reg16(0x302e, 0x00);
	sccb_write_reg16(0x4300, 0xf8);
	sccb_write_reg16(0x501f, 0x03);
	sccb_write_reg16(0x4713, 0x03);
	sccb_write_reg16(0x4407, 0x04);
	sccb_write_reg16(0x440e, 0x00);
	sccb_write_reg16(0x460b, 0x37);
	sccb_write_reg16(0x460c, 0x20);
	sccb_write_reg16(0x4837, 0x22); //DVP CLK divider
	sccb_write_reg16(0x3824, 0x02); //DVP CLK divider
	sccb_write_reg16(0x5000, 0x00);
	sccb_write_reg16(0x5001, 0x00);
	sccb_write_reg16(0x3a0f, 0x36);
	sccb_write_reg16(0x3a10, 0x2e);
	sccb_write_reg16(0x3a1b, 0x38);
	sccb_write_reg16(0x3a1e, 0x2c);
	sccb_write_reg16(0x3a11, 0x70);
	sccb_write_reg16(0x3a1f, 0x18);
	sccb_write_reg16(0x3008, 0x02);
	sccb_write_reg16(0x3400, 0x04);
	sccb_write_reg16(0x3401, 0x00);
	sccb_write_reg16(0x3402, 0x04);
	sccb_write_reg16(0x3403, 0x00);
	sccb_write_reg16(0x3404, 0x04);
	sccb_write_reg16(0x3405, 0x00);
	sccb_write_reg16(0x3406, 0x01);
	sccb_write_reg16(0x4000, 0x88);
	sccb_write_reg16(0x3503, 0x03);

	unsigned int cmos_exposure = 0x300;
	unsigned int cmos_gain = 0xa0;
    sccb_write_reg16(0x3500, 0x00);// Exposure [19:16]
	sccb_write_reg16(0x3501, (cmos_exposure>>4)&0x3f);// Exposure [15:8]
	sccb_write_reg16(0x3502, (cmos_exposure&0x0f)<<4);// Exposure [7:0]
	sccb_write_reg16(0x350a, (cmos_gain>>8)&0x3);// Real gain[9:8]
	sccb_write_reg16(0x350b, cmos_gain&0x0ff);// Real gain[7:0]

	total_v_std = 0x7b0;

	printf("=== ov5640_init_96mhz_raw_5mp_15fps initialize OK!\n");
	return 0;
}


int cmos_set_exposure(unsigned exposure)
{
	static unsigned int cmos_exposure = 0x300;
	if (exposure == cmos_exposure) {
		return 0;
	}
	printf("cmos_exposure %u -> %u\n", cmos_exposure, exposure);
	cmos_exposure = exposure;
    sccb_write_reg16(0x3500, (exposure>>12)&0x0ff);// Exposure [19:16]
	sccb_write_reg16(0x3501, (exposure>>4)&0x0ff);// Exposure [15:8]
	sccb_write_reg16(0x3502, (exposure&0x0f)<<4);// Exposure [7:0]

	if (exposure < total_v_std) {
		sccb_write_reg16(0x380e, total_v_std>>8);  //垂直总像素大小高5位
		sccb_write_reg16(0x380f, total_v_std&0xff);  //垂直总像素大小低8位
	} else {
		sccb_write_reg16(0x380e, exposure>>8);  //垂直总像素大小高5位
		sccb_write_reg16(0x380f, exposure&0xff);  //垂直总像素大小低8位
	}
	return 0;
}

int cmos_set_gain(unsigned gain)
{
	static unsigned int cmos_gain = 0xa0;
	if (gain == cmos_gain) {
		return 0;
	}
	printf("cmos_gain 0x%03X -> 0x%03X\n", cmos_gain, gain);
	cmos_gain = gain;
	sccb_write_reg16(0x350a, (gain>>8)&0x3);// Real gain[9:8]
	sccb_write_reg16(0x350b, gain&0x0ff);// Real gain[7:0]
	return 0;
}


int ov5640_init(u16 cmos_h_pixel,  u16 cmos_v_pixel, u16* ptr_total_v_std)
{
	u16 cam_id = 0;

	usleep(20000);  //OV5640上电到开始配置sccb至少等待20ms

	sccb_init();

    //读OV5640摄像头ID
    cam_id  = sccb_read_reg16(0x300b);       //LSB  0x40
    cam_id |= sccb_read_reg16(0x300a) << 8;  //MSB  0x56
	//cam_id = 0x5640;
    
    if(cam_id != 0x5640) { //获取到正确的OV5640 ID
    	printf("cam_id Invalid %04X\r\n", cam_id);
    	return 1;
    }else{
		//先对寄存器进行软件复位，使寄存器恢复初始值
		//寄存器软件复位后，需要延时1ms才能配置其它寄存器
		sccb_write_reg16(0x3008,0x82); //Bit[7]:复位 Bit[6]:电源休眠

		//延时1ms
		usleep(1000);
#if 1
		//ov5640_init_2(cmos_h_pixel, cmos_v_pixel, total_h_pixel, total_v_pixel);
		if (1280 == cmos_h_pixel && 960 == cmos_v_pixel) {
			ov5640_init_96mhz_raw_960p_45fps();
		}
		if (1920 == cmos_h_pixel && 1080 == cmos_v_pixel) {
			ov5640_init_96mhz_raw_1080p_30fps();
		}
		if (2560 == cmos_h_pixel && 1920 == cmos_v_pixel) {
			ov5640_init_96mhz_raw_5mp_15fps();
		}
		if (ptr_total_v_std) {
			*ptr_total_v_std = total_v_std;
		}
#else
		sccb_write_reg16(0x3008,0x02); //正常工作模式
		sccb_write_reg16(0x3103,0x02); //Bit[1]:1 PLL Clock
		//引脚输入/输出控制 FREX/VSYNC/HREF/PCLK/D[9:6]
		sccb_write_reg16(0x3017,0xff);
		//引脚输入/输出控制 D[5:0]/GPIO1/GPIO0
		sccb_write_reg16(0x3018,0xff);
		sccb_write_reg16(0x3037,0x13); //PLL分频控制
		sccb_write_reg16(0x3108,0x01); //系统根分频器
		sccb_write_reg16(0x3630,0x36);
		sccb_write_reg16(0x3631,0x0e);
		sccb_write_reg16(0x3632,0xe2);
		sccb_write_reg16(0x3633,0x12);
		sccb_write_reg16(0x3621,0xe0);
		sccb_write_reg16(0x3704,0xa0);
		sccb_write_reg16(0x3703,0x5a);
		sccb_write_reg16(0x3715,0x78);
		sccb_write_reg16(0x3717,0x01);
		sccb_write_reg16(0x370b,0x60);
		sccb_write_reg16(0x3705,0x1a);
		sccb_write_reg16(0x3905,0x02);
		sccb_write_reg16(0x3906,0x10);
		sccb_write_reg16(0x3901,0x0a);
		sccb_write_reg16(0x3731,0x12);
		sccb_write_reg16(0x3600,0x08); //VCM控制,用于自动聚焦
		sccb_write_reg16(0x3601,0x33); //VCM控制,用于自动聚焦
		sccb_write_reg16(0x302d,0x60); //系统控制
		sccb_write_reg16(0x3620,0x52);
		sccb_write_reg16(0x371b,0x20);
		sccb_write_reg16(0x471c,0x50);
		sccb_write_reg16(0x3a13,0x43); //AEC(自动曝光控制)
		sccb_write_reg16(0x3a18,0x00); //AEC 增益上限
		sccb_write_reg16(0x3a19,0xf8); //AEC 增益上限
		sccb_write_reg16(0x3635,0x13);
		sccb_write_reg16(0x3636,0x03);
		sccb_write_reg16(0x3634,0x40);
		sccb_write_reg16(0x3622,0x01);
		sccb_write_reg16(0x3c01,0x34);
		sccb_write_reg16(0x3c04,0x28);
		sccb_write_reg16(0x3c05,0x98);
		sccb_write_reg16(0x3c06,0x00); //light meter 1 阈值[15:8]
		sccb_write_reg16(0x3c07,0x08); //light meter 1 阈值[7:0]
		sccb_write_reg16(0x3c08,0x00); //light meter 2 阈值[15:8]
		sccb_write_reg16(0x3c09,0x1c); //light meter 2 阈值[7:0]
		sccb_write_reg16(0x3c0a,0x9c); //sample number[15:8]
		sccb_write_reg16(0x3c0b,0x40); //sample number[7:0]
		sccb_write_reg16(0x3810,0x00); //Timing Hoffset[11:8]
		sccb_write_reg16(0x3811,0x10); //Timing Hoffset[7:0]
		sccb_write_reg16(0x3812,0x00); //Timing Voffset[10:8]
		sccb_write_reg16(0x3708,0x64);
		sccb_write_reg16(0x4001,0x02); //BLC(黑电平校准)补偿起始行号
		sccb_write_reg16(0x4005,0x1a); //BLC(黑电平校准)补偿始终更新
		sccb_write_reg16(0x3000,0x00); //系统块复位控制
		sccb_write_reg16(0x3004,0xff); //时钟使能控制
		sccb_write_reg16(0x4300,0xf8); //格式控制 RAW
		sccb_write_reg16(0x501f,0x03); //ISP RAW
		sccb_write_reg16(0x440e,0x00);
		sccb_write_reg16(0x5000,0xa7); //ISP控制
		sccb_write_reg16(0x3a0f,0x30); //AEC控制;stable range in high
		sccb_write_reg16(0x3a10,0x28); //AEC控制;stable range in low
		sccb_write_reg16(0x3a1b,0x30); //AEC控制;stable range out high
		sccb_write_reg16(0x3a1e,0x26); //AEC控制;stable range out low
		sccb_write_reg16(0x3a11,0x60); //AEC控制; fast zone high
		sccb_write_reg16(0x3a1f,0x14); //AEC控制; fast zone low
		//LENC(镜头校正)控制 0x5800~0x583d
		sccb_write_reg16(0x5800,0x23);
		sccb_write_reg16(0x5801,0x14);
		sccb_write_reg16(0x5802,0x0f);
		sccb_write_reg16(0x5803,0x0f);
		sccb_write_reg16(0x5804,0x12);
		sccb_write_reg16(0x5805,0x26);
		sccb_write_reg16(0x5806,0x0c);
		sccb_write_reg16(0x5807,0x08);
		sccb_write_reg16(0x5808,0x05);
		sccb_write_reg16(0x5809,0x05);
		sccb_write_reg16(0x580a,0x08);
		sccb_write_reg16(0x580b,0x0d);
		sccb_write_reg16(0x580c,0x08);
		sccb_write_reg16(0x580d,0x03);
		sccb_write_reg16(0x580e,0x00);
		sccb_write_reg16(0x580f,0x00);
		sccb_write_reg16(0x5810,0x03);
		sccb_write_reg16(0x5811,0x09);
		sccb_write_reg16(0x5812,0x07);
		sccb_write_reg16(0x5813,0x03);
		sccb_write_reg16(0x5814,0x00);
		sccb_write_reg16(0x5815,0x01);
		sccb_write_reg16(0x5816,0x03);
		sccb_write_reg16(0x5817,0x08);
		sccb_write_reg16(0x5818,0x0d);
		sccb_write_reg16(0x5819,0x08);
		sccb_write_reg16(0x581a,0x05);
		sccb_write_reg16(0x581b,0x06);
		sccb_write_reg16(0x581c,0x08);
		sccb_write_reg16(0x581d,0x0e);
		sccb_write_reg16(0x581e,0x29);
		sccb_write_reg16(0x581f,0x17);
		sccb_write_reg16(0x5820,0x11);
		sccb_write_reg16(0x5821,0x11);
		sccb_write_reg16(0x5822,0x15);
		sccb_write_reg16(0x5823,0x28);
		sccb_write_reg16(0x5824,0x46);
		sccb_write_reg16(0x5825,0x26);
		sccb_write_reg16(0x5826,0x08);
		sccb_write_reg16(0x5827,0x26);
		sccb_write_reg16(0x5828,0x64);
		sccb_write_reg16(0x5829,0x26);
		sccb_write_reg16(0x582a,0x24);
		sccb_write_reg16(0x582b,0x22);
		sccb_write_reg16(0x582c,0x24);
		sccb_write_reg16(0x582d,0x24);
		sccb_write_reg16(0x582e,0x06);
		sccb_write_reg16(0x582f,0x22);
		sccb_write_reg16(0x5830,0x40);
		sccb_write_reg16(0x5831,0x42);
		sccb_write_reg16(0x5832,0x24);
		sccb_write_reg16(0x5833,0x26);
		sccb_write_reg16(0x5834,0x24);
		sccb_write_reg16(0x5835,0x22);
		sccb_write_reg16(0x5836,0x22);
		sccb_write_reg16(0x5837,0x26);
		sccb_write_reg16(0x5838,0x44);
		sccb_write_reg16(0x5839,0x24);
		sccb_write_reg16(0x583a,0x26);
		sccb_write_reg16(0x583b,0x28);
		sccb_write_reg16(0x583c,0x42);
		sccb_write_reg16(0x583d,0xce);
		//AWB(自动白平衡控制) 0x5180~0x519e
		sccb_write_reg16(0x5180,0xff);
		sccb_write_reg16(0x5181,0xf2);
		sccb_write_reg16(0x5182,0x00);
		sccb_write_reg16(0x5183,0x14);
		sccb_write_reg16(0x5184,0x25);
		sccb_write_reg16(0x5185,0x24);
		sccb_write_reg16(0x5186,0x09);
		sccb_write_reg16(0x5187,0x09);
		sccb_write_reg16(0x5188,0x09);
		sccb_write_reg16(0x5189,0x75);
		sccb_write_reg16(0x518a,0x54);
		sccb_write_reg16(0x518b,0xe0);
		sccb_write_reg16(0x518c,0xb2);
		sccb_write_reg16(0x518d,0x42);
		sccb_write_reg16(0x518e,0x3d);
		sccb_write_reg16(0x518f,0x56);
		sccb_write_reg16(0x5190,0x46);
		sccb_write_reg16(0x5191,0xf8);
		sccb_write_reg16(0x5192,0x04);
		sccb_write_reg16(0x5193,0x70);
		sccb_write_reg16(0x5194,0xf0);
		sccb_write_reg16(0x5195,0xf0);
		sccb_write_reg16(0x5196,0x03);
		sccb_write_reg16(0x5197,0x01);
		sccb_write_reg16(0x5198,0x04);
		sccb_write_reg16(0x5199,0x12);
		sccb_write_reg16(0x519a,0x04);
		sccb_write_reg16(0x519b,0x00);
		sccb_write_reg16(0x519c,0x06);
		sccb_write_reg16(0x519d,0x82);
		sccb_write_reg16(0x519e,0x38);
		//Gamma(伽马)控制 0x5480~0x5490
		sccb_write_reg16(0x5480,0x01);
		sccb_write_reg16(0x5481,0x08);
		sccb_write_reg16(0x5482,0x14);
		sccb_write_reg16(0x5483,0x28);
		sccb_write_reg16(0x5484,0x51);
		sccb_write_reg16(0x5485,0x65);
		sccb_write_reg16(0x5486,0x71);
		sccb_write_reg16(0x5487,0x7d);
		sccb_write_reg16(0x5488,0x87);
		sccb_write_reg16(0x5489,0x91);
		sccb_write_reg16(0x548a,0x9a);
		sccb_write_reg16(0x548b,0xaa);
		sccb_write_reg16(0x548c,0xb8);
		sccb_write_reg16(0x548d,0xcd);
		sccb_write_reg16(0x548e,0xdd);
		sccb_write_reg16(0x548f,0xea);
		sccb_write_reg16(0x5490,0x1d);
		//CMX(彩色矩阵控制) 0x5381~0x538b
		sccb_write_reg16(0x5381,0x1e);
		sccb_write_reg16(0x5382,0x5b);
		sccb_write_reg16(0x5383,0x08);
		sccb_write_reg16(0x5384,0x0a);
		sccb_write_reg16(0x5385,0x7e);
		sccb_write_reg16(0x5386,0x88);
		sccb_write_reg16(0x5387,0x7c);
		sccb_write_reg16(0x5388,0x6c);
		sccb_write_reg16(0x5389,0x10);
		sccb_write_reg16(0x538a,0x01);
		sccb_write_reg16(0x538b,0x98);
		//SDE(特殊数码效果)控制 0x5580~0x558b
		sccb_write_reg16(0x5580,0x06);
		sccb_write_reg16(0x5583,0x40);
		sccb_write_reg16(0x5584,0x10);
		sccb_write_reg16(0x5589,0x10);
		sccb_write_reg16(0x558a,0x00);
		sccb_write_reg16(0x558b,0xf8);
		sccb_write_reg16(0x501d,0x40); //ISP MISC
		//CIP(颜色插值)控制 (0x5300~0x530c)
		sccb_write_reg16(0x5300,0x08);
		sccb_write_reg16(0x5301,0x30);
		sccb_write_reg16(0x5302,0x10);
		sccb_write_reg16(0x5303,0x00);
		sccb_write_reg16(0x5304,0x08);
		sccb_write_reg16(0x5305,0x30);
		sccb_write_reg16(0x5306,0x08);
		sccb_write_reg16(0x5307,0x16);
		sccb_write_reg16(0x5309,0x08);
		sccb_write_reg16(0x530a,0x30);
		sccb_write_reg16(0x530b,0x04);
		sccb_write_reg16(0x530c,0x06);
		sccb_write_reg16(0x5025,0x00);
		//系统时钟分频 Bit[7:4]:系统时钟分频 input clock =24Mhz, PCLK = 72Mhz
		sccb_write_reg16(0x3035,0x11);
//		sccb_write_reg16(0x3036,0x3c); //PLL倍频  //48M
		sccb_write_reg16(0x3036,0x46); //PLL倍频  //72M
		sccb_write_reg16(0x3c07,0x08);
		//时序控制 0x3800~0x3821
		sccb_write_reg16(0x3820,0x46);
		sccb_write_reg16(0x3821,0x01);
		sccb_write_reg16(0x3814,0x31);
		sccb_write_reg16(0x3815,0x31);
		sccb_write_reg16(0x3800,0x00);
		sccb_write_reg16(0x3801,0x00);
		sccb_write_reg16(0x3802,0x00);
		sccb_write_reg16(0x3803,0x04);
		sccb_write_reg16(0x3804,0x0a);
		sccb_write_reg16(0x3805,0x3f);
		sccb_write_reg16(0x3806,0x07);
		sccb_write_reg16(0x3807,0x9b);

		//设置输出像素个数
		sccb_write_reg16(0x3808, cmos_h_pixel >> 8     );  //DVP 输出水平像素点数高4位
		sccb_write_reg16(0x3809, cmos_h_pixel & 0x00FF );  //DVP 输出水平像素点数低8位
		sccb_write_reg16(0x380a, cmos_v_pixel >> 8     );  //DVP 输出垂直像素点数高3位
		sccb_write_reg16(0x380b, cmos_v_pixel & 0x00FF );  //DVP 输出垂直像素点数低8位
		sccb_write_reg16(0x380c, total_h_pixel >> 8    );  //水平总像素大小高5位
		sccb_write_reg16(0x380d, total_h_pixel & 0x00FF);  //水平总像素大小低8位
		sccb_write_reg16(0x380e, total_v_pixel >> 8    );  //垂直总像素大小高5位
		sccb_write_reg16(0x380f, total_v_pixel & 0x00FF);  //垂直总像素大小低8位
		
		sccb_write_reg16(0x3813,0x06);
		sccb_write_reg16(0x3618,0x00);
		sccb_write_reg16(0x3612,0x29);
		sccb_write_reg16(0x3709,0x52);
		sccb_write_reg16(0x370c,0x03);
		sccb_write_reg16(0x3a02,0x17); //60Hz max exposure
		sccb_write_reg16(0x3a03,0x10); //60Hz max exposure
		sccb_write_reg16(0x3a14,0x17); //50Hz max exposure
		sccb_write_reg16(0x3a15,0x10); //50Hz max exposure
		sccb_write_reg16(0x4004,0x02); //BLC(背光) 2 lines
		sccb_write_reg16(0x4713,0x03); //JPEG mode 3
		sccb_write_reg16(0x4407,0x04); //量化标度
		sccb_write_reg16(0x460c,0x22);
		sccb_write_reg16(0x4837,0x22); //DVP CLK divider
		sccb_write_reg16(0x3824,0x02); //DVP CLK divider
		sccb_write_reg16(0x5001,0x00); //ISP 控制
		sccb_write_reg16(0x3b07,0x0a); //帧曝光模式
		//彩条测试使能
		sccb_write_reg16(0x503d,0x00); //0x00:正常模式 0x80:彩条显示
		//测试闪光灯功能
		sccb_write_reg16(0x3016,0x02);
		sccb_write_reg16(0x301c,0x02);
		sccb_write_reg16(0x3019,0x02); //打开闪光灯
		sccb_write_reg16(0x3019,0x00); //关闭闪光灯
#endif
		return 0;
	}


}

