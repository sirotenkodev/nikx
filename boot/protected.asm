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
    mov eax, 1                  ; Start load sector from disk(0 - boot sector) because we started from 1
    mov ecx, 100                ; Total of numbers sectors wich we load
    mov edi, 0x0100000          ; 1M where start our kernel(we load sectors from disk into 0x0100000)
    call load_lba_ata
    call start32