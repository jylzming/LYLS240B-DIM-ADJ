#ifndef _DELAY_H_
#define _DELAY_H_

#include "STM8S001J3.h"
#include "stm8s_bit.h"

void Delay(void);
void Delay50us(void);
void Delay500ms(void);
void Delay1s(void);
void TIM1_Init(void);
void TIM4_Init(void);

#endif
