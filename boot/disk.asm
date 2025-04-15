print_disk:
    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov bx, buffer
    int 0x13
    jc error
    mov si, buffer
    call print
    ret

error:
    mov si, message_error
    call print
    jmp $


message_error: db 'Load error', 0