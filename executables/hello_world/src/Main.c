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

	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOF, ENABLE);
	GPIO_InitTypeDef  GPIO_InitStructure;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
	GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
	GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6 | GPIO_Pin_7 | GPIO_Pin_8 | GPIO_Pin_9;
	GPIO_Init(GPIOF, &GPIO_InitStructure);
	GPIO_SetBits(GPIOF, GPIO_Pin_6);

	//Say hello
	EnableDebugOutput(DEBUG_USART);
	DEBUG_MSG("Hello, World\r\n");

	//Make use of the libc
	int* foo = malloc(0x100);
	DEBUG_MSG("Allocated on heap: %p\r\n", foo);

	//You spin me right round, baby right round
	while(1)
		DEBUG_MSG("A");
}
