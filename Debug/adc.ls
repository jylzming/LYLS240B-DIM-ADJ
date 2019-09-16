   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3254                     ; 3 void InitADC(void)
3254                     ; 4 {
3256                     	switch	.text
3257  0000               _InitADC:
3261                     ; 6 	PD_DDR &= 0xBF;//1011 1111
3263  0000 721d5011      	bres	_PD_DDR,#6
3264                     ; 7 	PD_CR1 &= 0xBF;
3266  0004 721d5012      	bres	_PD_CR1,#6
3267                     ; 8 	PD_CR2 &= 0xBF;
3269  0008 721d5013      	bres	_PD_CR2,#6
3270                     ; 10 	ADC_CR1 = 0x01;//first time open ADC，second time convert ADC data
3272  000c 35015401      	mov	_ADC_CR1,#1
3273                     ; 11 	ADC_CSR = 0X06;//choose channel AIN6
3275  0010 35065400      	mov	_ADC_CSR,#6
3276                     ; 12 	ADC_CR2 = 0X00;//left arrange (default)
3278  0014 725f5402      	clr	_ADC_CR2
3279                     ; 13 }
3282  0018 81            	ret
3329                     .const:	section	.text
3330  0000               L01:
3331  0000 000003ff      	dc.l	1023
3332                     ; 15 unsigned int GetADC(void)
3332                     ; 16 {
3333                     	switch	.text
3334  0019               _GetADC:
3336  0019 5203          	subw	sp,#3
3337       00000003      OFST:	set	3
3340                     ; 18 	volatile unsigned char tmp = 100;
3342  001b a664          	ld	a,#100
3343  001d 6b01          	ld	(OFST-2,sp),a
3344                     ; 19 	ADC_CR1 |= 0x01;//first time open ADC
3346  001f 72105401      	bset	_ADC_CR1,#0
3348  0023               L5322:
3349                     ; 20 	while(tmp--);
3351  0023 7b01          	ld	a,(OFST-2,sp)
3352  0025 0a01          	dec	(OFST-2,sp)
3353  0027 4d            	tnz	a
3354  0028 26f9          	jrne	L5322
3355                     ; 21 	ADC_CR1 |= 0x01;//second time convert ADC data
3357  002a 72105401      	bset	_ADC_CR1,#0
3359  002e               L3422:
3360                     ; 23 	while((ADC_CSR & 0x80) == 0);//waitting for convert finish
3362  002e c65400        	ld	a,_ADC_CSR
3363  0031 a580          	bcp	a,#128
3364  0033 27f9          	jreq	L3422
3365                     ; 24 	ADC_CSR &= 0xEF;//clear the flag of End Of Convert
3367  0035 72195400      	bres	_ADC_CSR,#4
3368                     ; 25 	adcValue = (unsigned int)ADC_DRH;
3370  0039 c65404        	ld	a,_ADC_DRH
3371  003c 5f            	clrw	x
3372  003d 97            	ld	xl,a
3373  003e 1f02          	ldw	(OFST-1,sp),x
3374                     ; 26 	adcValue = adcValue << 2;
3376  0040 0803          	sll	(OFST+0,sp)
3377  0042 0902          	rlc	(OFST-1,sp)
3378  0044 0803          	sll	(OFST+0,sp)
3379  0046 0902          	rlc	(OFST-1,sp)
3380                     ; 27 	adcValue |= ADC_DRL;
3382  0048 c65405        	ld	a,_ADC_DRL
3383  004b 5f            	clrw	x
3384  004c 97            	ld	xl,a
3385  004d 01            	rrwa	x,a
3386  004e 1a03          	or	a,(OFST+0,sp)
3387  0050 01            	rrwa	x,a
3388  0051 1a02          	or	a,(OFST-1,sp)
3389  0053 01            	rrwa	x,a
3390  0054 1f02          	ldw	(OFST-1,sp),x
3391                     ; 29 	return(adcValue * 5000UL / 1023UL);//10位分辨率为1023，即Vdd/1023*ADC
3393  0056 1e02          	ldw	x,(OFST-1,sp)
3394  0058 90ae1388      	ldw	y,#5000
3395  005c cd0000        	call	c_umul
3397  005f ae0000        	ldw	x,#L01
3398  0062 cd0000        	call	c_ludv
3400  0065 be02          	ldw	x,c_lreg+2
3403  0067 5b03          	addw	sp,#3
3404  0069 81            	ret
3417                     	xdef	_GetADC
3418                     	xdef	_InitADC
3419                     	xref.b	c_lreg
3438                     	xref	c_ludv
3439                     	xref	c_umul
3440                     	end
