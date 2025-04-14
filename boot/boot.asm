[bits 16]
[org 0x7c00]


start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

print:
    mov ah, 0x13
    mov al, 1
    mov bx, 0xa
    xor dx, dx 
    mov bp, MESSAGE
    mov cx, MESSAGE_LEN
    int 0x10

end:
    hlt
    jmp end

MESSAGE: db "Hello"
MESSAGE_LEN: equ $-MESSAGE


times (0x1be-($-$$)) db 0

db 80h
db 0,2,0
db 0f0h
db 0ffh,0ffh,0ffh
dd 1
dd (20*16*63-1) 

times (16*3) db 0

db 0x55
dd 0xaa