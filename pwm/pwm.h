#ifndef _PWM_H_
#define _PWM_H_

#include "STM8S001J3.h"
#include "stm8s_bit.h"

#define  PWMIO PA_ODR_3

//void PWM_Init(unsigned int frq, unsigned int percent);
void PWM_Config(unsigned int frq, unsigned int percent);
void PWM_GPIO_Config(void);

#endif
