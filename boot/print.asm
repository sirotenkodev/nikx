[bits 16]
print:
    mov bx, 0
    mov ah, 0xe
.loop:
    mov al, [si]                               ; put current char from message
    cmp al, 0
    je .done
    call print_char
    inc si                                     ; move to the next char
    jmp .loop
.done:
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    ret

print_char:
    int 0x10
    ret


[bits 32]

VIDEO_MEMORY    equ 0xb8000
GREEN_ON_BLACK  equ 0x02

printf32:
    pusha
    mov edx, VIDEO_MEMORY
    
printf32_loop:
    mov al, [ebx]
    mov ah, GREEN_ON_BLACK
    cmp al, 0
    je printf32_done
    mov [edx + 80 * 12 * 2], ax
    add ebx, 1
    add edx, 2
    jmp printf32_loop

printf32_done:
    popa
    ret