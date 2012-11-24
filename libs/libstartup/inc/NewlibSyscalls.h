#ifndef _NEWLIB_SYSCALLS_H_
#define _NEWLIB_SYSCALLS_H_

/*! @addtogroup StartupLib
 * @{ */

/*! @addtogroup NewlibSyscalls
 * @brief This header is used implement all necessary newlib stubs. There are dummy fopen functions supplied for FS I/O.
 * @{ */

#include <sys/stat.h>
#include <stddef.h>

#ifdef __cplusplus
 extern "C" {
#endif

//File operations
int _file_fstat(int fd, struct stat *st);
int _file_write(int fd, void *buf, size_t len);
int _error_write(int fd, void *buf, size_t len);
int _file_read(int fd, void *buf, size_t len);
off_t _file_lseek(int fd, off_t offset, int whence);
int _file_close(int fd);
int _file_isatty(int fd);
int _open(const char *name, int flags, int mode);

//Newlibs syscalls
int _fstat(int fd, struct stat *st);
int _lseek(int fd, int ptr, int dir);
int _read(int fd, char *ptr, int len);
int _close(int fd);
int _isatty(int fd);
int _write(int fd, char *ptr, int len);
caddr_t _sbrk(int incr);
void _exit(int code);

#ifdef __cplusplus
}
#endif

/*! @} */
/*! @} */

#endif
