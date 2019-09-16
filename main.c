/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "STM8S001J3.h"
#include "stm8s_bit.h"
//#include "stdio.h"
#include "relay.h"
#include "pwm.h"
#include "adc.h"
#include "delay.h"
#include "global.h"
#include "uart.h"
#include "eeprom.h"
#include <string.h>

typedef enum {MODE0 = 0, MODE1 = 1, MODE2 = 2, MODE3 = 3, MODE4 = 4, MODE5 = 5, MODE6 = 6} Mode;
typedef enum {STATE0 = 0, STATE1 = 1, STATE2 = 2, STATE3 = 3, STATE4 = 4, STATE5 = 5, STATE6 = 6} State;


unsigned char brightness = BRIGHTNESS; //brightness(0~100),brightness should be add about 3 is correct
unsigned char read_Flash[11] = {0};
unsigned int second = 0;
unsigned int hour = 0;

bool relayStat = ON;
bool isDimmingConfiged = FALSE;
bool timeChanged = FALSE;
State state;
static State ex_state = STATE0;

void DimmingMode(Mode mode)
{
	if(LIGHT == ON)
	{
		switch (mode)
		{
			case MODE0:
				if(hour >= 0 && hour < 6)
					state = STATE1;
				else if(hour >= 6 && hour < 10)//(hour >= 6 && hour < 10)
					state = STATE2;
				else if(hour >= 10) 
					state = STATE3;
			break;		
	
			case MODE1:
				if(hour >= 0 && hour < 6)
					state = STATE1;
				else if(hour >= 6)//(hour >= 6 && hour < 10)
					state = STATE2;
			break;
			
			case MODE2:
				if(hour >= 0 && hour < 9)
					state = STATE1;
				else if(hour >= 9)//always in dimming state
					state = STATE2;
			break;	
			
			case MODE3: 	
				if(second >= 0 && second < 10)
					state = STATE1;
				else if(second >= 10 && second < 20)//(hour >= 6 && hour < 10)
					state = STATE2;
				else if(second >= 20) 
					state = STATE3;		
			break;

			case MODE4:
				if(hour >= 0 && hour < 1)//1hour
					state = STATE1;
				else if(hour >= 1 && hour < 4)//3hours
					state = STATE2;
				else if(hour >= 4 && hour < 5)//1hour
					state = STATE3;					
				else if(hour >= 5 && hour < 12)//7hours
					state = STATE4;
				else
					state = STATE5;
			break;

			case MODE5:
				if(hour >= 0 && hour < 5)//5hour
					state = STATE1;
				else if(hour >= 5 && hour < 7)//2hours
					state = STATE2;
				else if(hour >= 7 && hour < 11)//4hour
					state = STATE3;					
				else if(hour >= 11 && hour < 12)//1hours
					state = STATE4;
				else
					state = STATE5;
			break;

			case MODE6:
				if(second >= 0 && second < RX_Buf[0])
					state = STATE1;
				else if(second>=read_Flash[0] && second<(read_Flash[0]+read_Flash[2]))
					state = STATE2;
				else if(second>=(read_Flash[0]+read_Flash[2]) && second<(read_Flash[0]+read_Flash[2]+read_Flash[4]))
					state = STATE3;					
				else if(second>=(read_Flash[0]+read_Flash[2]+read_Flash[4]) && second<(read_Flash[0]+read_Flash[2]+read_Flash[4]+read_Flash[6]))
					state = STATE4;
				else if(second>=(read_Flash[0]+read_Flash[2]+read_Flash[4]+read_Flash[6]) && second<(read_Flash[0]+read_Flash[2]+read_Flash[4]+read_Flash[6]+read_Flash[8]))
					state = STATE5;
				else
					state = STATE6;
			break;
			
			default:	break;
		}
	}
	//when state changed
	if(ex_state != state)
	{
		if(mode == MODE5)
		{
			switch (state)
			{
				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
				case STATE1:	PWM_Config(100, 100);	break;
				case STATE2:	PWM_Config(100, 75);	break;			
				case STATE3:	PWM_Config(100, 50);	break;
				case STATE4:	PWM_Config(100, 60);	break;
				case STATE5:	PWM_Config(100, 60);	break;
				default: break;
			}		
		}
		else if(mode == MODE6)
		{
			switch (state)
			{
				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
				case STATE1:	PWM_Config(100, read_Flash[1]);	break;
				case STATE2:	PWM_Config(100, read_Flash[3]);	break;			
				case STATE3:	PWM_Config(100, read_Flash[5]);	break;
				case STATE4:	PWM_Config(100, read_Flash[7]);	break;
				case STATE5:	PWM_Config(100, read_Flash[9]);	break;			
				case STATE6:	PWM_Config(100, 0);	break;
				default: break;
			}		
		}		
		else
		{
			switch (state)
			{
				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
				case STATE1:	PWM_Config(100, 100);	break;
				case STATE2:	PWM_Config(100, brightness);	break;			
				case STATE3:	PWM_Config(100, 80);	break;			
				default: break;
			}
		}
	}	else;//when state no change, do nothing
	ex_state = state;
}
		

