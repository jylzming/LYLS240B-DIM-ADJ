#include "adc.h"

void InitADC(void)
{
	//PD6 set as FloatingInput
	PD_DDR &= 0xBF;//1011 1111
	PD_CR1 &= 0xBF;
	PD_CR2 &= 0xBF;
	
	ADC_CR1 = 0x01;//first time open ADC，second time convert ADC data
	ADC_CSR = 0X06;//choose channel AIN6
	ADC_CR2 = 0X00;//left arrange (default)
}

unsigned int GetADC(void)
{
	volatile unsigned int adcValue;
	volatile unsigned char tmp = 100;
	ADC_CR1 |= 0x01;//first time open ADC
	while(tmp--);
	ADC_CR1 |= 0x01;//second time convert ADC data
	
	while((ADC_CSR & 0x80) == 0);//waitting for convert finish
	ADC_CSR &= 0xEF;//clear the flag of End Of Convert
	adcValue = (unsigned int)ADC_DRH;
	adcValue = adcValue << 2;
	adcValue |= ADC_DRL;
		
	return(adcValue * 5000UL / 1023UL);//10位分辨率为1023，即Vdd/1023*ADC
}
