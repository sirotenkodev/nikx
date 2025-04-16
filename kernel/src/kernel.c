#include <stdint.h>

#include "../include/kernel.h"
#include "../include/tty.h"

void kmain(void) {
    tty_init();
    tty_print("hello, from C kernel \rB\n\tnikx os");
}