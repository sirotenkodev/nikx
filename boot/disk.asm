; https://wiki.osdev.org/ATA_read/write_sectors
load_lba_ata:
    mov ebx, eax
    ; Sent high 8 bits of eax
    shr eax, 24
    or  eax, 0xe0
    mov dx, 0x1f6
    out dx, al 

    ; Send total sector to read(witch setup in load32)
    mov eax, ecx
    mov dx, 0x1f2
    out dx, al
    ; Send 0-7 bits
    mov eax, ebx
    mov dx, 0x1f3
    out dx, al
    ; Send  8-15 bits
    mov dx, 0x1f4
    mov eax, ebx
    shr eax, 8
    out dx, al
    ; Send 16-23 bits
    mov dx, 0x1f5
    mov eax, ebx
    shr eax, 16
    out dx, al

    ; Command port
    mov dx, 0x1f7
    mov al, 0x20
    out dx, al

.next_sector:
    push ecx

.try_again:
    mov dx, 0x1f7
    in  al, dx
    test al, 8
    jz .try_again


    mov ecx, 256
    mov dx, 0x1f0
    rep insw
    pop ecx
    loop .next_sector
    ret
