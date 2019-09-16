   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
   5                     ; 12 @far @interrupt void NonHandledInterrupt (void)
   5                     ; 13 {
   6  0000               f_NonHandledInterrupt:
   9                     ; 17 	return;
  10  0000 80            	iret	
  11                     .const:	section	.text
  12  0000               __vectab:
  13  0000 82            	dc.b	130
  15  0001 00            	dc.b	page(__stext)
  16  0002 0000          	dc.w	__stext
  17  0004 82            	dc.b	130
  19  0005 00            	dc.b	page(f_NonHandledInterrupt)
  20  0006 0000          	dc.w	f_NonHandledInterrupt
  21  0008 82            	dc.b	130
  23  0009 00            	dc.b	page(f_NonHandledInterrupt)
  24  000a 0000          	dc.w	f_NonHandledInterrupt
  25  000c 82            	dc.b	130
  27  000d 00            	dc.b	page(f_NonHandledInterrupt)
  28  000e 0000          	dc.w	f_NonHandledInterrupt
  29  0010 82            	dc.b	130
  31  0011 00            	dc.b	page(f_NonHandledInterrupt)
  32  0012 0000          	dc.w	f_NonHandledInterrupt
  33  0014 82            	dc.b	130
  35  0015 00            	dc.b	page(f_NonHandledInterrupt)
  36  0016 0000          	dc.w	f_NonHandledInterrupt
  37  0018 82            	dc.b	130
  39  0019 00            	dc.b	page(f_NonHandledInterrupt)
  40  001a 0000          	dc.w	f_NonHandledInterrupt
  41  001c 82            	dc.b	130
  43  001d 00            	dc.b	page(f_NonHandledInterrupt)
  44  001e 0000          	dc.w	f_NonHandledInterrupt
  45  0020 82            	dc.b	130
  47  0021 00            	dc.b	page(f_NonHandledInterrupt)
  48  0022 0000          	dc.w	f_NonHandledInterrupt
  49  0024 82            	dc.b	130
  51  0025 00            	dc.b	page(f_NonHandledInterrupt)
  52  0026 0000          	dc.w	f_NonHandledInterrupt
  53  0028 82            	dc.b	130
  55  0029 00            	dc.b	page(f_NonHandledInterrupt)
  56  002a 0000          	dc.w	f_NonHandledInterrupt
  57  002c 82            	dc.b	130
  59  002d 00            	dc.b	page(f_NonHandledInterrupt)
  60  002e 0000          	dc.w	f_NonHandledInterrupt
  61  0030 82            	dc.b	130
  63  0031 00            	dc.b	page(f_NonHandledInterrupt)
  64  0032 0000          	dc.w	f_NonHandledInterrupt
  65  0034 82            	dc.b	130
  67  0035 00            	dc.b	page(f_TIM1_UPD_IRQHandler)
  68  0036 0000          	dc.w	f_TIM1_UPD_IRQHandler
  69  0038 82            	dc.b	130
  71  0039 00            	dc.b	page(f_NonHandledInterrupt)
  72  003a 0000          	dc.w	f_NonHandledInterrupt
  73  003c 82            	dc.b	130
  75  003d 00            	dc.b	page(f_NonHandledInterrupt)
  76  003e 0000          	dc.w	f_NonHandledInterrupt
  77  0040 82            	dc.b	130
  79  0041 00            	dc.b	page(f_NonHandledInterrupt)
  80  0042 0000          	dc.w	f_NonHandledInterrupt
  81  0044 82            	dc.b	130
  83  0045 00            	dc.b	page(f_NonHandledInterrupt)
  84  0046 0000          	dc.w	f_NonHandledInterrupt
  85  0048 82            	dc.b	130
  87  0049 00            	dc.b	page(f_NonHandledInterrupt)
  88  004a 0000          	dc.w	f_NonHandledInterrupt
  89  004c 82            	dc.b	130
  91  004d 00            	dc.b	page(f_NonHandledInterrupt)
  92  004e 0000          	dc.w	f_NonHandledInterrupt
  93  0050 82            	dc.b	130
  95  0051 00            	dc.b	page(f_NonHandledInterrupt)
  96  0052 0000          	dc.w	f_NonHandledInterrupt
  97  0054 82            	dc.b	130
  99  0055 00            	dc.b	page(f_NonHandledInterrupt)
 100  0056 0000          	dc.w	f_NonHandledInterrupt
 101  0058 82            	dc.b	130
 103  0059 00            	dc.b	page(f_NonHandledInterrupt)
 104  005a 0000          	dc.w	f_NonHandledInterrupt
 105  005c 82            	dc.b	130
 107  005d 00            	dc.b	page(f_NonHandledInterrupt)
 108  005e 0000          	dc.w	f_NonHandledInterrupt
 109  0060 82            	dc.b	130
 111  0061 00            	dc.b	page(f_NonHandledInterrupt)
 112  0062 0000          	dc.w	f_NonHandledInterrupt
 113  0064 82            	dc.b	130
 115  0065 00            	dc.b	page(f_NonHandledInterrupt)
 116  0066 0000          	dc.w	f_NonHandledInterrupt
 117  0068 82            	dc.b	130
 119  0069 00            	dc.b	page(f_NonHandledInterrupt)
 120  006a 0000          	dc.w	f_NonHandledInterrupt
 121  006c 82            	dc.b	130
 123  006d 00            	dc.b	page(f_NonHandledInterrupt)
 124  006e 0000          	dc.w	f_NonHandledInterrupt
 125  0070 82            	dc.b	130
 127  0071 00            	dc.b	page(f_NonHandledInterrupt)
 128  0072 0000          	dc.w	f_NonHandledInterrupt
 129  0074 82            	dc.b	130
 131  0075 00            	dc.b	page(f_NonHandledInterrupt)
 132  0076 0000          	dc.w	f_NonHandledInterrupt
 133  0078 82            	dc.b	130
 135  0079 00            	dc.b	page(f_NonHandledInterrupt)
 136  007a 0000          	dc.w	f_NonHandledInterrupt
 137  007c 82            	dc.b	130
 139  007d 00            	dc.b	page(f_NonHandledInterrupt)
 140  007e 0000          	dc.w	f_NonHandledInterrupt
 141                     	xdef	__vectab
 142                     	xref	f_TIM1_UPD_IRQHandler
 143                     	xref	__stext
 144                     	xdef	f_NonHandledInterrupt
 145                     	end
