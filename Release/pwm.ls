   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 571                     ; 4 void PWM_GPIO_Config(void)
 571                     ; 5 {
 572                     	scross	off
 573  0000               _PWM_GPIO_Config:
 575                     ; 6 	PA_DDR |= 0x01 << 3;//PA3 IO口设置为上拉输出
 576  0000 72165002      	bset	_PA_DDR,#3
 577                     ; 7 	PA_CR1 |= 0x01 << 3;
 578  0004 72165003      	bset	_PA_CR1,#3
 579                     ; 8 	PA_CR2 |= 0x01 << 3;
 580  0008 72165004      	bset	_PA_CR2,#3
 581                     ; 9 }
 582  000c 81            	ret	
 584                     ; 12 void PWM_Config(unsigned int frq, unsigned int percent)
 584                     ; 13 {
 585  000d               _PWM_Config:
 586  000d 89            	pushw	x
 587  000e 5204          	subw	sp,#4
 588       00000004      OFST:	set	4
 590                     ; 14 	volatile unsigned int t = 0;
 591  0010 5f            	clrw	x
 592  0011 1f01          	ldw	(OFST-3,sp),x
 593                     ; 15 	volatile unsigned int T = 0;
 594  0013 1f03          	ldw	(OFST-1,sp),x
 595                     ; 16 	T = (unsigned int)(3900 / frq);
 596  0015 ae0f3c        	ldw	x,#3900
 597  0018 1605          	ldw	y,(OFST+1,sp)
 598  001a 65            	divw	x,y
 599  001b 1f03          	ldw	(OFST-1,sp),x
 600                     ; 17 	t = (unsigned int)(percent * T / 100);	
 601  001d 1e09          	ldw	x,(OFST+5,sp)
 602  001f 1603          	ldw	y,(OFST-1,sp)
 603  0021 cd0000        	call	c_imul
 605  0024 a664          	ld	a,#100
 606  0026 62            	div	x,a
 607  0027 1f01          	ldw	(OFST-3,sp),x
 608                     ; 18 	_asm("sim");
 610  0029 9b            	sim	
 612                     ; 20 	if(percent >= 100)
 613  002a 1e09          	ldw	x,(OFST+5,sp)
 614  002c a30064        	cpw	x,#100
 615  002f 2516          	jrult	L3
 616                     ; 22 		CLK_PCKENR1 |= 0x01 << 5;
 617  0031 721a50c7      	bset	_CLK_PCKENR1,#5
 618                     ; 23 		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
 619  0035 3501530e      	mov	_TIM2_PSCR,#1
 620                     ; 28 		TIM2_CCER2 |= 0x01;//PWM CH3 output
 621  0039 7210530b      	bset	_TIM2_CCER2,#0
 622                     ; 29 		TIM2_CCER2 &= 0xFD;
 623  003d 7213530b      	bres	_TIM2_CCER2,#1
 624                     ; 30 		TIM2_CCMR3 = 0x50;//force 1  101
 625  0041 35505309      	mov	_TIM2_CCMR3,#80
 626                     ; 34 		TIM2_CCMR3 |= 0x08;
 627                     ; 35 		TIM2_CR1   |= 0x01;		
 629  0045 204c          	jra	L5
 630  0047               L3:
 631                     ; 37 	else if(percent <= 0)
 632  0047 1e09          	ldw	x,(OFST+5,sp)
 633  0049 2620          	jrne	L7
 634                     ; 39 		CLK_PCKENR1 |= 0x01 << 5;
 635  004b 721a50c7      	bset	_CLK_PCKENR1,#5
 636                     ; 40 		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
 637  004f 3501530e      	mov	_TIM2_PSCR,#1
 638                     ; 42 		TIM2_ARRH = (unsigned char)(T >> 8);
 639  0053 7b03          	ld	a,(OFST-1,sp)
 640  0055 c7530f        	ld	_TIM2_ARRH,a
 641                     ; 43 		TIM2_ARRL = (unsigned char)T;
 642  0058 7b04          	ld	a,(OFST+0,sp)
 643  005a c75310        	ld	_TIM2_ARRL,a
 644                     ; 45 		TIM2_CCER2 |= 0x01;//PWM CH3 output
 645  005d 7210530b      	bset	_TIM2_CCER2,#0
 646                     ; 46 		TIM2_CCER2 &= 0xFD;
 647  0061 7213530b      	bres	_TIM2_CCER2,#1
 648                     ; 47 		TIM2_CCMR3 = 0x40;//force 0  100
 649  0065 35405309      	mov	_TIM2_CCMR3,#64
 650                     ; 49 		TIM2_CCR3H = (unsigned char)(t >> 8);
 651                     ; 50 		TIM2_CCR3L = (unsigned char)t;
 652                     ; 52 		TIM2_CCMR3 |= 0x08;
 653                     ; 53 		TIM2_CR1   |= 0x01;
 655  0069 201e          	jp	LC001
 656  006b               L7:
 657                     ; 57 		CLK_PCKENR1 |= 0x01 << 5;
 658  006b 721a50c7      	bset	_CLK_PCKENR1,#5
 659                     ; 58 		TIM2_PSCR = 0x01;//2Mhz/2^1=1MHz
 660  006f 3501530e      	mov	_TIM2_PSCR,#1
 661                     ; 60 		TIM2_ARRH = (unsigned char)(T >> 8);
 662  0073 7b03          	ld	a,(OFST-1,sp)
 663  0075 c7530f        	ld	_TIM2_ARRH,a
 664                     ; 61 		TIM2_ARRL = (unsigned char)T;
 665  0078 7b04          	ld	a,(OFST+0,sp)
 666  007a c75310        	ld	_TIM2_ARRL,a
 667                     ; 63 		TIM2_CCER2 |= 0x01;//PWM CH3 output
 668  007d 7210530b      	bset	_TIM2_CCER2,#0
 669                     ; 64 		TIM2_CCER2 &= 0xFD;
 670  0081 7213530b      	bres	_TIM2_CCER2,#1
 671                     ; 65 		TIM2_CCMR3 = 0x60;//PWM mode 1  110
 672  0085 35605309      	mov	_TIM2_CCMR3,#96
 673                     ; 67 		TIM2_CCR3H = (unsigned char)(t >> 8);
 674                     ; 68 		TIM2_CCR3L = (unsigned char)t;
 675  0089               LC001:
 676  0089 7b01          	ld	a,(OFST-3,sp)
 677  008b c75315        	ld	_TIM2_CCR3H,a
 678  008e 7b02          	ld	a,(OFST-2,sp)
 679  0090 c75316        	ld	_TIM2_CCR3L,a
 680                     ; 70 		TIM2_CCMR3 |= 0x08;
 681                     ; 71 		TIM2_CR1   |= 0x01;
 682  0093               L5:
 683  0093 72165309      	bset	_TIM2_CCMR3,#3
 684  0097 72105300      	bset	_TIM2_CR1,#0
 685                     ; 73 	_asm("rim");
 687  009b 9a            	rim	
 689                     ; 74 }
 690  009c 5b06          	addw	sp,#6
 691  009e 81            	ret	
 693                     	xdef	_PWM_GPIO_Config
 694                     	xdef	_PWM_Config
 695                     	xref	c_imul
 696                     	end
