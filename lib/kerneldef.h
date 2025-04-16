#ifndef     KERNELDEF_H
#define     KERNELDEF_H

#define VGA_HEIGHT  20
#define VGA_WIDTH   80

typedef struct {
    int rows;  
    int cols; 
} tty_dementiondef;

typedef enum {
    Black, 
    Blue, 
    Green,
    Cyan, 
    Red, 
    Magenta, 
    Brown, 
    LightGrey, 
    DarkGrey, 
    LightBlue, 
    LightGreen, 
    LightCyan, 
    LightRed, 
    LightMagenta, 
    LightBrown, 
    White
} TtyColors;

#endif //   KERNELDEF_H