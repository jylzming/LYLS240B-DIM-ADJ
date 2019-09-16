   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3251                     ; 4 void PWM_GPIO_Config(void)
3251                     ; 5 {
3253                     	switch	.text
3254  0000               _PWM_GPIO_Config:
3258                     ; 6 	PA_DDR |= 0x01 << 3;//PA3 IO口设置为上拉输出
3260  0000 72165002      	bset	_PA_DDR,#3
3261                     ; 7 	PA_CR1 |= 0x01 << 3;
3263  0004 72165003      	bset	_PA_CR1,#3
3264                     ; 8 	PA_CR2 |= 0x01 << 3;
3266  0008 72165004      	bset	_PA_CR2,#3
3267                     ; 9 }
3270  000c 81            	ret
3340                     ; 12 void PWM_Config(unsigned int frq, unsigned int percent)
3340                     ; 13 {
3341                     	switch	.text
3342  000d               _PWM_Config:
3344  000d 89            	pushw	x
3345  000e 5204          	subw	sp,#4
3346       00000004      OFST:	set	4
3349                     ; 14 	volatile unsigned int t = 0;
3351  0010 5f            	clrw	x
3352  0011 1f01          	ldw	(OFST-3,sp),x
3353                     ; 15 	volatile unsigned int T = 0;
3355  0013 5f            	clrw	x
3356  0014 1f03          	ldw	(OFST-1,sp),x
3357                     ; 16 	T = (unsigned int)(3900 / frq);
3359  0016 ae0f3c        	ldw	x,#3900
3360  0019 1605          	ldw	y,(OFST+1,sp)
3361  001b 65            	divw	x,y
3362  001c 1f03          	ldw	(OFST-1,sp),x
3363                     ; 17 	t = (unsigned int)(percent * T / 100);	
3365  001e 1e09          	ldw	x,(OFST+5,sp)
3366  0020 1603          	ldw	y,(OFST-1,sp)
3367  0022 cd0000        	call	c_imul
3369  0025 a664          	ld	a,#100
3370  0027 62            	div	x,a
3371  0028 1f01          	ldw	(OFST-3,sp),x
3372                     ; 18 	_asm("sim");
3375  002a 9b            sim
3377                     ; 20 	if(percent >= 100)
3379  002b 1e09          	ldw	x,(OFST+5,sp)
3380  002d a30064        	cpw	x,#100
3381  0030 251e          	jrult	L3422
3382                     ; 22 		CLK_PCKENR1 |= 0x01 << 5;
3384  0032 721a50c7      	bset	_CLK_PCKENR1,#5
3385                     ; 23 		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
3387  0036 3501530e      	mov	_TIM2_PSCR,#1
3388                     ; 28 		TIM2_CCER2 |= 0x01;//PWM CH3 output
3390  003a 7210530b      	bset	_TIM2_CCER2,#0
3391                     ; 29 		TIM2_CCER2 &= 0xFD;
3393  003e 7213530b      	bres	_TIM2_CCER2,#1
3394                     ; 30 		TIM2_CCMR3 = 0x50;//force 1  101
3396  0042 35505309      	mov	_TIM2_CCMR3,#80
3397                     ; 34 		TIM2_CCMR3 |= 0x08;
3399  0046 72165309      	bset	_TIM2_CCMR3,#3
3400                     ; 35 		TIM2_CR1   |= 0x01;		
3402  004a 72105300      	bset	_TIM2_CR1,#0
3404  004e 2066          	jra	L5422
3405  0050               L3422:
3406                     ; 37 	else if(percent <= 0)
3408  0050 1e09          	ldw	x,(OFST+5,sp)
3409  0052 2632          	jrne	L7422
3410                     ; 39 		CLK_PCKENR1 |= 0x01 << 5;
3412  0054 721a50c7      	bset	_CLK_PCKENR1,#5
3413                     ; 40 		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
3415  0058 3501530e      	mov	_TIM2_PSCR,#1
3416                     ; 42 		TIM2_ARRH = (unsigned char)(T >> 8);
3418  005c 7b03          	ld	a,(OFST-1,sp)
3419  005e c7530f        	ld	_TIM2_ARRH,a
3420                     ; 43 		TIM2_ARRL = (unsigned char)T;
3422  0061 7b04          	ld	a,(OFST+0,sp)
3423  0063 c75310        	ld	_TIM2_ARRL,a
3424                     ; 45 		TIM2_CCER2 |= 0x01;//PWM CH3 output
3426  0066 7210530b      	bset	_TIM2_CCER2,#0
3427                     ; 46 		TIM2_CCER2 &= 0xFD;
3429  006a 7213530b      	bres	_TIM2_CCER2,#1
3430                     ; 47 		TIM2_CCMR3 = 0x40;//force 0  100
3432  006e 35405309      	mov	_TIM2_CCMR3,#64
3433                     ; 49 		TIM2_CCR3H = (unsigned char)(t >> 8);
3435  0072 7b01          	ld	a,(OFST-3,sp)
3436  0074 c75315        	ld	_TIM2_CCR3H,a
3437                     ; 50 		TIM2_CCR3L = (unsigned char)t;
3439  0077 7b02          	ld	a,(OFST-2,sp)
3440  0079 c75316        	ld	_TIM2_CCR3L,a
3441                     ; 52 		TIM2_CCMR3 |= 0x08;
3443  007c 72165309      	bset	_TIM2_CCMR3,#3
3444                     ; 53 		TIM2_CR1   |= 0x01;
3446  0080 72105300      	bset	_TIM2_CR1,#0
3448  0084 2030          	jra	L5422
3449  0086               L7422:
3450                     ; 57 		CLK_PCKENR1 |= 0x01 << 5;
3452  0086 721a50c7      	bset	_CLK_PCKENR1,#5
3453                     ; 58 		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
3455  008a 3501530e      	mov	_TIM2_PSCR,#1
3456                     ; 60 		TIM2_ARRH = (unsigned char)(T >> 8);
3458  008e 7b03          	ld	a,(OFST-1,sp)
3459  0090 c7530f        	ld	_TIM2_ARRH,a
3460                     ; 61 		TIM2_ARRL = (unsigned char)T;
3462  0093 7b04          	ld	a,(OFST+0,sp)
3463  0095 c75310        	ld	_TIM2_ARRL,a
3464                     ; 63 		TIM2_CCER2 |= 0x01;//PWM CH3 output
3466  0098 7210530b      	bset	_TIM2_CCER2,#0
3467                     ; 64 		TIM2_CCER2 &= 0xFD;
3469  009c 7213530b      	bres	_TIM2_CCER2,#1
3470                     ; 65 		TIM2_CCMR3 = 0x60;//PWM mode 1  110
3472  00a0 35605309      	mov	_TIM2_CCMR3,#96
3473                     ; 67 		TIM2_CCR3H = (unsigned char)(t >> 8);
3475  00a4 7b01          	ld	a,(OFST-3,sp)
3476  00a6 c75315        	ld	_TIM2_CCR3H,a
3477                     ; 68 		TIM2_CCR3L = (unsigned char)t;
3479  00a9 7b02          	ld	a,(OFST-2,sp)
3480  00ab c75316        	ld	_TIM2_CCR3L,a
3481                     ; 70 		TIM2_CCMR3 |= 0x08;
3483  00ae 72165309      	bset	_TIM2_CCMR3,#3
3484                     ; 71 		TIM2_CR1   |= 0x01;
3486  00b2 72105300      	bset	_TIM2_CR1,#0
3487  00b6               L5422:
3488                     ; 73 	_asm("rim");
3491  00b6 9a            rim
3493                     ; 74 }
3496  00b7 5b06          	addw	sp,#6
3497  00b9 81            	ret
3510                     	xdef	_PWM_GPIO_Config
3511                     	xdef	_PWM_Config
3530                     	xref	c_imul
3531                     	end
