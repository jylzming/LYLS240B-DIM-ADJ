   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 571                     ; 3 void InitADC(void)
 571                     ; 4 {
 572                     	scross	off
 573  0000               _InitADC:
 575                     ; 6 	PD_DDR &= 0xBF;//1011 1111
 576  0000 721d5011      	bres	_PD_DDR,#6
 577                     ; 7 	PD_CR1 &= 0xBF;
 578  0004 721d5012      	bres	_PD_CR1,#6
 579                     ; 8 	PD_CR2 &= 0xBF;
 580  0008 721d5013      	bres	_PD_CR2,#6
 581                     ; 10 	ADC_CR1 = 0x01;//first time open ADC，second time convert ADC data
 582  000c 35015401      	mov	_ADC_CR1,#1
 583                     ; 11 	ADC_CSR = 0X06;//choose channel AIN6
 584  0010 35065400      	mov	_ADC_CSR,#6
 585                     ; 12 	ADC_CR2 = 0X00;//left arrange (default)
 586  0014 725f5402      	clr	_ADC_CR2
 587                     ; 13 }
 588  0018 81            	ret	
 590                     .const:	section	.text
 591  0000               L6:
 592  0000 000003ff      	dc.l	1023
 593                     ; 15 unsigned int GetADC(void)
 593                     ; 16 {
 594                     	switch	.text
 595  0019               _GetADC:
 596  0019 5203          	subw	sp,#3
 597       00000003      OFST:	set	3
 599                     ; 18 	volatile unsigned char tmp = 100;
 600  001b a664          	ld	a,#100
 601  001d 6b01          	ld	(OFST-2,sp),a
 602                     ; 19 	ADC_CR1 |= 0x01;//first time open ADC
 603  001f 72105401      	bset	_ADC_CR1,#0
 605  0023               L5:
 606                     ; 20 	while(tmp--);
 607  0023 7b01          	ld	a,(OFST-2,sp)
 608  0025 0a01          	dec	(OFST-2,sp)
 609  0027 4d            	tnz	a
 610  0028 26f9          	jrne	L5
 611                     ; 21 	ADC_CR1 |= 0x01;//second time convert ADC data
 612  002a 72105401      	bset	_ADC_CR1,#0
 614  002e               L31:
 615                     ; 23 	while((ADC_CSR & 0x80) == 0);//waitting for convert finish
 616  002e 720f5400fb    	btjf	_ADC_CSR,#7,L31
 617                     ; 24 	ADC_CSR &= 0xEF;//clear the flag of End Of Convert
 618  0033 72195400      	bres	_ADC_CSR,#4
 619                     ; 25 	adcValue = (unsigned int)ADC_DRH;
 620  0037 c65404        	ld	a,_ADC_DRH
 621  003a 5f            	clrw	x
 622  003b 97            	ld	xl,a
 623  003c 1f02          	ldw	(OFST-1,sp),x
 624                     ; 26 	adcValue = adcValue << 2;
 625  003e 0803          	sll	(OFST+0,sp)
 626  0040 0902          	rlc	(OFST-1,sp)
 627  0042 0803          	sll	(OFST+0,sp)
 628  0044 0902          	rlc	(OFST-1,sp)
 629                     ; 27 	adcValue |= ADC_DRL;
 630  0046 c65405        	ld	a,_ADC_DRL
 631  0049 5f            	clrw	x
 632  004a 97            	ld	xl,a
 633  004b 01            	rrwa	x,a
 634  004c 1a03          	or	a,(OFST+0,sp)
 635  004e 01            	rrwa	x,a
 636  004f 1a02          	or	a,(OFST-1,sp)
 637  0051 01            	rrwa	x,a
 638  0052 1f02          	ldw	(OFST-1,sp),x
 639                     ; 29 	return(adcValue * 5000UL / 1023UL);//10位分辨率为1023，即Vdd/1023*ADC
 640  0054 1e02          	ldw	x,(OFST-1,sp)
 641  0056 90ae1388      	ldw	y,#5000
 642  005a cd0000        	call	c_umul
 644  005d ae0000        	ldw	x,#L6
 645  0060 cd0000        	call	c_ludv
 647  0063 be02          	ldw	x,c_lreg+2
 649  0065 5b03          	addw	sp,#3
 650  0067 81            	ret	
 652                     	xdef	_GetADC
 653                     	xdef	_InitADC
 654                     	xref.b	c_lreg
 655                     	xref	c_ludv
 656                     	xref	c_umul
 657                     	end
