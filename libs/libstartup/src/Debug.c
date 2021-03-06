#include <Debug.h>
#include <USART.h>

#include <stdio.h>

#ifdef DEBUG
uint32_t DebugEnabled = 0;

void EnableDebugOutput(DebugDevice device)
{
	MyUSART_Init();
	setvbuf(stdout, 0, _IONBF, 0);

	DebugEnabled = 1;
}

void DebugPrintChar(char c)
{
	if(DebugEnabled)
		USART_SendChar(c);
}

#else

void EnableDebugOutput(DebugDevice device)
{
}

void DebugPrintChar(char c)
{
}

#endif
