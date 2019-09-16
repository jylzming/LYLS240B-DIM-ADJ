   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3213                     	bsct
3214  0000               _brightness:
3215  0000 2b            	dc.b	43
3216  0001               _read_Flash:
3217  0001 00            	dc.b	0
3218  0002 000000000000  	ds.b	10
3219  000c               _second:
3220  000c 0000          	dc.w	0
3221  000e               _hour:
3222  000e 0000          	dc.w	0
3223  0010               _relayStat:
3224  0010 00            	dc.b	0
3225  0011               _isDimmingConfiged:
3226  0011 00            	dc.b	0
3227  0012               _timeChanged:
3228  0012 00            	dc.b	0
3229  0013               L3712_ex_state:
3230  0013 00            	dc.b	0
3343                     ; 32 void DimmingMode(Mode mode)
3343                     ; 33 {
3345                     	switch	.text
3346  0000               _DimmingMode:
3348  0000 88            	push	a
3349       00000000      OFST:	set	0
3352                     ; 34 	if(LIGHT == ON)
3354                     	btst	_PC_ODR_5
3355  0006 2403          	jruge	L64
3356  0008 cc0254        	jp	L3332
3357  000b               L64:
3358                     ; 36 		switch (mode)
3360  000b 7b01          	ld	a,(OFST+1,sp)
3362                     ; 111 			default:	break;
3363  000d 4d            	tnz	a
3364  000e 2722          	jreq	L5712
3365  0010 4a            	dec	a
3366  0011 2756          	jreq	L7712
3367  0013 4a            	dec	a
3368  0014 2774          	jreq	L1022
3369  0016 4a            	dec	a
3370  0017 2603cc00ab    	jreq	L3022
3371  001c 4a            	dec	a
3372  001d 2603          	jrne	L05
3373  001f cc00e2        	jp	L5022
3374  0022               L05:
3375  0022 4a            	dec	a
3376  0023 2603          	jrne	L25
3377  0025 cc0135        	jp	L7022
3378  0028               L25:
3379  0028 4a            	dec	a
3380  0029 2603          	jrne	L45
3381  002b cc018e        	jp	L1122
3382  002e               L45:
3383  002e ac540254      	jpf	L3332
3384  0032               L5712:
3385                     ; 38 			case MODE0:
3385                     ; 39 				if(hour >= 0 && hour < 6)
3387  0032 be0e          	ldw	x,_hour
3388  0034 a30006        	cpw	x,#6
3389  0037 2408          	jruge	L1432
3390                     ; 40 					state = STATE1;
3392  0039 35010000      	mov	_state,#1
3394  003d ac540254      	jpf	L3332
3395  0041               L1432:
3396                     ; 41 				else if(hour >= 6 && hour < 10)//(hour >= 6 && hour < 10)
3398  0041 be0e          	ldw	x,_hour
3399  0043 a30006        	cpw	x,#6
3400  0046 250f          	jrult	L5432
3402  0048 be0e          	ldw	x,_hour
3403  004a a3000a        	cpw	x,#10
3404  004d 2408          	jruge	L5432
3405                     ; 42 					state = STATE2;
3407  004f 35020000      	mov	_state,#2
3409  0053 ac540254      	jpf	L3332
3410  0057               L5432:
3411                     ; 43 				else if(hour >= 10) 
3413  0057 be0e          	ldw	x,_hour
3414  0059 a3000a        	cpw	x,#10
3415  005c 2403          	jruge	L65
3416  005e cc0254        	jp	L3332
3417  0061               L65:
3418                     ; 44 					state = STATE3;
3420  0061 35030000      	mov	_state,#3
3421  0065 ac540254      	jpf	L3332
3422  0069               L7712:
3423                     ; 47 			case MODE1:
3423                     ; 48 				if(hour >= 0 && hour < 6)
3425  0069 be0e          	ldw	x,_hour
3426  006b a30006        	cpw	x,#6
3427  006e 2408          	jruge	L3532
3428                     ; 49 					state = STATE1;
3430  0070 35010000      	mov	_state,#1
3432  0074 ac540254      	jpf	L3332
3433  0078               L3532:
3434                     ; 50 				else if(hour >= 6)//(hour >= 6 && hour < 10)
3436  0078 be0e          	ldw	x,_hour
3437  007a a30006        	cpw	x,#6
3438  007d 2403          	jruge	L06
3439  007f cc0254        	jp	L3332
3440  0082               L06:
3441                     ; 51 					state = STATE2;
3443  0082 35020000      	mov	_state,#2
3444  0086 ac540254      	jpf	L3332
3445  008a               L1022:
3446                     ; 54 			case MODE2:
3446                     ; 55 				if(hour >= 0 && hour < 9)
3448  008a be0e          	ldw	x,_hour
3449  008c a30009        	cpw	x,#9
3450  008f 2408          	jruge	L1632
3451                     ; 56 					state = STATE1;
3453  0091 35010000      	mov	_state,#1
3455  0095 ac540254      	jpf	L3332
3456  0099               L1632:
3457                     ; 57 				else if(hour >= 9)//always in dimming state
3459  0099 be0e          	ldw	x,_hour
3460  009b a30009        	cpw	x,#9
3461  009e 2403          	jruge	L26
3462  00a0 cc0254        	jp	L3332
3463  00a3               L26:
3464                     ; 58 					state = STATE2;
3466  00a3 35020000      	mov	_state,#2
3467  00a7 ac540254      	jpf	L3332
3468  00ab               L3022:
3469                     ; 61 			case MODE3: 	
3469                     ; 62 				if(second >= 0 && second < 10)
3471  00ab be0c          	ldw	x,_second
3472  00ad a3000a        	cpw	x,#10
3473  00b0 2408          	jruge	L7632
3474                     ; 63 					state = STATE1;
3476  00b2 35010000      	mov	_state,#1
3478  00b6 ac540254      	jpf	L3332
3479  00ba               L7632:
3480                     ; 64 				else if(second >= 10 && second < 20)//(hour >= 6 && hour < 10)
3482  00ba be0c          	ldw	x,_second
3483  00bc a3000a        	cpw	x,#10
3484  00bf 250f          	jrult	L3732
3486  00c1 be0c          	ldw	x,_second
3487  00c3 a30014        	cpw	x,#20
3488  00c6 2408          	jruge	L3732
3489                     ; 65 					state = STATE2;
3491  00c8 35020000      	mov	_state,#2
3493  00cc ac540254      	jpf	L3332
3494  00d0               L3732:
3495                     ; 66 				else if(second >= 20) 
3497  00d0 be0c          	ldw	x,_second
3498  00d2 a30014        	cpw	x,#20
3499  00d5 2403          	jruge	L46
3500  00d7 cc0254        	jp	L3332
3501  00da               L46:
3502                     ; 67 					state = STATE3;		
3504  00da 35030000      	mov	_state,#3
3505  00de ac540254      	jpf	L3332
3506  00e2               L5022:
3507                     ; 70 			case MODE4:
3507                     ; 71 				if(hour >= 0 && hour < 1)//1hour
3509  00e2 be0e          	ldw	x,_hour
3510  00e4 2608          	jrne	L1042
3511                     ; 72 					state = STATE1;
3513  00e6 35010000      	mov	_state,#1
3515  00ea ac540254      	jpf	L3332
3516  00ee               L1042:
3517                     ; 73 				else if(hour >= 1 && hour < 4)//3hours
3519  00ee be0e          	ldw	x,_hour
3520  00f0 270f          	jreq	L5042
3522  00f2 be0e          	ldw	x,_hour
3523  00f4 a30004        	cpw	x,#4
3524  00f7 2408          	jruge	L5042
3525                     ; 74 					state = STATE2;
3527  00f9 35020000      	mov	_state,#2
3529  00fd ac540254      	jpf	L3332
3530  0101               L5042:
3531                     ; 75 				else if(hour >= 4 && hour < 5)//1hour
3533  0101 be0e          	ldw	x,_hour
3534  0103 a30004        	cpw	x,#4
3535  0106 250f          	jrult	L1142
3537  0108 be0e          	ldw	x,_hour
3538  010a a30005        	cpw	x,#5
3539  010d 2408          	jruge	L1142
3540                     ; 76 					state = STATE3;					
3542  010f 35030000      	mov	_state,#3
3544  0113 ac540254      	jpf	L3332
3545  0117               L1142:
3546                     ; 77 				else if(hour >= 5 && hour < 12)//7hours
3548  0117 be0e          	ldw	x,_hour
3549  0119 a30005        	cpw	x,#5
3550  011c 250f          	jrult	L5142
3552  011e be0e          	ldw	x,_hour
3553  0120 a3000c        	cpw	x,#12
3554  0123 2408          	jruge	L5142
3555                     ; 78 					state = STATE4;
3557  0125 35040000      	mov	_state,#4
3559  0129 ac540254      	jpf	L3332
3560  012d               L5142:
3561                     ; 80 					state = STATE5;
3563  012d 35050000      	mov	_state,#5
3564  0131 ac540254      	jpf	L3332
3565  0135               L7022:
3566                     ; 83 			case MODE5:
3566                     ; 84 				if(hour >= 0 && hour < 5)//5hour
3568  0135 be0e          	ldw	x,_hour
3569  0137 a30005        	cpw	x,#5
3570  013a 2408          	jruge	L1242
3571                     ; 85 					state = STATE1;
3573  013c 35010000      	mov	_state,#1
3575  0140 ac540254      	jpf	L3332
3576  0144               L1242:
3577                     ; 86 				else if(hour >= 5 && hour < 7)//2hours
3579  0144 be0e          	ldw	x,_hour
3580  0146 a30005        	cpw	x,#5
3581  0149 250f          	jrult	L5242
3583  014b be0e          	ldw	x,_hour
3584  014d a30007        	cpw	x,#7
3585  0150 2408          	jruge	L5242
3586                     ; 87 					state = STATE2;
3588  0152 35020000      	mov	_state,#2
3590  0156 ac540254      	jpf	L3332
3591  015a               L5242:
3592                     ; 88 				else if(hour >= 7 && hour < 11)//4hour
3594  015a be0e          	ldw	x,_hour
3595  015c a30007        	cpw	x,#7
3596  015f 250f          	jrult	L1342
3598  0161 be0e          	ldw	x,_hour
3599  0163 a3000b        	cpw	x,#11
3600  0166 2408          	jruge	L1342
3601                     ; 89 					state = STATE3;					
3603  0168 35030000      	mov	_state,#3
3605  016c ac540254      	jpf	L3332
3606  0170               L1342:
3607                     ; 90 				else if(hour >= 11 && hour < 12)//1hours
3609  0170 be0e          	ldw	x,_hour
3610  0172 a3000b        	cpw	x,#11
3611  0175 250f          	jrult	L5342
3613  0177 be0e          	ldw	x,_hour
3614  0179 a3000c        	cpw	x,#12
3615  017c 2408          	jruge	L5342
3616                     ; 91 					state = STATE4;
3618  017e 35040000      	mov	_state,#4
3620  0182 ac540254      	jpf	L3332
3621  0186               L5342:
3622                     ; 93 					state = STATE5;
3624  0186 35050000      	mov	_state,#5
3625  018a ac540254      	jpf	L3332
3626  018e               L1122:
3627                     ; 96 			case MODE6:
3627                     ; 97 				if(second >= 0 && second < RX_Buf[0])
3629  018e b600          	ld	a,_RX_Buf
3630  0190 5f            	clrw	x
3631  0191 97            	ld	xl,a
3632  0192 bf00          	ldw	c_x,x
3633  0194 be0c          	ldw	x,_second
3634  0196 b300          	cpw	x,c_x
3635  0198 2408          	jruge	L1442
3636                     ; 98 					state = STATE1;
3638  019a 35010000      	mov	_state,#1
3640  019e ac540254      	jpf	L3332
3641  01a2               L1442:
3642                     ; 99 				else if(second>=read_Flash[0] && second<(read_Flash[0]+read_Flash[2]))
3644  01a2 b601          	ld	a,_read_Flash
3645  01a4 5f            	clrw	x
3646  01a5 97            	ld	xl,a
3647  01a6 bf00          	ldw	c_x,x
3648  01a8 be0c          	ldw	x,_second
3649  01aa b300          	cpw	x,c_x
3650  01ac 2515          	jrult	L5442
3652  01ae b601          	ld	a,_read_Flash
3653  01b0 5f            	clrw	x
3654  01b1 bb03          	add	a,_read_Flash+2
3655  01b3 2401          	jrnc	L6
3656  01b5 5c            	incw	x
3657  01b6               L6:
3658  01b6 02            	rlwa	x,a
3659  01b7 b30c          	cpw	x,_second
3660  01b9 2308          	jrule	L5442
3661                     ; 100 					state = STATE2;
3663  01bb 35020000      	mov	_state,#2
3665  01bf ac540254      	jpf	L3332
3666  01c3               L5442:
3667                     ; 101 				else if(second>=(read_Flash[0]+read_Flash[2]) && second<(read_Flash[0]+read_Flash[2]+read_Flash[4]))
3669  01c3 b601          	ld	a,_read_Flash
3670  01c5 5f            	clrw	x
3671  01c6 bb03          	add	a,_read_Flash+2
3672  01c8 2401          	jrnc	L01
3673  01ca 5c            	incw	x
3674  01cb               L01:
3675  01cb 02            	rlwa	x,a
3676  01cc b30c          	cpw	x,_second
3677  01ce 2218          	jrugt	L1542
3679  01d0 b601          	ld	a,_read_Flash
3680  01d2 5f            	clrw	x
3681  01d3 bb03          	add	a,_read_Flash+2
3682  01d5 2401          	jrnc	L21
3683  01d7 5c            	incw	x
3684  01d8               L21:
3685  01d8 bb05          	add	a,_read_Flash+4
3686  01da 2401          	jrnc	L41
3687  01dc 5c            	incw	x
3688  01dd               L41:
3689  01dd 02            	rlwa	x,a
3690  01de b30c          	cpw	x,_second
3691  01e0 2306          	jrule	L1542
3692                     ; 102 					state = STATE3;					
3694  01e2 35030000      	mov	_state,#3
3696  01e6 206c          	jra	L3332
3697  01e8               L1542:
3698                     ; 103 				else if(second>=(read_Flash[0]+read_Flash[2]+read_Flash[4]) && second<(read_Flash[0]+read_Flash[2]+read_Flash[4]+read_Flash[6]))
3700  01e8 b601          	ld	a,_read_Flash
3701  01ea 5f            	clrw	x
3702  01eb bb03          	add	a,_read_Flash+2
3703  01ed 2401          	jrnc	L61
3704  01ef 5c            	incw	x
3705  01f0               L61:
3706  01f0 bb05          	add	a,_read_Flash+4
3707  01f2 2401          	jrnc	L02
3708  01f4 5c            	incw	x
3709  01f5               L02:
3710  01f5 02            	rlwa	x,a
3711  01f6 b30c          	cpw	x,_second
3712  01f8 221d          	jrugt	L5542
3714  01fa b601          	ld	a,_read_Flash
3715  01fc 5f            	clrw	x
3716  01fd bb03          	add	a,_read_Flash+2
3717  01ff 2401          	jrnc	L22
3718  0201 5c            	incw	x
3719  0202               L22:
3720  0202 bb05          	add	a,_read_Flash+4
3721  0204 2401          	jrnc	L42
3722  0206 5c            	incw	x
3723  0207               L42:
3724  0207 bb07          	add	a,_read_Flash+6
3725  0209 2401          	jrnc	L62
3726  020b 5c            	incw	x
3727  020c               L62:
3728  020c 02            	rlwa	x,a
3729  020d b30c          	cpw	x,_second
3730  020f 2306          	jrule	L5542
3731                     ; 104 					state = STATE4;
3733  0211 35040000      	mov	_state,#4
3735  0215 203d          	jra	L3332
3736  0217               L5542:
3737                     ; 105 				else if(second>=(read_Flash[0]+read_Flash[2]+read_Flash[4]+read_Flash[6]) && second<(read_Flash[0]+read_Flash[2]+read_Flash[4]+read_Flash[6]+read_Flash[8]))
3739  0217 b601          	ld	a,_read_Flash
3740  0219 5f            	clrw	x
3741  021a bb03          	add	a,_read_Flash+2
3742  021c 2401          	jrnc	L03
3743  021e 5c            	incw	x
3744  021f               L03:
3745  021f bb05          	add	a,_read_Flash+4
3746  0221 2401          	jrnc	L23
3747  0223 5c            	incw	x
3748  0224               L23:
3749  0224 bb07          	add	a,_read_Flash+6
3750  0226 2401          	jrnc	L43
3751  0228 5c            	incw	x
3752  0229               L43:
3753  0229 02            	rlwa	x,a
3754  022a b30c          	cpw	x,_second
3755  022c 2222          	jrugt	L1642
3757  022e b601          	ld	a,_read_Flash
3758  0230 5f            	clrw	x
3759  0231 bb03          	add	a,_read_Flash+2
3760  0233 2401          	jrnc	L63
3761  0235 5c            	incw	x
3762  0236               L63:
3763  0236 bb05          	add	a,_read_Flash+4
3764  0238 2401          	jrnc	L04
3765  023a 5c            	incw	x
3766  023b               L04:
3767  023b bb07          	add	a,_read_Flash+6
3768  023d 2401          	jrnc	L24
3769  023f 5c            	incw	x
3770  0240               L24:
3771  0240 bb09          	add	a,_read_Flash+8
3772  0242 2401          	jrnc	L44
3773  0244 5c            	incw	x
3774  0245               L44:
3775  0245 02            	rlwa	x,a
3776  0246 b30c          	cpw	x,_second
3777  0248 2306          	jrule	L1642
3778                     ; 106 					state = STATE5;
3780  024a 35050000      	mov	_state,#5
3782  024e 2004          	jra	L3332
3783  0250               L1642:
3784                     ; 108 					state = STATE6;
3786  0250 35060000      	mov	_state,#6
3787  0254               L3122:
3788                     ; 111 			default:	break;
3790  0254               L7332:
3791  0254               L3332:
3792                     ; 115 	if(ex_state != state)
3794  0254 b613          	ld	a,L3712_ex_state
3795  0256 b100          	cp	a,_state
3796  0258 2603          	jrne	L66
3797  025a cc03a3        	jp	L3152
3798  025d               L66:
3799                     ; 117 		if(mode == MODE5)
3801  025d 7b01          	ld	a,(OFST+1,sp)
3802  025f a105          	cp	a,#5
3803  0261 2678          	jrne	L7642
3804                     ; 119 			switch (state)
3806  0263 b600          	ld	a,_state
3808                     ; 127 				default: break;
3809  0265 4d            	tnz	a
3810  0266 2713          	jreq	L5122
3811  0268 4a            	dec	a
3812  0269 271d          	jreq	L7122
3813  026b 4a            	dec	a
3814  026c 2729          	jreq	L1222
3815  026e 4a            	dec	a
3816  026f 2735          	jreq	L3222
3817  0271 4a            	dec	a
3818  0272 2741          	jreq	L5222
3819  0274 4a            	dec	a
3820  0275 274d          	jreq	L7222
3821  0277 aca303a3      	jpf	L3152
3822  027b               L5122:
3823                     ; 121 				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
3825  027b 5f            	clrw	x
3826  027c 89            	pushw	x
3827  027d ae0064        	ldw	x,#100
3828  0280 cd0000        	call	_PWM_Config
3830  0283 85            	popw	x
3833  0284 aca303a3      	jpf	L3152
3834  0288               L7122:
3835                     ; 122 				case STATE1:	PWM_Config(100, 100);	break;
3837  0288 ae0064        	ldw	x,#100
3838  028b 89            	pushw	x
3839  028c ae0064        	ldw	x,#100
3840  028f cd0000        	call	_PWM_Config
3842  0292 85            	popw	x
3845  0293 aca303a3      	jpf	L3152
3846  0297               L1222:
3847                     ; 123 				case STATE2:	PWM_Config(100, 75);	break;			
3849  0297 ae004b        	ldw	x,#75
3850  029a 89            	pushw	x
3851  029b ae0064        	ldw	x,#100
3852  029e cd0000        	call	_PWM_Config
3854  02a1 85            	popw	x
3857  02a2 aca303a3      	jpf	L3152
3858  02a6               L3222:
3859                     ; 124 				case STATE3:	PWM_Config(100, 50);	break;
3861  02a6 ae0032        	ldw	x,#50
3862  02a9 89            	pushw	x
3863  02aa ae0064        	ldw	x,#100
3864  02ad cd0000        	call	_PWM_Config
3866  02b0 85            	popw	x
3869  02b1 aca303a3      	jpf	L3152
3870  02b5               L5222:
3871                     ; 125 				case STATE4:	PWM_Config(100, 60);	break;
3873  02b5 ae003c        	ldw	x,#60
3874  02b8 89            	pushw	x
3875  02b9 ae0064        	ldw	x,#100
3876  02bc cd0000        	call	_PWM_Config
3878  02bf 85            	popw	x
3881  02c0 aca303a3      	jpf	L3152
3882  02c4               L7222:
3883                     ; 126 				case STATE5:	PWM_Config(100, 60);	break;
3885  02c4 ae003c        	ldw	x,#60
3886  02c7 89            	pushw	x
3887  02c8 ae0064        	ldw	x,#100
3888  02cb cd0000        	call	_PWM_Config
3890  02ce 85            	popw	x
3893  02cf aca303a3      	jpf	L3152
3894  02d3               L1322:
3895                     ; 127 				default: break;
3897  02d3 aca303a3      	jpf	L3152
3898  02d7               L3742:
3900  02d7 aca303a3      	jpf	L3152
3901  02db               L7642:
3902                     ; 130 		else if(mode == MODE6)
3904  02db 7b01          	ld	a,(OFST+1,sp)
3905  02dd a106          	cp	a,#6
3906  02df 2703cc0362    	jrne	L7742
3907                     ; 132 			switch (state)
3909  02e4 b600          	ld	a,_state
3911                     ; 141 				default: break;
3912  02e6 4d            	tnz	a
3913  02e7 2716          	jreq	L3322
3914  02e9 4a            	dec	a
3915  02ea 2720          	jreq	L5322
3916  02ec 4a            	dec	a
3917  02ed 272c          	jreq	L7322
3918  02ef 4a            	dec	a
3919  02f0 2737          	jreq	L1422
3920  02f2 4a            	dec	a
3921  02f3 2742          	jreq	L3422
3922  02f5 4a            	dec	a
3923  02f6 274d          	jreq	L5422
3924  02f8 4a            	dec	a
3925  02f9 2758          	jreq	L7422
3926  02fb aca303a3      	jpf	L3152
3927  02ff               L3322:
3928                     ; 134 				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
3930  02ff 5f            	clrw	x
3931  0300 89            	pushw	x
3932  0301 ae0064        	ldw	x,#100
3933  0304 cd0000        	call	_PWM_Config
3935  0307 85            	popw	x
3938  0308 aca303a3      	jpf	L3152
3939  030c               L5322:
3940                     ; 135 				case STATE1:	PWM_Config(100, read_Flash[1]);	break;
3942  030c b602          	ld	a,_read_Flash+1
3943  030e 5f            	clrw	x
3944  030f 97            	ld	xl,a
3945  0310 89            	pushw	x
3946  0311 ae0064        	ldw	x,#100
3947  0314 cd0000        	call	_PWM_Config
3949  0317 85            	popw	x
3952  0318 cc03a3        	jra	L3152
3953  031b               L7322:
3954                     ; 136 				case STATE2:	PWM_Config(100, read_Flash[3]);	break;			
3956  031b b604          	ld	a,_read_Flash+3
3957  031d 5f            	clrw	x
3958  031e 97            	ld	xl,a
3959  031f 89            	pushw	x
3960  0320 ae0064        	ldw	x,#100
3961  0323 cd0000        	call	_PWM_Config
3963  0326 85            	popw	x
3966  0327 207a          	jra	L3152
3967  0329               L1422:
3968                     ; 137 				case STATE3:	PWM_Config(100, read_Flash[5]);	break;
3970  0329 b606          	ld	a,_read_Flash+5
3971  032b 5f            	clrw	x
3972  032c 97            	ld	xl,a
3973  032d 89            	pushw	x
3974  032e ae0064        	ldw	x,#100
3975  0331 cd0000        	call	_PWM_Config
3977  0334 85            	popw	x
3980  0335 206c          	jra	L3152
3981  0337               L3422:
3982                     ; 138 				case STATE4:	PWM_Config(100, read_Flash[7]);	break;
3984  0337 b608          	ld	a,_read_Flash+7
3985  0339 5f            	clrw	x
3986  033a 97            	ld	xl,a
3987  033b 89            	pushw	x
3988  033c ae0064        	ldw	x,#100
3989  033f cd0000        	call	_PWM_Config
3991  0342 85            	popw	x
3994  0343 205e          	jra	L3152
3995  0345               L5422:
3996                     ; 139 				case STATE5:	PWM_Config(100, read_Flash[9]);	break;			
3998  0345 b60a          	ld	a,_read_Flash+9
3999  0347 5f            	clrw	x
4000  0348 97            	ld	xl,a
4001  0349 89            	pushw	x
4002  034a ae0064        	ldw	x,#100
4003  034d cd0000        	call	_PWM_Config
4005  0350 85            	popw	x
4008  0351 2050          	jra	L3152
4009  0353               L7422:
4010                     ; 140 				case STATE6:	PWM_Config(100, 0);	break;
4012  0353 5f            	clrw	x
4013  0354 89            	pushw	x
4014  0355 ae0064        	ldw	x,#100
4015  0358 cd0000        	call	_PWM_Config
4017  035b 85            	popw	x
4020  035c 2045          	jra	L3152
4021  035e               L1522:
4022                     ; 141 				default: break;
4024  035e 2043          	jra	L3152
4025  0360               L3052:
4027  0360 2041          	jra	L3152
4028  0362               L7742:
4029                     ; 146 			switch (state)
4031  0362 b600          	ld	a,_state
4033                     ; 152 				default: break;
4034  0364 4d            	tnz	a
4035  0365 270b          	jreq	L3522
4036  0367 4a            	dec	a
4037  0368 2713          	jreq	L5522
4038  036a 4a            	dec	a
4039  036b 271d          	jreq	L7522
4040  036d 4a            	dec	a
4041  036e 2728          	jreq	L1622
4042  0370 2031          	jra	L3152
4043  0372               L3522:
4044                     ; 148 				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
4046  0372 5f            	clrw	x
4047  0373 89            	pushw	x
4048  0374 ae0064        	ldw	x,#100
4049  0377 cd0000        	call	_PWM_Config
4051  037a 85            	popw	x
4054  037b 2026          	jra	L3152
4055  037d               L5522:
4056                     ; 149 				case STATE1:	PWM_Config(100, 100);	break;
4058  037d ae0064        	ldw	x,#100
4059  0380 89            	pushw	x
4060  0381 ae0064        	ldw	x,#100
4061  0384 cd0000        	call	_PWM_Config
4063  0387 85            	popw	x
4066  0388 2019          	jra	L3152
4067  038a               L7522:
4068                     ; 150 				case STATE2:	PWM_Config(100, brightness);	break;			
4070  038a b600          	ld	a,_brightness
4071  038c 5f            	clrw	x
4072  038d 97            	ld	xl,a
4073  038e 89            	pushw	x
4074  038f ae0064        	ldw	x,#100
4075  0392 cd0000        	call	_PWM_Config
4077  0395 85            	popw	x
4080  0396 200b          	jra	L3152
4081  0398               L1622:
4082                     ; 151 				case STATE3:	PWM_Config(100, 80);	break;			
4084  0398 ae0050        	ldw	x,#80
4085  039b 89            	pushw	x
4086  039c ae0064        	ldw	x,#100
4087  039f cd0000        	call	_PWM_Config
4089  03a2 85            	popw	x
4092  03a3               L3622:
4093                     ; 152 				default: break;
4095  03a3               L1152:
4096  03a3               L3152:
4097                     ; 156 	ex_state = state;
4099  03a3 450013        	mov	L3712_ex_state,_state
4100                     ; 157 }
4103  03a6 84            	pop	a
4104  03a7 81            	ret
4107                     	bsct
4108  0014               L5152_adcCount:
4109  0014 00            	dc.b	0
4110  0015               L7152_adcData:
4111  0015 0000          	dc.w	0
4112  0017 0000          	dc.w	0
4113  0019 0000          	dc.w	0
4114  001b 0000          	dc.w	0
4115  001d 0000          	dc.w	0
4262                     ; 160 main()
4262                     ; 161 {
4263                     	switch	.text
4264  03a8               _main:
4266  03a8 5247          	subw	sp,#71
4267       00000047      OFST:	set	71
4270                     ; 162 	unsigned char i = 0, error = 0;
4272  03aa 7b47          	ld	a,(OFST+0,sp)
4273  03ac 97            	ld	xl,a
4276  03ad 0f02          	clr	(OFST-69,sp)
4277                     ; 166 	unsigned int OFF_LUX = 0;
4279  03af 1e43          	ldw	x,(OFST-4,sp)
4280                     ; 167 	unsigned int ON_LUX = 0;
4282  03b1 1e45          	ldw	x,(OFST-2,sp)
4283                     ; 168 	bool exRelayStat = OFF;
4285  03b3 a601          	ld	a,#1
4286  03b5 6b01          	ld	(OFST-70,sp),a
4287                     ; 170 	CFG_GCR = 0x00;//PD1 default SWIM
4289  03b7 725f7f60      	clr	_CFG_GCR
4290                     ; 171 	CLK_CKDIVR = 0x08;//f = f HSI RCÊä³ö/2=8MHz
4292  03bb 350850c6      	mov	_CLK_CKDIVR,#8
4293                     ; 172 	memset(tmp, '', BUFFER_SIZE);
4295  03bf 96            	ldw	x,sp
4296  03c0 1c0003        	addw	x,#OFST-68
4297  03c3 bf00          	ldw	c_x,x
4298  03c5 ae0040        	ldw	x,#64
4299  03c8               L27:
4300  03c8 5a            	decw	x
4301  03c9 926f00        	clr	([c_x.w],x)
4302  03cc 5d            	tnzw	x
4303  03cd 26f9          	jrne	L27
4304                     ; 173 	memset(RX_Buf, '', BUFFER_SIZE);
4306  03cf ae0040        	ldw	x,#64
4307  03d2               L47:
4308  03d2 6fff          	clr	(_RX_Buf-1,x)
4309  03d4 5a            	decw	x
4310  03d5 26fb          	jrne	L47
4311                     ; 174 	memset(read_Flash, '', 11);
4313  03d7 ae000b        	ldw	x,#11
4314  03da               L67:
4315  03da 6f00          	clr	(_read_Flash-1,x)
4316  03dc 5a            	decw	x
4317  03dd 26fb          	jrne	L67
4318                     ; 175 	TIM4_Init();//use for delay, high
4320  03df cd0000        	call	_TIM4_Init
4322                     ; 176 	for(i=0;i<=12;i++)
4324  03e2 0f47          	clr	(OFST+0,sp)
4325  03e4               L3062:
4326                     ; 178 		read_Flash[i] = FLASH_ReadByte(0x004000+i);
4328  03e4 7b47          	ld	a,(OFST+0,sp)
4329  03e6 5f            	clrw	x
4330  03e7 97            	ld	xl,a
4331  03e8 89            	pushw	x
4332  03e9 7b49          	ld	a,(OFST+2,sp)
4333  03eb 5f            	clrw	x
4334  03ec 97            	ld	xl,a
4335  03ed 1c4000        	addw	x,#16384
4336  03f0 cd0000        	call	c_itolx
4338  03f3 be02          	ldw	x,c_lreg+2
4339  03f5 89            	pushw	x
4340  03f6 be00          	ldw	x,c_lreg
4341  03f8 89            	pushw	x
4342  03f9 cd0000        	call	_FLASH_ReadByte
4344  03fc 5b04          	addw	sp,#4
4345  03fe 85            	popw	x
4346  03ff e701          	ld	(_read_Flash,x),a
4347                     ; 176 	for(i=0;i<=12;i++)
4349  0401 0c47          	inc	(OFST+0,sp)
4352  0403 7b47          	ld	a,(OFST+0,sp)
4353  0405 a10d          	cp	a,#13
4354  0407 25db          	jrult	L3062
4355                     ; 180 	ON_LUX  = ((unsigned int)read_Flash[11]<<8 | read_Flash[12]);
4357  0409 b60c          	ld	a,_read_Flash+11
4358  040b 5f            	clrw	x
4359  040c 97            	ld	xl,a
4360  040d 4f            	clr	a
4361  040e 02            	rlwa	x,a
4362  040f 01            	rrwa	x,a
4363  0410 ba0d          	or	a,_read_Flash+12
4364  0412 02            	rlwa	x,a
4365  0413 1f45          	ldw	(OFST-2,sp),x
4366  0415 01            	rrwa	x,a
4367                     ; 181 	OFF_LUX = ((unsigned int)read_Flash[13]<<8 | read_Flash[14]);
4369  0416 b60e          	ld	a,_read_Flash+13
4370  0418 5f            	clrw	x
4371  0419 97            	ld	xl,a
4372  041a 4f            	clr	a
4373  041b 02            	rlwa	x,a
4374  041c 01            	rrwa	x,a
4375  041d ba0f          	or	a,_read_Flash+14
4376  041f 02            	rlwa	x,a
4377  0420 1f43          	ldw	(OFST-4,sp),x
4378  0422 01            	rrwa	x,a
4379                     ; 183 	Delay1s(); Delay1s(); Delay1s(); Delay1s(); Delay1s(); //about 5s
4381  0423 cd0000        	call	_Delay1s
4385  0426 cd0000        	call	_Delay1s
4389  0429 cd0000        	call	_Delay1s
4393  042c cd0000        	call	_Delay1s
4397  042f cd0000        	call	_Delay1s
4399                     ; 184 	CFG_GCR = 0x01;//disable SWIM,PD1 set as GPIO
4401  0432 35017f60      	mov	_CFG_GCR,#1
4402                     ; 185 	UART_RXGPIO_Config();//PD1 SWIM change to UART_RX
4404  0436 cd0000        	call	_UART_RXGPIO_Config
4406                     ; 186 	PWM_GPIO_Config();//Dimming IO config, use TIM2
4408  0439 cd0000        	call	_PWM_GPIO_Config
4410                     ; 188 	InitADC();	
4412  043c cd0000        	call	_InitADC
4414                     ; 189 	adcData[0] = adcData[1] = adcData[2] = adcData[3] = adcData[4] = GetADC();
4416  043f cd0000        	call	_GetADC
4418  0442 bf1d          	ldw	L7152_adcData+8,x
4419  0444 be1d          	ldw	x,L7152_adcData+8
4420  0446 bf1b          	ldw	L7152_adcData+6,x
4421  0448 be1b          	ldw	x,L7152_adcData+6
4422  044a bf19          	ldw	L7152_adcData+4,x
4423  044c be19          	ldw	x,L7152_adcData+4
4424  044e bf17          	ldw	L7152_adcData+2,x
4425  0450 be17          	ldw	x,L7152_adcData+2
4426  0452 bf15          	ldw	L7152_adcData,x
4427                     ; 191 	Rly_GPIO_Config();
4429  0454 cd0000        	call	_Rly_GPIO_Config
4431                     ; 208 	_asm("rim"); //Enable interrupt
4434  0457 9a            rim
4436  0458               L1162:
4437                     ; 217 		LIGHT = ON;	Delay();Delay();Delay();Delay();
4439  0458 721b500a      	bres	_PC_ODR_5
4442  045c cd0000        	call	_Delay
4446  045f cd0000        	call	_Delay
4450  0462 cd0000        	call	_Delay
4454  0465 cd0000        	call	_Delay
4456                     ; 218 		LIGHT = OFF;Delay();Delay();Delay();Delay();
4458  0468 721a500a      	bset	_PC_ODR_5
4461  046c cd0000        	call	_Delay
4465  046f cd0000        	call	_Delay
4469  0472 cd0000        	call	_Delay
4473  0475 cd0000        	call	_Delay
4476  0478 20de          	jra	L1162
4514                     ; 323 @far @interrupt void TIM1_UPD_IRQHandler(void)
4514                     ; 324 {
4516                     	switch	.text
4517  047a               f_TIM1_UPD_IRQHandler:
4520       00000001      OFST:	set	1
4521  047a 88            	push	a
4524                     ; 325 	unsigned char i = 0;
4526  047b 0f01          	clr	(OFST+0,sp)
4527                     ; 326 	TIM1_SR1 &= 0xFE;//clear interrupt label
4529  047d 72115255      	bres	_TIM1_SR1,#0
4530                     ; 327 	second++;
4532  0481 be0c          	ldw	x,_second
4533  0483 1c0001        	addw	x,#1
4534  0486 bf0c          	ldw	_second,x
4535                     ; 328 	if(second >= 3600)/***********´ý±ä¸ü£¡£¡£¡£¡£¡***************/
4537  0488 be0c          	ldw	x,_second
4538  048a a30e10        	cpw	x,#3600
4539  048d 250a          	jrult	L3362
4540                     ; 330 		second = 0;
4542  048f 5f            	clrw	x
4543  0490 bf0c          	ldw	_second,x
4544                     ; 331 		hour += 1;
4546  0492 be0e          	ldw	x,_hour
4547  0494 1c0001        	addw	x,#1
4548  0497 bf0e          	ldw	_hour,x
4549  0499               L3362:
4550                     ; 335 }
4553  0499 84            	pop	a
4554  049a 80            	iret
4710                     	xdef	f_TIM1_UPD_IRQHandler
4711                     	xdef	_main
4712                     	xdef	_DimmingMode
4713                     	switch	.ubsct
4714  0000               _state:
4715  0000 00            	ds.b	1
4716                     	xdef	_state
4717                     	xdef	_read_Flash
4718                     	xref	_FLASH_ReadByte
4719                     	xref	_FLASH_ProgramByte
4720                     	xref	_LockEEPROM
4721                     	xref	_UnlockEEPROM
4722                     	xref	_UART_RXGPIO_Config
4723                     	xref.b	_frameEnd
4724                     	xref.b	_BufLength
4725                     	xref.b	_RX_Buf
4726                     	xref	_memset
4727                     	xdef	_relayStat
4728                     	xdef	_timeChanged
4729                     	xdef	_isDimmingConfiged
4730                     	xdef	_brightness
4731                     	xdef	_hour
4732                     	xdef	_second
4733                     	xref	_TIM4_Init
4734                     	xref	_Delay1s
4735                     	xref	_Delay
4736                     	xref	_GetADC
4737                     	xref	_InitADC
4738                     	xref	_PWM_GPIO_Config
4739                     	xref	_PWM_Config
4740                     	xref	_Rly_GPIO_Config
4741                     	xref.b	c_lreg
4742                     	xref.b	c_x
4762                     	xref	c_itolx
4763                     	end
