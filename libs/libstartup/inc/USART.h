#ifndef _USART_H_
#define _USART_H_

/*! @addtogroup StartupLib
 * @{ */

/*! @addtogroup USART
 * @brief Interface to the USART
 *
 * USART stands for "universal synchronous/asynchronous receiver/transmitter"
 * This is used to debug your code via a serial console. Do not use this directly, use printf() instead.
 * On your Computer do the following to communicate with your STM32
@verbatim
# start screen. the device may vary. ask or google for help.
$ screen /dev/ttyUSB0 115200

# to end the screen session:
^A
K
Y
@endverbatim
 * @{ */

#include <stdint.h>

/*!
 * @brief Initializes USART on PA2/PA3
 *
 * This is used to debug your code via a serial console
 */
void MyUSART_Init(void);

/*!
 * @brief Sends a C-String (e.g. a array of chars) via USART to the computer
 * @param s pointer to a string
 */
void USART_SendString(char* s);

/*!
 * @brief Sends a single char (e.g. a array of chars) via USART to the computer
 * @param c a char
 */
void USART_SendChar(char c);

/*!
 * @brief Receives a single char (e.g. a array of chars) via USART to the computer
 * @param c pointer to the receiving buffer
 */
uint8_t USART_ReceiveChar(char* c);

/*! @} */
/*! @} */

#endif
