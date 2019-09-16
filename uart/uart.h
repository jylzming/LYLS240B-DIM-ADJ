#ifndef _UART_H_
#define _UART_H_

#include <string.h>
#include "STM8S001J3.h"
#include "stm8s_bit.h"
#include "delay.h"

#define RX_BIT PD_IDR_1
#define BUFFER_SIZE		64

extern unsigned char uartStart;
extern unsigned char RX_Buf[BUFFER_SIZE];
extern unsigned char RX_End;
extern unsigned char BufLength;
extern unsigned char RX_FRAME;
extern unsigned char frameStart;
extern unsigned char frameEnd;

void UART_RXGPIO_Config(void);
char StartRXD(void);

#endif
