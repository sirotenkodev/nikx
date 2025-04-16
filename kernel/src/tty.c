#include  "../include/tty.h"
#include  "../../lib/kerneldef.h"

/* absolute address to video memory */
static uint16_t *vmem = 0;
static tty_dementiondef demention;

/*
    Initialize videomemory for output
    clear console
*/
void tty_init() {
    vmem = (uint16_t *)(0xb8000);
    demention.cols = 0;
    demention.rows = 0;

    for(int i = 0; i < VGA_HEIGHT; ++i) {
        for(int j = 0; j < VGA_WIDTH; ++j) {
            tty_putchar(j, i, ' ', 0);
        }
    }
}

/*
    Crete 0x from chars
    1) shift color << on 8 bits (For green 0x1f -> 0x1f00)
    2) or operation (A - 0x41), 0x1f00 | 0x41 -> 0x1f41 (Our need 0x int)
*/
uint16_t tty_make_char(char ch, char color) {
    return (color << 8) | ch;
}

/*
    Print char at terminal by X and Y coordinates
    Y - ROW
    X - COLUMN
*/
void tty_putchar(int x, int y, char ch, char color) {
    vmem[(y * VGA_WIDTH) + x] = tty_make_char(ch, color);
}

/*
    Print char at current position
*/
void tty_writechar(char ch, char color) {

    switch(ch) {
        case '\n':
            demention.cols = 0;
            demention.rows++;
            return;
        case '\t':
            demention.cols += 4;
            return;
        case '\r':
            demention.cols = 0;
            return;
    }

    tty_putchar(demention.cols, demention.rows, ch, color);
    demention.cols++;
    if(demention.cols >= VGA_WIDTH) {
        demention.cols = 0;
        demention.rows++;
    }
}

/*
    Print null terminated string
*/
void tty_print(const char *string) {
    size_t len = strlen(string);
    for(int i = 0 ; i < len; ++i) {
        tty_writechar(string[i], 2);
    }
}