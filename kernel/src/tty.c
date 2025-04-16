#include  "../include/tty.h"

/* absolute address to video memory */
// static uint16_t *vmem = (uint16_t *)(0xb8000);

/*
    Crete 0x from chars
    1) shift color << on 8 bits (For green 0x1f -> 0x1f00)
    2) or operation (A - 0x41), 0x1f00 | 0x41 -> 0x1f41 (Our need 0x int)
*/
uint16_t tty_make_char(char ch, char color) {
    return (color << 8) | ch;
}