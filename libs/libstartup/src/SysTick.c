#include <SysTick.h>

volatile uint32_t SysTickCounter=0;

void Delay(uint32_t time)
{
	uint32_t end=SysTickCounter+time;
	while(SysTickCounter!=end);
}

void SysTick_Handler()
{
	SysTickCounter++;
}
