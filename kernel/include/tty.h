#ifndef     TTY_H
#define     TTY_H

#include <stdint.h>
#include <stddef.h>

#include "../../lib/string.h"

void tty_init();
uint16_t tty_make_char(char ch, char color);
void tty_putchar(int x, int y, char ch, char color);
void tty_writechar(char ch, char color);
void tty_print(const char *string);

#endif //   TTY_H