FILES = kernel.asm.o kernel.o string.o tty.o 
INCLUDES = -I../kernel/include
FLAGS = -g -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-cpp -Wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc

all: run

kernel.bin: $(FILES)
	i686-elf-ld -g -relocatable $(FILES) -o kernelfull.o
	i686-elf-gcc -T linker.ld -o ../iso/kernel.bin $(FLAGS) kernelfull.o

boot.bin:
	cd ../boot && nasm boot.asm -f bin -o ../build/$@ && cd -
	mkdir -p ../iso && mv ../build/boot.bin ../iso/boot.bin

kernel.o: ../kernel/src/kernel.c
	i686-elf-gcc $(INCLUDES) -I../lib $(FLAGS) -std=gnu99 -c $< -o $@

tty.o: ../kernel/src/tty.c
	i686-elf-gcc $(INCLUDES) -I../lib $(FLAGS) -std=gnu99 -c $< -o $@

string.o: ../lib/string.c
	i686-elf-gcc $(INCLUDES) -I../lib $(FLAGS) -std=gnu99 -c $< -o $@

kernel.asm.o: ../kernel/kernel.asm
	cd ../kernel && nasm -f elf -g kernel.asm -o ../build/kernel.asm.o && cd -

os.bin: boot.bin kernel.bin
	rm -rf ../iso/os.bin
	dd if=../iso/boot.bin of=../iso/os.bin bs=512 conv=notrunc
	dd if=../iso/kernel.bin of=../iso/os.bin bs=512 seek=1 conv=notrunc
	dd if=/dev/zero bs=512 count=100 >> ../iso/os.bin

run: os.bin
	qemu-system-i386 -hda ../iso/os.bin
	make clean

clean:
	$(RM) ../build/*.o ../iso/boot.bin ../iso/kernel.bin

.PHONY: all clean run