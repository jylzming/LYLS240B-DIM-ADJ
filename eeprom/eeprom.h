#ifndef _EEPROM_
#define _EEPROM_

#include "STM8S001J3.h"
#include "stm8s_bit.h"

unsigned char UnlockEEPROM(void);
void LockEEPROM(void);

void FLASH_EraseByte(unsigned long address);
void FLASH_ProgramByte(unsigned long address, unsigned char Data);
unsigned char FLASH_ReadByte(unsigned long address);
void FLASH_EraseBlock(unsigned int address);
void FLASH_ProgramBlock(unsigned int address,unsigned char *buffer);
void WriteData(unsigned char BlockStartAddress,unsigned char *Buffer,unsigned char BlockNum);
void ReadData(unsigned char BlockStartAddress,unsigned char *Buffer,unsigned char BlockNum);


#endif
