#include <System.h>

#include <stdio.h>
#include <stdlib.h>

int main()
{
	//Get some information on how our clock is configured
	RCC_ClocksTypeDef RCC_Clocks;
	RCC_GetClocksFreq(&RCC_Clocks);

	//Set up the SysTick Timer
	SysTick_Config(RCC_Clocks.HCLK_Frequency / 100);

	//Configure the NVIC priority group to 1 bit pre-emption priority and 3 bit subpriority
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);

	//Say hello
	EnableDebugOutput(DEBUG_USART);
	printf("Hello, World\r\n");

	//Make use of the libc
	int* foo = malloc(0x100);
	printf("Allocated on heap: %p\r\n", foo);

	//You spin me right round, baby right round
	while(1);
}
