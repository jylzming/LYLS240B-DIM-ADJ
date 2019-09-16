   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3251                     ; 4 void Rly_GPIO_Config(void)
3251                     ; 5 {
3253                     	switch	.text
3254  0000               _Rly_GPIO_Config:
3258                     ; 6 	PC_DDR |= 0x01 << 5;//PC5 IO口设置为上拉输出
3260  0000 721a500c      	bset	_PC_DDR,#5
3261                     ; 7 	PC_CR1 |= 0x01 << 5;
3263  0004 721a500d      	bset	_PC_CR1,#5
3264                     ; 8 	PC_CR2 |= 0x01 << 5;
3266  0008 721a500e      	bset	_PC_CR2,#5
3267                     ; 9 }
3270  000c 81            	ret
3283                     	xdef	_Rly_GPIO_Config
3302                     	end
