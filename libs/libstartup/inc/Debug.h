#ifndef _DEBUG_H_
#define _DEBUG_H_

#include <stdint.h>

#ifdef __cplusplus
 extern "C" {
#endif

typedef enum {
	DEBUG_USART,
//	DEBUG_USB
} DebugDevice;

extern uint32_t DebugEnabled;

void EnableDebugOutput(DebugDevice device);
void DebugPrintChar(char c);

#ifdef __cplusplus
}
#endif

#endif