main()
{
	unsigned char i = 0, error = 0;
	unsigned char tmp[BUFFER_SIZE];
	volatile static unsigned char adcCount = 0;
	unsigned int x,y;
	unsigned int OFF_LUX = 0;
	unsigned int ON_LUX = 0;
	bool exRelayStat = OFF;
	static unsigned int adcData[5] = {0,0,0,0,0};
	CFG_GCR = 0x00;//PD1 default SWIM
	CLK_CKDIVR = 0x08;//f = f HSI RCÊä³ö/2=8MHz
	memset(tmp, '', BUFFER_SIZE);
	memset(RX_Buf, '', BUFFER_SIZE);
	memset(read_Flash, '', 11);
	TIM4_Init();//use for delay, high
	for(i=0;i<=12;i++)
	{
		read_Flash[i] = FLASH_ReadByte(0x004000+i);
	}
	ON_LUX  = ((unsigned int)read_Flash[11]<<8 | read_Flash[12]);
	OFF_LUX = ((unsigned int)read_Flash[13]<<8 | read_Flash[14]);
	//delay a while in cace ADC get the wrong voltage
	Delay1s(); Delay1s(); Delay1s(); Delay1s(); Delay1s(); //about 5s
	CFG_GCR = 0x01;//disable SWIM,PD1 set as GPIO
	UART_RXGPIO_Config();//PD1 SWIM change to UART_RX
	PWM_GPIO_Config();//Dimming IO config, use TIM2
	//Get ADC initial data and check the light ON/OFF state
	InitADC();	
	adcData[0] = adcData[1] = adcData[2] = adcData[3] = adcData[4] = GetADC();

	Rly_GPIO_Config();

/*	//read_Flash[11]--ON_LUX, read_Flash[12]--OFF_LUX
	if(adcData[0] < read_Flash[11])//initial LIGHT IO
	{
		LIGHT = OFF;
		PWM_Config(100, 0);//PWM off
	}
	else
	{
		LIGHT = ON;
		PWM_Config(100, 100);//PWM off
	}

	//Time1 use for time counter, 1S/interrupt service
	TIM1_Init();
*/
	_asm("rim"); //Enable interrupt
	while(1)
	{
/*		while(frameEnd)
		{
			LIGHT = !LIGHT;	Delay();
			//Delay1s();
		}
*/		
		LIGHT = ON;	Delay();Delay();Delay();Delay();
		LIGHT = OFF;Delay();Delay();Delay();Delay();
		//Delay1s();Delay1s();Delay1s();Delay1s();

	}

	while(0)
	{
		//receive message frame, save to Flash
		while(frameEnd == 1)
		{
			
	Delay1s();
	LIGHT = !LIGHT;
	Delay1s();
	LIGHT = !LIGHT;
	
			_asm("sim");
			while(!UnlockEEPROM());
			for(i=0;i<BufLength;i++)
			{
				FLASH_ProgramByte(0x004000+i, RX_Buf[i]);
			}
			LockEEPROM();
			for(i=0;i<BufLength;i++)
			{
				tmp[i] = FLASH_ReadByte(0x004000+i);
			}
			//memset(tmp, '', BUFFER_SIZE);
			for(i=0;i<=14;i++)//confirm data is correct
			{
				if(RX_Buf[i] != tmp[i+15])
				error = 1;//data error
			}
			if(error == 0)
			{
				for(i=0;i<=14;i++)
				{
					read_Flash[i] = FLASH_ReadByte(0x004000+i);
				}
				ON_LUX  = ((unsigned int)read_Flash[11]<<8 | read_Flash[12]);
				OFF_LUX = ((unsigned int)read_Flash[13]<<8 | read_Flash[14]);
				for(i=0;i<10;i++)
				{
					LIGHT = !LIGHT;
					Delay1s();
				}
			}else;
			frameEnd = 0;
			_asm("rim");
		}
		while(frameEnd == 0)
		{
			adcData[adcCount++] = GetADC();
			if(adcCount > 4)	adcCount = 0;
			
			//if it's daytime, turn the light off
			if(adcData[0] < OFF_LUX \
			&& adcData[1] < OFF_LUX \
			&& adcData[2] < OFF_LUX \
			&& adcData[3] < OFF_LUX \
			&& adcData[4] < OFF_LUX)
			{
				if(LIGHT == ON)//only when light on/off change 
				{
					LIGHT = OFF;//Relay_IO = 1
					PWM_Config(100, 0);//PWM off
					TIM1_CR1 &= 0xFE;//stop time counter
				}
				if(state != STATE0)
					ex_state = state = STATE0;
					
				second = 0;
				hour = 0;
			}		
			//if it's nighttime, turn the light on
			else if(adcData[0] > ON_LUX \
			&& adcData[1] > ON_LUX \
			&& adcData[2] > ON_LUX \
			&& adcData[3] > ON_LUX \
			&& adcData[4] > ON_LUX)
			{
				if(LIGHT == OFF)//only when light on/off change 
				{
					LIGHT = ON;
				}	
				if((TIM1_CR1 & 0x01) == 0)//if time counter not started, start counting
				{
					second = 0;
					hour = 0;
					TIM1_CR1 |= 0x01;//start time counter
					TIM1_IER |= 0x01;				
				}
				if(state == STATE0)
				{
					PWM_Config(100, 100);
				}
			}
			else;//when the the lux is between ON/OFF, do nothing			
			DimmingMode(userMode);
			Delay1s();
		}
	}
}

/****************************************************/
@far @interrupt void TIM1_UPD_IRQHandler(void)
{
	unsigned char i = 0;
	TIM1_SR1 &= 0xFE;//clear interrupt label
	second++;
	if(second >= 3600)/***********´ý±ä¸ü£¡£¡£¡£¡£¡***************/
	{
		second = 0;
		hour += 1;
		if(hour > 65536)
			hour = 0;
	}
}

