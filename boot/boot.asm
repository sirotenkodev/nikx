[bits 16]
[org 0]

jmp 0x7c0:start                         ; Change code segment to 0x7c0(because our code start from 0)

start:      ; That move just for correct offest out offset while bootload
    cli                                 ; Diable and clear interrups
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax                          ; Set up our stack from 0x7c00 -> 0x00 (stack grow down)
    mov sp, 0x7c00
    sti                                 ; Turn on interrups
    mov ah, 0xe
    mov si, message
    call print
    jmp $

; move to diff file
print:
    mov bx, 0
.loop:
    mov al, [si]                        ; put current char from message
    cmp al, 0
    je .done
    call print_char
    inc si                              ; move to the next char
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