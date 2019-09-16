#include "uart.h"
#include "relay.h"

unsigned char HexTable[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
unsigned char RX_Buf[BUFFER_SIZE] = {0};
unsigned char RX_End = 0;
unsigned char BufLength = 0;
unsigned char RX_FRAME = 0;
unsigned char frameStart = 0;
unsigned char frameEnd = 0;

void UART_RXGPIO_Config(void)
{
	EXTI_CR1 |= 0x80;//PD only down trigger
	EXTI_CR1 &= 0xBF;
	PD_DDR &= 0xFD;//PD1 IOset as input
	PD_CR1 |= 0x02;//pull up
	PD_CR2 |= 0x02;//EXT interrupt	
}


char StartRXD(void)//use Delay
{
	unsigned char cnt = 0;
	char RX_Byte = 0;
	RX_End = 0;	
	Delay50us();//to the middle of a bit
	
LIGHT = !LIGHT;

	if(RX_BIT == 0)//confirm start bit
	{
		for(cnt=0;cnt<8;cnt++)
		{
			Delay50us();Delay50us();//104uS,to the middle of a bit
			RX_Byte >>= 1;//low bit to high bit 
			if(RX_BIT)
				RX_Byte |= 0x80;
		}
		Delay50us();Delay50us();//104uS,to the middle of a bit
		if(RX_BIT)//stop bit?
		{
			RX_End = 1;	
			return RX_Byte;
		}
		else
			return -1;
		
	}else 
	{
		return -1;
	}
}

@far @interrupt void EXTI3_IRQHandler(void)
{
	static unsigned char index = 0;
	volatile char temp = 0;
	char i = 0, error = 0;
	
	PD_CR2 &= 0xFD;//EXT interrupt disable
	temp=StartRXD();
	
	//frame formate: 0xFE 0xXX 0xXX ... 0xEF; 
	//data length:30, RX_Buf[0+i] =  RX_Buf[15+i]
	if(-1 == temp)
	{
		frameStart = 0;
		frameEnd = 0;
		index = 0;
		memset(RX_Buf, '', BUFFER_SIZE);		
	}
	else if(0xFE == temp)//begin: 0xFE
	{
		frameStart = 1;
		frameEnd = 0;
		index = 0;
		memset(RX_Buf, '', BUFFER_SIZE);
	}
	else if(0xEF == temp)//end: 0xEF
	{
		for(i=0;i<=14;i++)//confirm data is correct
		{
			if(RX_Buf[i] != RX_Buf[i+15])
				error = 1;//data error
		}
		
		if(error == 1)//data error, clear receive data
		{
			frameStart = 0;
			frameEnd = 0;
			index = 0;
			memset(RX_Buf, '', BUFFER_SIZE);			
		}
		else//data correct, set frame receive flag
		{
/********for test************/
for(index=0; index<5; index++)
{
	LIGHT = !LIGHT;
	Delay500ms();
}
/********end test***********/
			frameEnd = 1;
			frameStart = 0;
			BufLength = index;
		}
		index = 0;
	}
	else//data, save to  RX_Buf[i]
	{
		RX_Buf[index++] = temp;
		if(index >= BUFFER_SIZE)
			index = 0;
	}
	
	PD_CR2 |= 0x02;//EXT interrupt enable
}

