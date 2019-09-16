   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3213                     	bsct
3214  0000               _WriteBuffer:
3215  0000 53544d3853c4  	dc.b	"STM8S",196
3216  0006 dab2bf454550  	dc.b	218,178,191,69,69,80
3217  000c 524f4db2      	dc.b	"ROM",178
3218  0010 e2cad4210d0a  	dc.b	226,202,212,33,13,10,0
3219  0017 000000000000  	ds.b	105
3258                     ; 9 unsigned char UnlockEEPROM(void)
3258                     ; 10 {
3260                     	switch	.text
3261  0000               _UnlockEEPROM:
3265                     ; 11   FLASH_DUKR=0xAE;
3267  0000 35ae5064      	mov	_FLASH_DUKR,#174
3268                     ; 12   FLASH_DUKR=0x56;
3270  0004 35565064      	mov	_FLASH_DUKR,#86
3271                     ; 14   if(FLASH_IAPSR&0x08)//FLASH_IAPSR_DUL位=0为写保护
3273  0008 c6505f        	ld	a,_FLASH_IAPSR
3274  000b a508          	bcp	a,#8
3275  000d 2703          	jreq	L1122
3276                     ; 15     return 1;
3278  000f a601          	ld	a,#1
3281  0011 81            	ret
3282  0012               L1122:
3283                     ; 17     return 0;
3285  0012 4f            	clr	a
3288  0013 81            	ret
3312                     ; 20 void LockEEPROM(void)
3312                     ; 21 {
3313                     	switch	.text
3314  0014               _LockEEPROM:
3318                     ; 22   FLASH_IAPSR&=0xFD;
3320  0014 7213505f      	bres	_FLASH_IAPSR,#1
3321                     ; 23 }
3324  0018 81            	ret
3358                     ; 25 void FLASH_EraseByte(unsigned long address)
3358                     ; 26 {
3359                     	switch	.text
3360  0019               _FLASH_EraseByte:
3362       00000000      OFST:	set	0
3365                     ; 27   *(@near unsigned char*)(unsigned int)address=0x00;
3367  0019 1e05          	ldw	x,(OFST+5,sp)
3368  001b 7f            	clr	(x)
3369                     ; 28 }
3372  001c 81            	ret
3415                     ; 35 void FLASH_ProgramByte(unsigned long address, unsigned char Data)
3415                     ; 36 {
3416                     	switch	.text
3417  001d               _FLASH_ProgramByte:
3419       00000000      OFST:	set	0
3422                     ; 37     *(@near unsigned char*)(unsigned int)address = Data;
3424  001d 7b07          	ld	a,(OFST+7,sp)
3425  001f 1e05          	ldw	x,(OFST+5,sp)
3426  0021 f7            	ld	(x),a
3427                     ; 38 }
3430  0022 81            	ret
3464                     ; 45 unsigned char FLASH_ReadByte(unsigned long address)
3464                     ; 46 {
3465                     	switch	.text
3466  0023               _FLASH_ReadByte:
3468       00000000      OFST:	set	0
3471                     ; 47    return(*(@near unsigned char*)(unsigned int)address); 
3473  0023 1e05          	ldw	x,(OFST+5,sp)
3474  0025 f6            	ld	a,(x)
3477  0026 81            	ret
3525                     ; 55 void FLASH_EraseBlock(unsigned int address)
3525                     ; 56 {
3526                     	switch	.text
3527  0027               _FLASH_EraseBlock:
3529  0027 89            	pushw	x
3530  0028 89            	pushw	x
3531       00000002      OFST:	set	2
3534  0029               L7232:
3535                     ; 58   while(!UnlockEEPROM());
3537  0029 add5          	call	_UnlockEEPROM
3539  002b 4d            	tnz	a
3540  002c 27fb          	jreq	L7232
3541                     ; 59   temp=(@near unsigned long*)(unsigned int)(0x4000+address*FLASH_BLOCK_SIZE);
3543  002e 1e03          	ldw	x,(OFST+1,sp)
3544  0030 4f            	clr	a
3545  0031 02            	rlwa	x,a
3546  0032 44            	srl	a
3547  0033 56            	rrcw	x
3548  0034 1c4000        	addw	x,#16384
3549  0037 1f01          	ldw	(OFST-1,sp),x
3550                     ; 61   FLASH_CR2|=0x10;
3552  0039 7218505b      	bset	_FLASH_CR2,#4
3553                     ; 62   FLASH_NCR2&=0xDF;
3555  003d 721b505c      	bres	_FLASH_NCR2,#5
3556                     ; 64   *temp=0;
3558  0041 1e01          	ldw	x,(OFST-1,sp)
3559  0043 a600          	ld	a,#0
3560  0045 e703          	ld	(3,x),a
3561  0047 a600          	ld	a,#0
3562  0049 e702          	ld	(2,x),a
3563  004b a600          	ld	a,#0
3564  004d e701          	ld	(1,x),a
3565  004f a600          	ld	a,#0
3566  0051 f7            	ld	(x),a
3568  0052               L7332:
3569                     ; 67   while(!(FLASH_IAPSR&0x04));
3571  0052 c6505f        	ld	a,_FLASH_IAPSR
3572  0055 a504          	bcp	a,#4
3573  0057 27f9          	jreq	L7332
3574                     ; 68 }
3577  0059 5b04          	addw	sp,#4
3578  005b 81            	ret
3640                     .const:	section	.text
3641  0000               L22:
3642  0000 00004000      	dc.l	16384
3643                     ; 75 void FLASH_ProgramBlock(unsigned int address,unsigned char *buffer)
3643                     ; 76 {
3644                     	switch	.text
3645  005c               _FLASH_ProgramBlock:
3647  005c 89            	pushw	x
3648  005d 5206          	subw	sp,#6
3649       00000006      OFST:	set	6
3652                     ; 80   temp=0x4000+((unsigned long)address*FLASH_BLOCK_SIZE);
3654  005f a680          	ld	a,#128
3655  0061 cd0000        	call	c_cmulx
3657  0064 ae0000        	ldw	x,#L22
3658  0067 cd0000        	call	c_ladd
3660  006a 96            	ldw	x,sp
3661  006b 1c0001        	addw	x,#OFST-5
3662  006e cd0000        	call	c_rtol
3664                     ; 82   for(count=0;count<FLASH_BLOCK_SIZE;count++)
3666  0071 5f            	clrw	x
3667  0072 1f05          	ldw	(OFST-1,sp),x
3668  0074               L5732:
3669                     ; 84     *((@near unsigned char*)(unsigned int)temp+count)=buffer[count];
3671  0074 1e0b          	ldw	x,(OFST+5,sp)
3672  0076 72fb05        	addw	x,(OFST-1,sp)
3673  0079 f6            	ld	a,(x)
3674  007a 1e03          	ldw	x,(OFST-3,sp)
3675  007c 72fb05        	addw	x,(OFST-1,sp)
3676  007f f7            	ld	(x),a
3677                     ; 82   for(count=0;count<FLASH_BLOCK_SIZE;count++)
3679  0080 1e05          	ldw	x,(OFST-1,sp)
3680  0082 1c0001        	addw	x,#1
3681  0085 1f05          	ldw	(OFST-1,sp),x
3684  0087 1e05          	ldw	x,(OFST-1,sp)
3685  0089 a30080        	cpw	x,#128
3686  008c 25e6          	jrult	L5732
3687                     ; 86 }
3690  008e 5b08          	addw	sp,#8
3691  0090 81            	ret
3757                     ; 100 void WriteData(unsigned char BlockStartAddress,unsigned char *Buffer,unsigned char BlockNum)
3757                     ; 101 {
3758                     	switch	.text
3759  0091               _WriteData:
3761  0091 88            	push	a
3762  0092 88            	push	a
3763       00000001      OFST:	set	1
3766  0093               L7342:
3767                     ; 104   while(!UnlockEEPROM());
3769  0093 cd0000        	call	_UnlockEEPROM
3771  0096 4d            	tnz	a
3772  0097 27fa          	jreq	L7342
3773                     ; 106   for(BlockNum_Temp=BlockStartAddress;BlockNum_Temp<BlockNum;BlockNum_Temp++)
3775  0099 7b02          	ld	a,(OFST+1,sp)
3776  009b 6b01          	ld	(OFST+0,sp),a
3778  009d 2025          	jra	L7442
3779  009f               L3442:
3780                     ; 108     if(BlockNum_Temp>FLASH_DATA_BLOCKS_NUMBER)
3782  009f 7b01          	ld	a,(OFST+0,sp)
3783  00a1 a109          	cp	a,#9
3784  00a3 2505          	jrult	L3542
3785                     ; 109         break;
3786  00a5               L1542:
3787                     ; 117   LockEEPROM();/*操作完要加锁*/
3789  00a5 cd0014        	call	_LockEEPROM
3791                     ; 118 }
3794  00a8 85            	popw	x
3795  00a9 81            	ret
3796  00aa               L3542:
3797                     ; 111     FLASH_ProgramBlock(BlockNum_Temp, Buffer+BlockNum_Temp*FLASH_BLOCK_SIZE);
3799  00aa 7b01          	ld	a,(OFST+0,sp)
3800  00ac 97            	ld	xl,a
3801  00ad a680          	ld	a,#128
3802  00af 42            	mul	x,a
3803  00b0 72fb05        	addw	x,(OFST+4,sp)
3804  00b3 89            	pushw	x
3805  00b4 7b03          	ld	a,(OFST+2,sp)
3806  00b6 5f            	clrw	x
3807  00b7 97            	ld	xl,a
3808  00b8 ada2          	call	_FLASH_ProgramBlock
3810  00ba 85            	popw	x
3812  00bb               L7542:
3813                     ; 112      while(!(FLASH_IAPSR&0x04));
3815  00bb c6505f        	ld	a,_FLASH_IAPSR
3816  00be a504          	bcp	a,#4
3817  00c0 27f9          	jreq	L7542
3818                     ; 106   for(BlockNum_Temp=BlockStartAddress;BlockNum_Temp<BlockNum;BlockNum_Temp++)
3820  00c2 0c01          	inc	(OFST+0,sp)
3821  00c4               L7442:
3824  00c4 7b01          	ld	a,(OFST+0,sp)
3825  00c6 1107          	cp	a,(OFST+6,sp)
3826  00c8 25d5          	jrult	L3442
3827  00ca 20d9          	jra	L1542
3908                     ; 125 void ReadData(unsigned char BlockStartAddress,unsigned char *Buffer,unsigned char BlockNum)
3908                     ; 126 {
3909                     	switch	.text
3910  00cc               _ReadData:
3912  00cc 88            	push	a
3913  00cd 5208          	subw	sp,#8
3914       00000008      OFST:	set	8
3917                     ; 128   start_add = 0x4000+(unsigned long)((BlockNum-1)*FLASH_BLOCK_SIZE);
3919  00cf 7b0e          	ld	a,(OFST+6,sp)
3920  00d1 97            	ld	xl,a
3921  00d2 a680          	ld	a,#128
3922  00d4 42            	mul	x,a
3923  00d5 1d0080        	subw	x,#128
3924  00d8 cd0000        	call	c_itolx
3926  00db ae0000        	ldw	x,#L22
3927  00de cd0000        	call	c_ladd
3929  00e1 96            	ldw	x,sp
3930  00e2 1c0005        	addw	x,#OFST-3
3931  00e5 cd0000        	call	c_rtol
3933                     ; 129   stop_add = 0x4000 + (unsigned long)(BlockNum*FLASH_BLOCK_SIZE);
3935  00e8 7b0e          	ld	a,(OFST+6,sp)
3936  00ea 97            	ld	xl,a
3937  00eb a680          	ld	a,#128
3938  00ed 42            	mul	x,a
3939  00ee cd0000        	call	c_itolx
3941  00f1 ae0000        	ldw	x,#L22
3942  00f4 cd0000        	call	c_ladd
3944  00f7 96            	ldw	x,sp
3945  00f8 1c0001        	addw	x,#OFST-7
3946  00fb cd0000        	call	c_rtol
3948                     ; 131   for (add = start_add; add < stop_add; add++)
3951  00fe 201d          	jra	L1352
3952  0100               L5252:
3953                     ; 132       Buffer[add-0x4000]=FLASH_ReadByte(add);
3955  0100 1e07          	ldw	x,(OFST-1,sp)
3956  0102 89            	pushw	x
3957  0103 1e07          	ldw	x,(OFST-1,sp)
3958  0105 89            	pushw	x
3959  0106 cd0023        	call	_FLASH_ReadByte
3961  0109 5b04          	addw	sp,#4
3962  010b 1e07          	ldw	x,(OFST-1,sp)
3963  010d 1d4000        	subw	x,#16384
3964  0110 72fb0c        	addw	x,(OFST+4,sp)
3965  0113 f7            	ld	(x),a
3966                     ; 131   for (add = start_add; add < stop_add; add++)
3968  0114 96            	ldw	x,sp
3969  0115 1c0005        	addw	x,#OFST-3
3970  0118 a601          	ld	a,#1
3971  011a cd0000        	call	c_lgadc
3973  011d               L1352:
3976  011d 96            	ldw	x,sp
3977  011e 1c0005        	addw	x,#OFST-3
3978  0121 cd0000        	call	c_ltor
3980  0124 96            	ldw	x,sp
3981  0125 1c0001        	addw	x,#OFST-7
3982  0128 cd0000        	call	c_lcmp
3984  012b 25d3          	jrult	L5252
3985                     ; 133 }
3988  012d 5b09          	addw	sp,#9
3989  012f 81            	ret
4024                     	switch	.ubsct
4025  0000               _ReadBuffer:
4026  0000 000000000000  	ds.b	128
4027                     	xdef	_ReadBuffer
4028                     	xdef	_WriteBuffer
4029                     	xdef	_ReadData
4030                     	xdef	_WriteData
4031                     	xdef	_FLASH_ProgramBlock
4032                     	xdef	_FLASH_EraseBlock
4033                     	xdef	_FLASH_ReadByte
4034                     	xdef	_FLASH_ProgramByte
4035                     	xdef	_FLASH_EraseByte
4036                     	xdef	_LockEEPROM
4037                     	xdef	_UnlockEEPROM
4057                     	xref	c_lcmp
4058                     	xref	c_ltor
4059                     	xref	c_lgadc
4060                     	xref	c_itolx
4061                     	xref	c_rtol
4062                     	xref	c_ladd
4063                     	xref	c_cmulx
4064                     	end
