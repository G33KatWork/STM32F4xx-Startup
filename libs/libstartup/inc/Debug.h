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

void EnableDebugOutput(DebugDevice device);
void DebugPrintChar(char c);

#ifdef DEBUG

#ifdef DEBUG_NO_FLOAT_PRINTF
#define DEBUG_MSG(...)	iprintf(__VA_ARGS__)
#define ERROR_MSG(...)	fiprintf(stderr, __VA_ARGS__)
#else
#define DEBUG_MSG(...)	printf(__VA_ARGS__)
#define ERROR_MSG(...)	fprintf(stderr, __VA_ARGS__)
#endif

#else

#define DEBUG_MSG(...)
#define ERROR_MSG(...)

#endif

#ifdef __cplusplus
}
#endif

#endif
