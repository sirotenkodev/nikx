[bits 16]
[org 0]

_start:
    jmp short start
    nop                                        ; No operation  (we need first 3 bytes)    
                                               ; https://wiki.osdev.org/FAT#Boot_Record
times 33 db 0                                  ; First 33 bytes after short jump(needs for bios)

start:      ; That move just for correct offest out offset while bootload
    jmp 0x7c0:run                              ; Change code segment to 0x7c0(because our code start from 0)

run:
    cli                                        ; Diable and clear interrups
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax                                 ; Set up our stack from 0x7c00 -> 0x00 (stack grow down)
    mov sp, 0x7c00
    sti                                        ; Turn on interrups
    mov si, message
    call print

    jmp $

%include "print.asm"

message: db 'Hello, nikxos', 0
times 510 - ($ - $$) db 0               ; minimum 510 bytes set 0

; Shows that this is boot sector
dw 0xaa55