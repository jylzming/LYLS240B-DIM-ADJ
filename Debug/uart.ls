   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3213                     	bsct
3214  0000               _HexTable:
3215  0000 30            	dc.b	48
3216  0001 31            	dc.b	49
3217  0002 32            	dc.b	50
3218  0003 33            	dc.b	51
3219  0004 34            	dc.b	52
3220  0005 35            	dc.b	53
3221  0006 36            	dc.b	54
3222  0007 37            	dc.b	55
3223  0008 38            	dc.b	56
3224  0009 39            	dc.b	57
3225  000a 41            	dc.b	65
3226  000b 42            	dc.b	66
3227  000c 43            	dc.b	67
3228  000d 44            	dc.b	68
3229  000e 45            	dc.b	69
3230  000f 46            	dc.b	70
3231  0010               _RX_Buf:
3232  0010 00            	dc.b	0
3233  0011 000000000000  	ds.b	63
3234  0050               _RX_End:
3235  0050 00            	dc.b	0
3236  0051               _BufLength:
3237  0051 00            	dc.b	0
3238  0052               _RX_FRAME:
3239  0052 00            	dc.b	0
3240  0053               _frameStart:
3241  0053 00            	dc.b	0
3242  0054               _frameEnd:
3243  0054 00            	dc.b	0
3284                     ; 12 void UART_RXGPIO_Config(void)
3284                     ; 13 {
3286                     	switch	.text
3287  0000               _UART_RXGPIO_Config:
3291                     ; 14 	EXTI_CR1 |= 0x80;//PD only down trigger
3293  0000 721e50a0      	bset	_EXTI_CR1,#7
3294                     ; 15 	EXTI_CR1 &= 0xBF;
3296  0004 721d50a0      	bres	_EXTI_CR1,#6
3297                     ; 16 	PD_DDR &= 0xFD;//PD1 IOset as input
3299  0008 72135011      	bres	_PD_DDR,#1
3300                     ; 17 	PD_CR1 |= 0x02;//pull up
3302  000c 72125012      	bset	_PD_CR1,#1
3303                     ; 18 	PD_CR2 |= 0x02;//EXT interrupt	
3305  0010 72125013      	bset	_PD_CR2,#1
3306                     ; 19 }
3309  0014 81            	ret
3356                     ; 22 char StartRXD(void)//use Delay
3356                     ; 23 {
3357                     	switch	.text
3358  0015               _StartRXD:
3360  0015 89            	pushw	x
3361       00000002      OFST:	set	2
3364                     ; 24 	unsigned char cnt = 0;
3366  0016 7b01          	ld	a,(OFST-1,sp)
3367  0018 97            	ld	xl,a
3368                     ; 25 	char RX_Byte = 0;
3370  0019 0f02          	clr	(OFST+0,sp)
3371                     ; 26 	RX_End = 0;	
3373  001b 3f50          	clr	_RX_End
3374                     ; 27 	Delay50us();//to the middle of a bit
3376  001d cd0000        	call	_Delay50us
3378                     ; 29 LIGHT = !LIGHT;
3380  0020 901a500a      	bcpl	_PC_ODR_5
3381                     ; 31 	if(RX_BIT == 0)//confirm start bit
3383                     	btst	_PD_IDR_1
3384  0029 2538          	jrult	L3322
3385                     ; 33 		for(cnt=0;cnt<8;cnt++)
3387  002b 0f01          	clr	(OFST-1,sp)
3388  002d               L5322:
3389                     ; 35 			Delay50us();Delay50us();//104uS,to the middle of a bit
3391  002d cd0000        	call	_Delay50us
3395  0030 cd0000        	call	_Delay50us
3397                     ; 36 			RX_Byte >>= 1;//low bit to high bit 
3399  0033 0402          	srl	(OFST+0,sp)
3400                     ; 37 			if(RX_BIT)
3402                     	btst	_PD_IDR_1
3403  003a 2406          	jruge	L3422
3404                     ; 38 				RX_Byte |= 0x80;
3406  003c 7b02          	ld	a,(OFST+0,sp)
3407  003e aa80          	or	a,#128
3408  0040 6b02          	ld	(OFST+0,sp),a
3409  0042               L3422:
3410                     ; 33 		for(cnt=0;cnt<8;cnt++)
3412  0042 0c01          	inc	(OFST-1,sp)
3415  0044 7b01          	ld	a,(OFST-1,sp)
3416  0046 a108          	cp	a,#8
3417  0048 25e3          	jrult	L5322
3418                     ; 40 		Delay50us();Delay50us();//104uS,to the middle of a bit
3420  004a cd0000        	call	_Delay50us
3424  004d cd0000        	call	_Delay50us
3426                     ; 41 		if(RX_BIT)//stop bit?
3428                     	btst	_PD_IDR_1
3429  0055 2408          	jruge	L5422
3430                     ; 43 			RX_End = 1;	
3432  0057 35010050      	mov	_RX_End,#1
3433                     ; 44 			return RX_Byte;
3435  005b 7b02          	ld	a,(OFST+0,sp)
3437  005d 2002          	jra	L01
3438  005f               L5422:
3439                     ; 47 			return -1;
3441  005f a6ff          	ld	a,#255
3443  0061               L01:
3445  0061 85            	popw	x
3446  0062 81            	ret
3447  0063               L3322:
3448                     ; 51 		return -1;
3450  0063 a6ff          	ld	a,#255
3452  0065 20fa          	jra	L01
3455                     	bsct
3456  0055               L3522_index:
3457  0055 00            	dc.b	0
3525                     ; 55 @far @interrupt void EXTI3_IRQHandler(void)
3525                     ; 56 {
3527                     	switch	.text
3528  0067               f_EXTI3_IRQHandler:
3531       00000003      OFST:	set	3
3532  0067 3b0002        	push	c_x+2
3533  006a be00          	ldw	x,c_x
3534  006c 89            	pushw	x
3535  006d 3b0002        	push	c_y+2
3536  0070 be00          	ldw	x,c_y
3537  0072 89            	pushw	x
3538  0073 5203          	subw	sp,#3
3541                     ; 58 	volatile char temp = 0;
3543  0075 0f02          	clr	(OFST-1,sp)
3544                     ; 59 	char i = 0, error = 0;
3546  0077 7b03          	ld	a,(OFST+0,sp)
3547  0079 97            	ld	xl,a
3550  007a 0f01          	clr	(OFST-2,sp)
3551                     ; 61 	PD_CR2 &= 0xFD;//EXT interrupt disable
3553  007c 72135013      	bres	_PD_CR2,#1
3554                     ; 62 	temp=StartRXD();
3556  0080 ad93          	call	_StartRXD
3558  0082 6b02          	ld	(OFST-1,sp),a
3559                     ; 66 	if(-1 == temp)
3561  0084 7b02          	ld	a,(OFST-1,sp)
3562  0086 97            	ld	xl,a
3564                     ; 73 	else if(0xFE == temp)//begin: 0xFE
3570  0087 7b02          	ld	a,(OFST-1,sp)
3571  0089 a1fe          	cp	a,#254
3572  008b 2612          	jrne	L3132
3573                     ; 75 		frameStart = 1;
3575  008d 35010053      	mov	_frameStart,#1
3576                     ; 76 		frameEnd = 0;
3578  0091 3f54          	clr	_frameEnd
3579                     ; 77 		index = 0;
3581  0093 3f55          	clr	L3522_index
3582                     ; 78 		memset(RX_Buf, '', BUFFER_SIZE);
3584  0095 ae0040        	ldw	x,#64
3585  0098               L41:
3586  0098 6f0f          	clr	(_RX_Buf-1,x)
3587  009a 5a            	decw	x
3588  009b 26fb          	jrne	L41
3590  009d 206d          	jra	L1132
3591  009f               L3132:
3592                     ; 80 	else if(0xEF == temp)//end: 0xEF
3594  009f 7b02          	ld	a,(OFST-1,sp)
3595  00a1 a1ef          	cp	a,#239
3596  00a3 2653          	jrne	L7132
3597                     ; 82 		for(i=0;i<=14;i++)//confirm data is correct
3599  00a5 0f03          	clr	(OFST+0,sp)
3600  00a7               L1232:
3601                     ; 84 			if(RX_Buf[i] != RX_Buf[i+15])
3603  00a7 7b03          	ld	a,(OFST+0,sp)
3604  00a9 5f            	clrw	x
3605  00aa 97            	ld	xl,a
3606  00ab 7b03          	ld	a,(OFST+0,sp)
3607  00ad 905f          	clrw	y
3608  00af 9097          	ld	yl,a
3609  00b1 90e610        	ld	a,(_RX_Buf,y)
3610  00b4 e11f          	cp	a,(_RX_Buf+15,x)
3611  00b6 2704          	jreq	L7232
3612                     ; 85 				error = 1;//data error
3614  00b8 a601          	ld	a,#1
3615  00ba 6b01          	ld	(OFST-2,sp),a
3616  00bc               L7232:
3617                     ; 82 		for(i=0;i<=14;i++)//confirm data is correct
3619  00bc 0c03          	inc	(OFST+0,sp)
3622  00be 7b03          	ld	a,(OFST+0,sp)
3623  00c0 a10f          	cp	a,#15
3624  00c2 25e3          	jrult	L1232
3625                     ; 88 		if(error == 1)//data error, clear receive data
3627  00c4 7b01          	ld	a,(OFST-2,sp)
3628  00c6 a101          	cp	a,#1
3629  00c8 2610          	jrne	L1332
3630                     ; 90 			frameStart = 0;
3632  00ca 3f53          	clr	_frameStart
3633                     ; 91 			frameEnd = 0;
3635  00cc 3f54          	clr	_frameEnd
3636                     ; 92 			index = 0;
3638  00ce 3f55          	clr	L3522_index
3639                     ; 93 			memset(RX_Buf, '', BUFFER_SIZE);			
3641  00d0 ae0040        	ldw	x,#64
3642  00d3               L61:
3643  00d3 6f0f          	clr	(_RX_Buf-1,x)
3644  00d5 5a            	decw	x
3645  00d6 26fb          	jrne	L61
3647  00d8 201a          	jra	L3332
3648  00da               L1332:
3649                     ; 98 for(index=0; index<5; index++)
3651  00da 3f55          	clr	L3522_index
3652  00dc               L5332:
3653                     ; 100 	LIGHT = !LIGHT;
3655  00dc 901a500a      	bcpl	_PC_ODR_5
3656                     ; 101 	Delay500ms();
3658  00e0 cd0000        	call	_Delay500ms
3660                     ; 98 for(index=0; index<5; index++)
3662  00e3 3c55          	inc	L3522_index
3665  00e5 b655          	ld	a,L3522_index
3666  00e7 a105          	cp	a,#5
3667  00e9 25f1          	jrult	L5332
3668                     ; 104 			frameEnd = 1;
3670  00eb 35010054      	mov	_frameEnd,#1
3671                     ; 105 			frameStart = 0;
3673  00ef 3f53          	clr	_frameStart
3674                     ; 106 			BufLength = index;
3676  00f1 455551        	mov	_BufLength,L3522_index
3677  00f4               L3332:
3678                     ; 108 		index = 0;
3680  00f4 3f55          	clr	L3522_index
3682  00f6 2014          	jra	L1132
3683  00f8               L7132:
3684                     ; 112 		RX_Buf[index++] = temp;
3686  00f8 b655          	ld	a,L3522_index
3687  00fa 97            	ld	xl,a
3688  00fb 3c55          	inc	L3522_index
3689  00fd 9f            	ld	a,xl
3690  00fe 5f            	clrw	x
3691  00ff 97            	ld	xl,a
3692  0100 7b02          	ld	a,(OFST-1,sp)
3693  0102 e710          	ld	(_RX_Buf,x),a
3694                     ; 113 		if(index >= BUFFER_SIZE)
3696  0104 b655          	ld	a,L3522_index
3697  0106 a140          	cp	a,#64
3698  0108 2502          	jrult	L1132
3699                     ; 114 			index = 0;
3701  010a 3f55          	clr	L3522_index
3702  010c               L1132:
3703                     ; 117 	PD_CR2 |= 0x02;//EXT interrupt enable
3705  010c 72125013      	bset	_PD_CR2,#1
3706                     ; 118 }
3709  0110 5b03          	addw	sp,#3
3710  0112 85            	popw	x
3711  0113 bf00          	ldw	c_y,x
3712  0115 320002        	pop	c_y+2
3713  0118 85            	popw	x
3714  0119 bf00          	ldw	c_x,x
3715  011b 320002        	pop	c_x+2
3716  011e 80            	iret
3795                     	xdef	f_EXTI3_IRQHandler
3796                     	xdef	_HexTable
3797                     	xdef	_StartRXD
3798                     	xdef	_UART_RXGPIO_Config
3799                     	xdef	_frameEnd
3800                     	xdef	_frameStart
3801                     	xdef	_RX_FRAME
3802                     	xdef	_BufLength
3803                     	xdef	_RX_End
3804                     	xdef	_RX_Buf
3805                     	xref	_Delay500ms
3806                     	xref	_Delay50us
3807                     	xref	_memset
3808                     	xref.b	c_x
3809                     	xref.b	c_y
3828                     	end
