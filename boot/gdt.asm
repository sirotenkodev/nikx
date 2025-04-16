; Fill gdt from tutorial https://wiki.osdev.org/GDT_Tutorial
gdt_start:                      ; For calculate
gdt_null:
    dd 0x0                      ; For limit storage
    dd 0x0                      ; For base storage

gdt_code:
    dw 0xffff                   ; Segment 0-15 offset https://wiki.osdev.org/Global_Descriptor_Table
    dw 0                        ; Base 0-15
    db 0                        ; Base 16-23
    db 0x9a                     ; Access byte
    db 11001111b                ; High and low 4 bit flags
    db 0                        ; Base 24-31

gdt_data:
    dw 0xffff                   ; Segment 0-15 offset https://wiki.osdev.org/Global_Descriptor_Table
    dw 0                        ; Base 0-15
    db 0                        ; Base 16-23
    db 0x92                     ; Access byte
    db 11001111b                ; High and low 4 bit flags
    db 0                        ; Base 24-31

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

