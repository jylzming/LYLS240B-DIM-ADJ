#include "pwm.h"
//#include "global.h"

void PWM_GPIO_Config(void)
{
	PA_DDR |= 0x01 << 3;//PA3 IO口设置为上拉输出
	PA_CR1 |= 0x01 << 3;
	PA_CR2 |= 0x01 << 3;
}


void PWM_Config(unsigned int frq, unsigned int percent)
{
	volatile unsigned int t = 0;
	volatile unsigned int T = 0;
	T = (unsigned int)(3900 / frq);
	t = (unsigned int)(percent * T / 100);	
	_asm("sim");
	
	if(percent >= 100)
	{
		CLK_PCKENR1 |= 0x01 << 5;
		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
	
		//TIM2_ARRH = (unsigned char)(T >> 8);
		//TIM2_ARRL = (unsigned char)T;
	
		TIM2_CCER2 |= 0x01;//PWM CH3 output
		TIM2_CCER2 &= 0xFD;
		TIM2_CCMR3 = 0x50;//force 1  101
	
		//TIM2_CCR3H = (unsigned char)(t >> 8);
		//TIM2_CCR3L = (unsigned char)t;
		TIM2_CCMR3 |= 0x08;
		TIM2_CR1   |= 0x01;		
	}
	else if(percent <= 0)
	{
		CLK_PCKENR1 |= 0x01 << 5;
		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
	
		TIM2_ARRH = (unsigned char)(T >> 8);
		TIM2_ARRL = (unsigned char)T;
	
		TIM2_CCER2 |= 0x01;//PWM CH3 output
		TIM2_CCER2 &= 0xFD;
		TIM2_CCMR3 = 0x40;//force 0  100
	
		TIM2_CCR3H = (unsigned char)(t >> 8);
		TIM2_CCR3L = (unsigned char)t;
	
		TIM2_CCMR3 |= 0x08;
		TIM2_CR1   |= 0x01;
	}
	else
	{
		CLK_PCKENR1 |= 0x01 << 5;
		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
	
		TIM2_ARRH = (unsigned char)(T >> 8);
		TIM2_ARRL = (unsigned char)T;
	
		TIM2_CCER2 |= 0x01;//PWM CH3 output
		TIM2_CCER2 &= 0xFD;
		TIM2_CCMR3 = 0x60;//PWM mode 1  110
	
		TIM2_CCR3H = (unsigned char)(t >> 8);
		TIM2_CCR3L = (unsigned char)t;
	
		TIM2_CCMR3 |= 0x08;
		TIM2_CR1   |= 0x01;
	}
	_asm("rim");
}

