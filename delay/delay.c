#include "delay.h"
#include "pwm.h"
#include "relay.h"
#include "adc.h"
#include "global.h"

void TIM4_Init(void)
{
	_asm("sim");
	TIM4_IER = 0x00;//disable TIM4 interrupt
	//TIM4_EGR = 0X01;
	TIM4_CR1 = 0x00;//Counter go on when update occur
	TIM4_PSCR= 0x03;//Fcpu:8Mhz,counter:1uS
	TIM4_ARR = 0x2E;//test:0x2E~51.5uS, 0x2D~50uS
	TIM4_CNTR = 0x00;
	
	ITC_SPR6 |= 0x80;//set TIM4 UPD_INT priority to 1
	ITC_SPR6 &= 0xBF;	
	_asm("rim");
}

void Delay(void)
{
	volatile unsigned int i,j;
	for(i=0; i<1024; i++)
	{
		for(j=0; j<512; j++); 
	}
}

void Delay50us(void)
{
	TIM4_CR1 &= 0xFE;//Disable TIM4 counter
	TIM4_IER = 0x00;//Disable TIM4 interrupt
	TIM4_CNTR = 0x00;
	TIM4_CR1 |= 0x01;//Enable TIM4
	while((TIM4_SR&0x01)==0);
	TIM4_SR=0x00;
	TIM4_CR1 &= 0xFE;
}

void Delay500ms(void)
{
	unsigned int i;
	for(i=0;i<=10000;i++)
	{
		Delay50us();
	}
}

void Delay1s(void)
{
	unsigned int i;
	for(i=0;i<=19450;i++)
	{
		Delay50us();
	}
}

void TIM1_Init(void)
{
	_asm("sim");
	TIM1_IER = 0x00;
	TIM1_CR1 = 0x00;
	TIM1_CR2 = 0x00;
	TIM1_PSCRH = 0x1F;//8000-1 DIV----->1KHz
	TIM1_PSCRL = 0x3F;
	
	//TIM1_ARRx = 1000 TIME is 1.006 Second
	TIM1_ARRH = (unsigned char)(990 >> 8);
	TIM1_ARRL = (unsigned char)990;
	TIM1_EGR = 0X01;
	TIM1_CR1 &= 0xFE;
	//TIM1_IER |= 0x01;
	_asm("rim");
}

/*void TIM2_Init(void)
{
	_asm("sim");
	TIM2_IER = 0x00;//disable TIM2 interrupt
	//TIM2_EGR = 0X01;
	TIM2_CR1 = 0x00;//Counter go on when update occur
	TIM2_PSCR= 0x03;//Fcpu:8Mhz,counter:1uS
	
	TIM2_ARRH = 0x00;//47uS
	TIM2_ARRL = 0x2F;
	TIM2_CNTRH = 0x00;
	TIM2_CNTRL = 0x00;
	
	ITC_SPR4 |= 0x01<<2;//set TIM2 UPD_INT priority to 1
	ITC_SPR4 &= ~(0x01<<3);	
	_asm("rim");
}
*/


@far @interrupt void TIM4_UPD_IRQHandler(void)
{
 	//TIM4_SR1 &= 0xFE;//clear interrupt label	
}
