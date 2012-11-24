#ifndef _SYSTICK_H_
#define _SYSTICK_H_

/*! @addtogroup StartupLib
 * @{ */

/*! @addtogroup SysTick
    @brief SysTick is used to to implement a counter that is incremented all 10ms
 * @{ */

#ifdef __cplusplus
 extern "C" {
#endif

#include <stdint.h>

extern volatile uint32_t SysTickCounter;

/*!
 * @brief Holds exceution for a given time.
 *
 * Try to avoid using this.
 * @param time Time to hold in 10ms steps
 */
void Delay(uint32_t time);

#ifdef __cplusplus
}
#endif

/*! @} */
/*! @} */

#endif
