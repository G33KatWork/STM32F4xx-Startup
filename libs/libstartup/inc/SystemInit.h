#ifndef __SYSTEM_STM32F4XX_H
#define __SYSTEM_STM32F4XX_H

#ifdef __cplusplus
 extern "C" {
#endif

extern uint32_t SystemCoreClock;

extern void SystemInit(void);
extern void SystemCoreClockUpdate(void);

#ifdef __cplusplus
}
#endif

#endif
