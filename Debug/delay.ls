   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3254                     ; 7 void TIM4_Init(void)
3254                     ; 8 {
3256                     	switch	.text
3257  0000               _TIM4_Init:
3261                     ; 9 	_asm("sim");
3264  0000 9b            sim
3266                     ; 10 	TIM4_IER = 0x00;//disable TIM4 interrupt
3268  0001 725f5343      	clr	_TIM4_IER
3269                     ; 12 	TIM4_CR1 = 0x00;//Counter go on when update occur
3271  0005 725f5340      	clr	_TIM4_CR1
3272                     ; 13 	TIM4_PSCR= 0x03;//Fcpu:8Mhz,counter:1uS
3274  0009 35035347      	mov	_TIM4_PSCR,#3
3275                     ; 14 	TIM4_ARR = 0x2E;//test:0x2E~51.5uS, 0x2D~50uS
3277  000d 352e5348      	mov	_TIM4_ARR,#46
3278                     ; 15 	TIM4_CNTR = 0x00;
3280  0011 725f5346      	clr	_TIM4_CNTR
3281                     ; 17 	ITC_SPR6 |= 0x80;//set TIM4 UPD_INT priority to 1
3283  0015 721e7f75      	bset	_ITC_SPR6,#7
3284                     ; 18 	ITC_SPR6 &= 0xBF;	
3286  0019 721d7f75      	bres	_ITC_SPR6,#6
3287                     ; 19 	_asm("rim");
3290  001d 9a            rim
3292                     ; 20 }
3295  001e 81            	ret
3338                     ; 22 void Delay(void)
3338                     ; 23 {
3339                     	switch	.text
3340  001f               _Delay:
3342  001f 5204          	subw	sp,#4
3343       00000004      OFST:	set	4
3346                     ; 25 	for(i=0; i<1024; i++)
3348  0021 5f            	clrw	x
3349  0022 1f01          	ldw	(OFST-3,sp),x
3351  0024 201a          	jra	L7322
3352  0026               L3322:
3353                     ; 27 		for(j=0; j<512; j++); 
3355  0026 5f            	clrw	x
3356  0027 1f03          	ldw	(OFST-1,sp),x
3358  0029 2007          	jra	L7422
3359  002b               L3422:
3363  002b 1e03          	ldw	x,(OFST-1,sp)
3364  002d 1c0001        	addw	x,#1
3365  0030 1f03          	ldw	(OFST-1,sp),x
3366  0032               L7422:
3369  0032 1e03          	ldw	x,(OFST-1,sp)
3370  0034 a30200        	cpw	x,#512
3371  0037 25f2          	jrult	L3422
3372                     ; 25 	for(i=0; i<1024; i++)
3374  0039 1e01          	ldw	x,(OFST-3,sp)
3375  003b 1c0001        	addw	x,#1
3376  003e 1f01          	ldw	(OFST-3,sp),x
3377  0040               L7322:
3380  0040 1e01          	ldw	x,(OFST-3,sp)
3381  0042 a30400        	cpw	x,#1024
3382  0045 25df          	jrult	L3322
3383                     ; 29 }
3386  0047 5b04          	addw	sp,#4
3387  0049 81            	ret
3414                     ; 31 void Delay50us(void)
3414                     ; 32 {
3415                     	switch	.text
3416  004a               _Delay50us:
3420                     ; 33 	TIM4_CR1 &= 0xFE;//Disable TIM4 counter
3422  004a 72115340      	bres	_TIM4_CR1,#0
3423                     ; 34 	TIM4_IER = 0x00;//Disable TIM4 interrupt
3425  004e 725f5343      	clr	_TIM4_IER
3426                     ; 35 	TIM4_CNTR = 0x00;
3428  0052 725f5346      	clr	_TIM4_CNTR
3429                     ; 36 	TIM4_CR1 |= 0x01;//Enable TIM4
3431  0056 72105340      	bset	_TIM4_CR1,#0
3433  005a               L5622:
3434                     ; 37 	while((TIM4_SR&0x01)==0);
3436  005a c65344        	ld	a,_TIM4_SR
3437  005d a501          	bcp	a,#1
3438  005f 27f9          	jreq	L5622
3439                     ; 38 	TIM4_SR=0x00;
3441  0061 725f5344      	clr	_TIM4_SR
3442                     ; 39 	TIM4_CR1 &= 0xFE;
3444  0065 72115340      	bres	_TIM4_CR1,#0
3445                     ; 40 }
3448  0069 81            	ret
3483                     ; 42 void Delay500ms(void)
3483                     ; 43 {
3484                     	switch	.text
3485  006a               _Delay500ms:
3487  006a 89            	pushw	x
3488       00000002      OFST:	set	2
3491                     ; 45 	for(i=0;i<=10000;i++)
3493  006b 5f            	clrw	x
3494  006c 1f01          	ldw	(OFST-1,sp),x
3495  006e               L7032:
3496                     ; 47 		Delay50us();
3498  006e adda          	call	_Delay50us
3500                     ; 45 	for(i=0;i<=10000;i++)
3502  0070 1e01          	ldw	x,(OFST-1,sp)
3503  0072 1c0001        	addw	x,#1
3504  0075 1f01          	ldw	(OFST-1,sp),x
3507  0077 1e01          	ldw	x,(OFST-1,sp)
3508  0079 a32711        	cpw	x,#10001
3509  007c 25f0          	jrult	L7032
3510                     ; 49 }
3513  007e 85            	popw	x
3514  007f 81            	ret
3549                     ; 51 void Delay1s(void)
3549                     ; 52 {
3550                     	switch	.text
3551  0080               _Delay1s:
3553  0080 89            	pushw	x
3554       00000002      OFST:	set	2
3557                     ; 54 	for(i=0;i<=19450;i++)
3559  0081 5f            	clrw	x
3560  0082 1f01          	ldw	(OFST-1,sp),x
3561  0084               L3332:
3562                     ; 56 		Delay50us();
3564  0084 adc4          	call	_Delay50us
3566                     ; 54 	for(i=0;i<=19450;i++)
3568  0086 1e01          	ldw	x,(OFST-1,sp)
3569  0088 1c0001        	addw	x,#1
3570  008b 1f01          	ldw	(OFST-1,sp),x
3573  008d 1e01          	ldw	x,(OFST-1,sp)
3574  008f a34bfb        	cpw	x,#19451
3575  0092 25f0          	jrult	L3332
3576                     ; 58 }
3579  0094 85            	popw	x
3580  0095 81            	ret
3611                     ; 60 void TIM1_Init(void)
3611                     ; 61 {
3612                     	switch	.text
3613  0096               _TIM1_Init:
3617                     ; 62 	_asm("sim");
3620  0096 9b            sim
3622                     ; 63 	TIM1_IER = 0x00;
3624  0097 725f5254      	clr	_TIM1_IER
3625                     ; 64 	TIM1_CR1 = 0x00;
3627  009b 725f5250      	clr	_TIM1_CR1
3628                     ; 65 	TIM1_CR2 = 0x00;
3630  009f 725f5251      	clr	_TIM1_CR2
3631                     ; 66 	TIM1_PSCRH = 0x1F;//8000-1 DIV----->1KHz
3633  00a3 351f5260      	mov	_TIM1_PSCRH,#31
3634                     ; 67 	TIM1_PSCRL = 0x3F;
3636  00a7 353f5261      	mov	_TIM1_PSCRL,#63
3637                     ; 70 	TIM1_ARRH = (unsigned char)(990 >> 8);
3639  00ab 35035262      	mov	_TIM1_ARRH,#3
3640                     ; 71 	TIM1_ARRL = (unsigned char)990;
3642  00af 35de5263      	mov	_TIM1_ARRL,#222
3643                     ; 72 	TIM1_EGR = 0X01;
3645  00b3 35015257      	mov	_TIM1_EGR,#1
3646                     ; 73 	TIM1_CR1 &= 0xFE;
3648  00b7 72115250      	bres	_TIM1_CR1,#0
3649                     ; 75 	_asm("rim");
3652  00bb 9a            rim
3654                     ; 76 }
3657  00bc 81            	ret
3681                     ; 98 @far @interrupt void TIM4_UPD_IRQHandler(void)
3681                     ; 99 {
3683                     	switch	.text
3684  00bd               f_TIM4_UPD_IRQHandler:
3689                     ; 101 }
3692  00bd 80            	iret
3704                     	xdef	f_TIM4_UPD_IRQHandler
3705                     	xdef	_TIM4_Init
3706                     	xdef	_TIM1_Init
3707                     	xdef	_Delay1s
3708                     	xdef	_Delay500ms
3709                     	xdef	_Delay50us
3710                     	xdef	_Delay
3729                     	end
