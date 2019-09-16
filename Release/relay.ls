   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 571                     ; 4 void Rly_GPIO_Config(void)
 571                     ; 5 {
 572                     	scross	off
 573  0000               _Rly_GPIO_Config:
 575                     ; 6 	PC_DDR |= 0x01 << 5;//PC5 IO口设置为上拉输出
 576  0000 721a500c      	bset	_PC_DDR,#5
 577                     ; 7 	PC_CR1 |= 0x01 << 5;
 578  0004 721a500d      	bset	_PC_CR1,#5
 579                     ; 8 	PC_CR2 |= 0x01 << 5;
 580  0008 721a500e      	bset	_PC_CR2,#5
 581                     ; 9 }
 582  000c 81            	ret	
 584                     	xdef	_Rly_GPIO_Config
 585                     	end
