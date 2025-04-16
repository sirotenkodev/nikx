#include <stdint.h>

#include "../include/kernel.h"
#include "../include/tty.h"

void kmain(void) {
    uint16_t *vmem = (uint16_t *)(0xb8000); // absolute address to video memory
    vmem[0] = tty_make_char('B', 2);
    
}