[bits 16]
init32:
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or al, 1
    mov cr0, eax
    jmp CODE_SEG:load32


[bits 32]
load32:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    mov ebp, 0x00200000
    mov esp, ebp

    ; Enable a20 lines
    in al, 0x92
    or al, 2
    out 0x92, al
    call start32