   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 571                     ; 7 void Delay(void)
 571                     ; 8 {
 572                     	scross	off
 573  0000               _Delay:
 574  0000 5204          	subw	sp,#4
 575       00000004      OFST:	set	4
 577                     ; 10 	for(i=0; i<1024; i++)
 578  0002 5f            	clrw	x
 580  0003 2012          	jra	L7
 581  0005               L3:
 582                     ; 12 		for(j=0; j<512; j++); 
 583  0005 5f            	clrw	x
 585  0006 2003          	jra	L71
 586  0008               L31:
 588  0008 1e03          	ldw	x,(OFST-1,sp)
 589  000a 5c            	incw	x
 590  000b               L71:
 591  000b 1f03          	ldw	(OFST-1,sp),x
 593  000d 1e03          	ldw	x,(OFST-1,sp)
 594  000f a30200        	cpw	x,#512
 595  0012 25f4          	jrult	L31
 596                     ; 10 	for(i=0; i<1024; i++)
 597  0014 1e01          	ldw	x,(OFST-3,sp)
 598  0016 5c            	incw	x
 599  0017               L7:
 600  0017 1f01          	ldw	(OFST-3,sp),x
 602  0019 1e01          	ldw	x,(OFST-3,sp)
 603  001b a30400        	cpw	x,#1024
 604  001e 25e5          	jrult	L3
 605                     ; 14 }
 606  0020 5b04          	addw	sp,#4
 607  0022 81            	ret	
 609                     ; 16 void TIM1_Init(void)
 609                     ; 17 {
 610  0023               _TIM1_Init:
 612                     ; 18 	_asm("sim");
 614  0023 9b            	sim	
 616                     ; 19 	TIM1_IER = 0x00;
 617  0024 725f5254      	clr	_TIM1_IER
 618                     ; 20 	TIM1_CR1 = 0x00;
 619  0028 725f5250      	clr	_TIM1_CR1
 620                     ; 21 	TIM1_CR2 = 0x00;
 621  002c 725f5251      	clr	_TIM1_CR2
 622                     ; 22 	TIM1_PSCRH = 0x1F;//8000 DIV----->1KHz
 623  0030 351f5260      	mov	_TIM1_PSCRH,#31
 624                     ; 23 	TIM1_PSCRL = 0x3F;
 625  0034 353f5261      	mov	_TIM1_PSCRL,#63
 626                     ; 26 	TIM1_ARRH = (unsigned char)(990 >> 8);
 627  0038 35035262      	mov	_TIM1_ARRH,#3
 628                     ; 27 	TIM1_ARRL = (unsigned char)990;
 629  003c 35de5263      	mov	_TIM1_ARRL,#222
 630                     ; 28 	TIM1_EGR = 0X01;
 631  0040 35015257      	mov	_TIM1_EGR,#1
 632                     ; 29 	TIM1_CR1 &= 0xFE;
 633  0044 72115250      	bres	_TIM1_CR1,#0
 634                     ; 31 	_asm("rim");
 636  0048 9a            	rim	
 638                     ; 32 }
 639  0049 81            	ret	
 641                     	xdef	_TIM1_Init
 642                     	xdef	_Delay
 643                     	end
