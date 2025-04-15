; move to diff file
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