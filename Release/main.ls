   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 571                     	bsct
 572  0000               _brightness:
 573  0000 2b            	dc.b	43
 574  0001               _second:
 575  0001 0000          	dc.w	0
 576  0003               _hour:
 577  0003 0000          	dc.w	0
 578  0005               _relayStat:
 579  0005 00            	dc.b	0
 580  0006               _isDimmingConfiged:
 581  0006 00            	dc.b	0
 582  0007               _timeChanged:
 583  0007 00            	dc.b	0
 584  0008               L3_ex_state:
 585  0008 00            	dc.b	0
 586                     ; 29 void DimmingMode(Mode mode)
 586                     ; 30 {
 587                     	scross	off
 588                     	switch	.text
 589  0000               _DimmingMode:
 590  0000 88            	push	a
 591       00000000      OFST:	set	0
 593                     ; 31 	if(LIGHT == ON)
 594  0001 720b500a03cc  	btjt	_PC_ODR_5,L15
 595                     ; 33 		switch (mode)
 596  0009 7b01          	ld	a,(OFST+1,sp)
 598                     ; 80 			default:	break;
 599  000b 2712          	jreq	L5
 600  000d 4a            	dec	a
 601  000e 273a          	jreq	L7
 602  0010 4a            	dec	a
 603  0011 2750          	jreq	L11
 604  0013 4a            	dec	a
 605  0014 2765          	jreq	L31
 606  0016 4a            	dec	a
 607  0017 2603cc00a3    	jreq	L51
 608  001c cc00dc        	jra	L15
 609  001f               L5:
 610                     ; 35 			case MODE0:
 610                     ; 36 				if(hour >= 0 && hour < 6)
 611  001f be03          	ldw	x,_hour
 612  0021 a30006        	cpw	x,#6
 613  0024 2407          	jruge	L75
 614                     ; 37 					state = STATE1;
 615  0026 35010000      	mov	_state,#1
 617  002a cc00dc        	jra	L15
 618  002d               L75:
 619                     ; 38 				else if(hour >= 6 && hour < 10)//(hour >= 6 && hour < 10)
 620  002d a30006        	cpw	x,#6
 621  0030 250c          	jrult	L36
 623  0032 a3000a        	cpw	x,#10
 624  0035 2407          	jruge	L36
 625                     ; 39 					state = STATE2;
 626  0037 35020000      	mov	_state,#2
 628  003b cc00dc        	jra	L15
 629  003e               L36:
 630                     ; 40 				else if(hour >= 10) 
 631  003e a3000a        	cpw	x,#10
 632  0041 25f8          	jrult	L15
 633                     ; 41 					state = STATE3;
 634  0043 35030000      	mov	_state,#3
 635  0047 cc00dc        	jra	L15
 636  004a               L7:
 637                     ; 44 			case MODE1:
 637                     ; 45 				if(hour >= 0 && hour < 6)
 638  004a be03          	ldw	x,_hour
 639  004c a30006        	cpw	x,#6
 640  004f 2407          	jruge	L17
 641                     ; 46 					state = STATE1;
 642  0051 35010000      	mov	_state,#1
 644  0055 cc00dc        	jra	L15
 645  0058               L17:
 646                     ; 47 				else if(hour >= 6)//(hour >= 6 && hour < 10)
 647  0058 a30006        	cpw	x,#6
 648  005b 257f          	jrult	L15
 649                     ; 48 					state = STATE2;
 650  005d 35020000      	mov	_state,#2
 651  0061 2079          	jra	L15
 652  0063               L11:
 653                     ; 51 			case MODE2:
 653                     ; 52 				if(hour >= 0 && hour < 9)
 654  0063 be03          	ldw	x,_hour
 655  0065 a30009        	cpw	x,#9
 656  0068 2406          	jruge	L77
 657                     ; 53 					state = STATE1;
 658  006a 35010000      	mov	_state,#1
 660  006e 206c          	jra	L15
 661  0070               L77:
 662                     ; 54 				else if(hour >= 9)//always in dimming state
 663  0070 a30009        	cpw	x,#9
 664  0073 2567          	jrult	L15
 665                     ; 55 					state = STATE2;
 666  0075 35020000      	mov	_state,#2
 667  0079 2061          	jra	L15
 668  007b               L31:
 669                     ; 58 			case MODE3: 	
 669                     ; 59 				if(second >= 0 && second < 10)
 670  007b be01          	ldw	x,_second
 671  007d a3000a        	cpw	x,#10
 672  0080 2406          	jruge	L501
 673                     ; 60 					state = STATE1;
 674  0082 35010000      	mov	_state,#1
 676  0086 2054          	jra	L15
 677  0088               L501:
 678                     ; 61 				else if(second >= 10 && second < 20)//(hour >= 6 && hour < 10)
 679  0088 a3000a        	cpw	x,#10
 680  008b 250b          	jrult	L111
 682  008d a30014        	cpw	x,#20
 683  0090 2406          	jruge	L111
 684                     ; 62 					state = STATE2;
 685  0092 35020000      	mov	_state,#2
 687  0096 2044          	jra	L15
 688  0098               L111:
 689                     ; 63 				else if(second >= 20) 
 690  0098 a30014        	cpw	x,#20
 691  009b 253f          	jrult	L15
 692                     ; 64 					state = STATE3;		
 693  009d 35030000      	mov	_state,#3
 694  00a1 2039          	jra	L15
 695  00a3               L51:
 696                     ; 67 			case MODE4:
 696                     ; 68 				if(hour >= 0 && hour < 1)//1hour
 697  00a3 be03          	ldw	x,_hour
 698  00a5 2606          	jrne	LC001
 699                     ; 69 					state = STATE1;
 700  00a7 35010000      	mov	_state,#1
 702  00ab 202f          	jra	L15
 703                     ; 70 				else if(hour >= 1 && hour < 4)//3hours
 704  00ad               LC001:
 706  00ad a30004        	cpw	x,#4
 707  00b0 2406          	jruge	L321
 708                     ; 71 					state = STATE2;
 709  00b2 35020000      	mov	_state,#2
 711  00b6 2024          	jra	L15
 712  00b8               L321:
 713                     ; 72 				else if(hour >= 4 && hour < 5)//1hour
 714  00b8 a30004        	cpw	x,#4
 715  00bb 250b          	jrult	L721
 717  00bd a30005        	cpw	x,#5
 718  00c0 2406          	jruge	L721
 719                     ; 73 					state = STATE3;					
 720  00c2 35030000      	mov	_state,#3
 722  00c6 2014          	jra	L15
 723  00c8               L721:
 724                     ; 74 				else if(hour >= 5 && hour < 12)//7hours
 725  00c8 a30005        	cpw	x,#5
 726  00cb 250b          	jrult	L331
 728  00cd a3000c        	cpw	x,#12
 729  00d0 2406          	jruge	L331
 730                     ; 75 					state = STATE4;
 731  00d2 35040000      	mov	_state,#4
 733  00d6 2004          	jra	L15
 734  00d8               L331:
 735                     ; 77 					state = STATE5;
 736  00d8 35050000      	mov	_state,#5
 737                     ; 80 			default:	break;
 738  00dc               L15:
 739                     ; 84 	if(ex_state != state)
 740  00dc b608          	ld	a,L3_ex_state
 741  00de b100          	cp	a,_state
 742  00e0 2763          	jreq	L551
 743                     ; 86 		if(mode == MODE4)
 744  00e2 7b01          	ld	a,(OFST+1,sp)
 745  00e4 a104          	cp	a,#4
 746  00e6 2635          	jrne	L141
 747                     ; 88 			switch (state)
 748  00e8 b600          	ld	a,_state
 750                     ; 96 				default: break;
 751  00ea 2711          	jreq	L12
 752  00ec 4a            	dec	a
 753  00ed 2715          	jreq	L32
 754  00ef 4a            	dec	a
 755  00f0 274b          	jreq	L54
 756  00f2 4a            	dec	a
 757  00f3 2718          	jreq	L72
 758  00f5 4a            	dec	a
 759  00f6 271e          	jreq	L13
 760  00f8 4a            	dec	a
 761  00f9 271b          	jreq	L13
 762  00fb 2048          	jra	L551
 763  00fd               L12:
 764                     ; 90 				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
 765  00fd 5f            	clrw	x
 766  00fe 89            	pushw	x
 767  00ff ae0064        	ldw	x,#100
 770  0102 203d          	jp	LC002
 771  0104               L32:
 772                     ; 91 				case STATE1:	PWM_Config(100, 80);	break;
 773  0104 ae0050        	ldw	x,#80
 774  0107 89            	pushw	x
 775  0108 ae0064        	ldw	x,#100
 778  010b 2034          	jp	LC002
 779                     ; 92 				case STATE2:	PWM_Config(100, 100);	break;			
 782  010d               L72:
 783                     ; 93 				case STATE3:	PWM_Config(100, 70);	break;
 784  010d ae0046        	ldw	x,#70
 785  0110 89            	pushw	x
 786  0111 ae0064        	ldw	x,#100
 789  0114 202b          	jp	LC002
 790  0116               L13:
 791                     ; 94 				case STATE4:	PWM_Config(100, 50);	break;
 792  0116 ae0032        	ldw	x,#50
 793  0119 89            	pushw	x
 794  011a 58            	sllw	x
 797  011b 2024          	jp	LC002
 798                     ; 95 				case STATE5:	PWM_Config(100, 50);	break;
 801                     ; 96 				default: break;
 803  011d               L141:
 804                     ; 101 			switch (state)
 805  011d b600          	ld	a,_state
 807                     ; 107 				default: break;
 808  011f 270b          	jreq	L73
 809  0121 4a            	dec	a
 810  0122 2719          	jreq	L54
 811  0124 4a            	dec	a
 812  0125 270c          	jreq	L34
 813  0127 4a            	dec	a
 814  0128 2713          	jreq	L54
 815  012a 2019          	jra	L551
 816  012c               L73:
 817                     ; 103 				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
 818  012c 5f            	clrw	x
 819  012d 89            	pushw	x
 820  012e ae0064        	ldw	x,#100
 823  0131 200e          	jp	LC002
 824                     ; 104 				case STATE1:	PWM_Config(100, 100);	break;
 827  0133               L34:
 828                     ; 105 				case STATE2:	PWM_Config(100, brightness);	break;			
 829  0133 b600          	ld	a,_brightness
 830  0135 5f            	clrw	x
 831  0136 97            	ld	xl,a
 832  0137 89            	pushw	x
 833  0138 ae0064        	ldw	x,#100
 836  013b 2004          	jp	LC002
 837  013d               L54:
 838                     ; 106 				case STATE3:	PWM_Config(100, 100);	break;			
 839  013d ae0064        	ldw	x,#100
 840  0140 89            	pushw	x
 842  0141               LC002:
 843  0141 cd0000        	call	_PWM_Config
 844  0144 85            	popw	x
 846                     ; 107 				default: break;
 847  0145               L551:
 848                     ; 111 	ex_state = state;
 849  0145 450008        	mov	L3_ex_state,_state
 850                     ; 112 }
 851  0148 84            	pop	a
 852  0149 81            	ret	
 854                     	bsct
 855  0009               L751_adcData:
 856  0009 0000          	dc.w	0
 857  000b 0000          	dc.w	0
 858  000d 0000          	dc.w	0
 859  000f 0000          	dc.w	0
 860  0011 0000          	dc.w	0
 861                     ; 115 main()
 861                     ; 116 {
 862                     	switch	.text
 863  014a               _main:
 864  014a 89            	pushw	x
 865       00000002      OFST:	set	2
 867                     ; 117 	unsigned char i = 0;
 868  014b 0f02          	clr	(OFST+0,sp)
 869                     ; 119 	bool exRelayStat = OFF;
 870  014d a601          	ld	a,#1
 871  014f 6b01          	ld	(OFST-1,sp),a
 872                     ; 122 	CLK_CKDIVR = 0x08;//f = f HSI RCÊä³ö/2=8MHz
 873  0151 350850c6      	mov	_CLK_CKDIVR,#8
 874                     ; 125 	Delay(); Delay(); Delay(); Delay(); Delay(); //about 5s
 875  0155 cd0000        	call	_Delay
 878  0158 cd0000        	call	_Delay
 881  015b cd0000        	call	_Delay
 884  015e cd0000        	call	_Delay
 887  0161 cd0000        	call	_Delay
 889                     ; 129 	PWM_GPIO_Config();
 890  0164 cd0000        	call	_PWM_GPIO_Config
 892                     ; 132 	InitADC();	
 893  0167 cd0000        	call	_InitADC
 895                     ; 133 	adcData[0] = adcData[1] = adcData[2] = adcData[3] = adcData[4] = GetADC();
 896  016a cd0000        	call	_GetADC
 898  016d bf11          	ldw	L751_adcData+8,x
 899  016f bf0f          	ldw	L751_adcData+6,x
 900  0171 bf0d          	ldw	L751_adcData+4,x
 901  0173 bf0b          	ldw	L751_adcData+2,x
 902  0175 bf09          	ldw	L751_adcData,x
 903                     ; 134 	Rly_GPIO_Config();
 904  0177 cd0000        	call	_Rly_GPIO_Config
 906                     ; 135 	if(adcData[0] < ON_LUX)//initial LIGHT IO
 907  017a be09          	ldw	x,L751_adcData
 908  017c a3128e        	cpw	x,#4750
 909  017f 240b          	jruge	L161
 910                     ; 137 		LIGHT = OFF;
 911  0181 721a500a      	bset	_PC_ODR_5
 912                     ; 138 		PWM_Config(100, 0);//PWM off
 913  0185 5f            	clrw	x
 914  0186 89            	pushw	x
 915  0187 ae0064        	ldw	x,#100
 918  018a 2008          	jra	L361
 919  018c               L161:
 920                     ; 142 		LIGHT = ON;
 921  018c 721b500a      	bres	_PC_ODR_5
 922                     ; 143 		PWM_Config(100, 100);//PWM off
 923  0190 ae0064        	ldw	x,#100
 924  0193 89            	pushw	x
 926  0194               L361:
 927  0194 cd0000        	call	_PWM_Config
 928  0197 85            	popw	x
 929                     ; 147 	TIM1_Init();
 930  0198 cd0000        	call	_TIM1_Init
 932  019b               L561:
 933                     ; 151 		adcData[i++] = GetADC();
 934  019b cd0000        	call	_GetADC
 936  019e 7b02          	ld	a,(OFST+0,sp)
 937  01a0 905f          	clrw	y
 938  01a2 9097          	ld	yl,a
 939  01a4 9058          	sllw	y
 940  01a6 90ef09        	ldw	(L751_adcData,y),x
 941                     ; 152 		if(i > 4)	i = 0;
 942  01a9 4c            	inc	a
 943  01aa 6b02          	ld	(OFST+0,sp),a
 944  01ac a105          	cp	a,#5
 945  01ae 2502          	jrult	L171
 947  01b0 0f02          	clr	(OFST+0,sp)
 948  01b2               L171:
 949                     ; 155 		if(adcData[0] < OFF_LUX \
 949                     ; 156 		&& adcData[1] < OFF_LUX \
 949                     ; 157 		&& adcData[2] < OFF_LUX \
 949                     ; 158 		&& adcData[3] < OFF_LUX \
 949                     ; 159 		&& adcData[4] < OFF_LUX)
 950  01b2 be09          	ldw	x,L751_adcData
 951  01b4 a31162        	cpw	x,#4450
 952  01b7 2441          	jruge	L371
 954  01b9 be0b          	ldw	x,L751_adcData+2
 955  01bb a31162        	cpw	x,#4450
 956  01be 243a          	jruge	L371
 958  01c0 be0d          	ldw	x,L751_adcData+4
 959  01c2 a31162        	cpw	x,#4450
 960  01c5 2433          	jruge	L371
 962  01c7 be0f          	ldw	x,L751_adcData+6
 963  01c9 a31162        	cpw	x,#4450
 964  01cc 242c          	jruge	L371
 966  01ce be11          	ldw	x,L751_adcData+8
 967  01d0 a31162        	cpw	x,#4450
 968  01d3 2425          	jruge	L371
 969                     ; 161 			if(LIGHT == ON)//only when light on/off change 
 970  01d5 720a500a11    	btjt	_PC_ODR_5,L571
 971                     ; 163 				LIGHT = OFF;//Relay_IO = 1
 972  01da 721a500a      	bset	_PC_ODR_5
 973                     ; 164 				PWM_Config(100, 0);//PWM off
 974  01de 5f            	clrw	x
 975  01df 89            	pushw	x
 976  01e0 ae0064        	ldw	x,#100
 977  01e3 cd0000        	call	_PWM_Config
 979  01e6 72115250      	bres	_TIM1_CR1,#0
 980  01ea 85            	popw	x
 981                     ; 165 				TIM1_CR1 &= 0xFE;//stop time counter
 982  01eb               L571:
 983                     ; 167 			if(state != STATE0)
 984  01eb b600          	ld	a,_state
 985  01ed 2704          	jreq	L771
 986                     ; 168 				ex_state = state = STATE0;
 987  01ef 3f00          	clr	_state
 988  01f1 3f08          	clr	L3_ex_state
 989  01f3               L771:
 990                     ; 170 			second = 0;
 991  01f3 5f            	clrw	x
 992  01f4 bf01          	ldw	_second,x
 993                     ; 171 			hour = 0;
 994  01f6 bf03          	ldw	_hour,x
 996  01f8 204a          	jra	L102
 997  01fa               L371:
 998                     ; 174 		else if(adcData[0] > ON_LUX \
 998                     ; 175 		&& adcData[1] > ON_LUX \
 998                     ; 176 		&& adcData[2] > ON_LUX \
 998                     ; 177 		&& adcData[3] > ON_LUX\
 998                     ; 178 		&& adcData[4] > ON_LUX)
 999  01fa be09          	ldw	x,L751_adcData
1000  01fc a3128f        	cpw	x,#4751
1001  01ff 2543          	jrult	L102
1003  0201 be0b          	ldw	x,L751_adcData+2
1004  0203 a3128f        	cpw	x,#4751
1005  0206 253c          	jrult	L102
1007  0208 be0d          	ldw	x,L751_adcData+4
1008  020a a3128f        	cpw	x,#4751
1009  020d 2535          	jrult	L102
1011  020f be0f          	ldw	x,L751_adcData+6
1012  0211 a3128f        	cpw	x,#4751
1013  0214 252e          	jrult	L102
1015  0216 be11          	ldw	x,L751_adcData+8
1016  0218 a3128f        	cpw	x,#4751
1017  021b 2527          	jrult	L102
1018                     ; 180 			if(LIGHT == OFF)//only when light on/off change 
1019  021d 720b500a04    	btjf	_PC_ODR_5,L502
1020                     ; 182 				LIGHT = ON;
1021  0222 721b500a      	bres	_PC_ODR_5
1022  0226               L502:
1023                     ; 184 			if((TIM1_CR1 & 0x01) == 0)//if time counter not started, start counting
1024  0226 720052500d    	btjt	_TIM1_CR1,#0,L702
1025                     ; 186 				second = 0;
1026  022b 5f            	clrw	x
1027  022c bf01          	ldw	_second,x
1028                     ; 187 				hour = 0;
1029  022e bf03          	ldw	_hour,x
1030                     ; 188 				TIM1_CR1 |= 0x01;//start time counter
1031  0230 72105250      	bset	_TIM1_CR1,#0
1032                     ; 189 				TIM1_IER |= 0x01;				
1033  0234 72105254      	bset	_TIM1_IER,#0
1034  0238               L702:
1035                     ; 191 			if(state == STATE0)
1036  0238 b600          	ld	a,_state
1037  023a 2608          	jrne	L102
1038                     ; 193 				PWM_Config(100, 100);
1039  023c ae0064        	ldw	x,#100
1040  023f 89            	pushw	x
1041  0240 cd0000        	call	_PWM_Config
1043  0243 85            	popw	x
1044  0244               L102:
1045                     ; 198 		DimmingMode(userMode);
1046  0244 a604          	ld	a,#4
1047  0246 cd0000        	call	_DimmingMode
1049                     ; 199 		Delay();
1050  0249 cd0000        	call	_Delay
1053  024c cc019b        	jra	L561
1055                     ; 204 @far @interrupt void TIM1_UPD_IRQHandler(void)
1055                     ; 205 {
1056                     	scross	on
1057  024f               f_TIM1_UPD_IRQHandler:
1059       00000001      OFST:	set	1
1060  024f 88            	push	a
1062                     ; 206 	unsigned char i = 0;
1063  0250 0f01          	clr	(OFST+0,sp)
1064                     ; 207 	TIM1_SR1 &= 0xFE;//clear interrupt label
1065  0252 72115255      	bres	_TIM1_SR1,#0
1066                     ; 208 	second++;
1067  0256 be01          	ldw	x,_second
1068  0258 5c            	incw	x
1069  0259 bf01          	ldw	_second,x
1070                     ; 209 	if(second >= 3600)/***********´ý±ä¸ü£¡£¡£¡£¡£¡***************/
1071  025b a30e10        	cpw	x,#3600
1072  025e 2508          	jrult	L512
1073                     ; 211 		second = 0;
1074  0260 5f            	clrw	x
1075  0261 bf01          	ldw	_second,x
1076                     ; 212 		hour += 1;
1077  0263 be03          	ldw	x,_hour
1078  0265 5c            	incw	x
1079  0266 bf03          	ldw	_hour,x
1080  0268               L512:
1081                     ; 216 }
1082  0268 84            	pop	a
1083  0269 80            	iret	
1084                     	xdef	f_TIM1_UPD_IRQHandler
1085                     	xdef	_main
1086                     	xdef	_DimmingMode
1087                     	switch	.ubsct
1088  0000               _state:
1089  0000 00            	ds.b	1
1090                     	xdef	_state
1091                     	xdef	_relayStat
1092                     	xdef	_timeChanged
1093                     	xdef	_isDimmingConfiged
1094                     	xdef	_brightness
1095                     	xdef	_hour
1096                     	xdef	_second
1097                     	xref	_TIM1_Init
1098                     	xref	_Delay
1099                     	xref	_GetADC
1100                     	xref	_InitADC
1101                     	xref	_PWM_GPIO_Config
1102                     	xref	_PWM_Config
1103                     	xref	_Rly_GPIO_Config
1104                     	end
