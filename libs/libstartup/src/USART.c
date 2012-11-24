#include <USART.h>

#include <stm32f4xx/stm32f4xx.h>

void MyUSART_Init()
{
	GPIO_InitTypeDef  GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	USART_ClockInitTypeDef USART_ClockInitStructure;

	//Enable GPIOA clock
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);

	//Enable USART2 clock
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART2, ENABLE);

	//Enable Alternate functions
	GPIO_PinAFConfig(GPIOA, GPIO_PinSource2, GPIO_AF_USART2);
	GPIO_PinAFConfig(GPIOA, GPIO_PinSource3, GPIO_AF_USART2);

	//PA2 = TX
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
	GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
	GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	//PA3 = RX
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_3;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	//Configure USART2 clocks
	USART_ClockStructInit(&USART_ClockInitStructure);
	USART_ClockInit(USART2, &USART_ClockInitStructure);

	// 9600 8n1, no flowcontrol
	USART_InitStructure.USART_BaudRate = 115200;
	USART_InitStructure.USART_WordLength = USART_WordLength_8b;
	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
	USART_InitStructure.USART_Parity = USART_Parity_No;
	USART_InitStructure.USART_StopBits = USART_StopBits_1;
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;

	USART_Init(USART2, &USART_InitStructure);
	USART_Cmd(USART2, ENABLE);

	//flush
	while(USART_GetFlagStatus(USART2, USART_FLAG_TC) == RESET);
}

void USART_SendString(char* s)
{
	while (*s)
	{
		USART_SendChar(*s);
		s++;
	}
}

void USART_SendChar(char c)
{
	USART_SendData(USART2, (uint16_t)c);
	while(USART_GetFlagStatus(USART2, USART_FLAG_TC) == RESET);
}

uint8_t USART_ReceiveChar(char* c)
{
	if(USART_GetFlagStatus(USART2, USART_FLAG_RXNE) == SET)
	{
		*c = (char)USART_ReceiveData(USART2);
		return 1;
	}
	else
		return 0;
}
