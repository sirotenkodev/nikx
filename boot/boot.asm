[bits 16]
[org 0x7c00]

start:
    mov ah, 0xe
    mov si, message
    call print
    jmp $

print:
    mov bx, 0
.loop:
    mov al, [si]
    cmp al, 0
    je .done
    call print_char
    inc si
    jmp .loop
.done:
    ret

print_char:
    int 0x10
    ret

message: db 'Hello, nikxos', 0
times 510 - ($ - $$) db 0               ; minimum 510 bytes set 0

; Shows that this is boot sector
db 0x55
db 0xaa