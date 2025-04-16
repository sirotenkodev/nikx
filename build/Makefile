FILES = kernel.asm.o kernel.o
INCLUDES = -I ../kernel/src
FLAGS = -g -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-cpp -Wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc

all: run

kernel.bin: $(FILES)
	i686-elf-ld -g -relocatable $(FILES) -o kernelfull.o
	i686-elf-gcc -T linker.ld -o ../iso/kernel.bin $(FLAGS)  kernelfull.o

boot.bin:
	cd ../boot && nasm boot.asm -f bin -o ../build/$@ && cd -
	mkdir -p ../iso && mv boot.bin ../iso/boot.bin

kernel.o:
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c ../kernel/src/kernel.c -o ../build/kernel.o

kernel.asm.o: 
	cd ../kernel && nasm -f elf -g kernel.asm -o ../build/kernel.asm.o && cd -

os.bin: boot.bin kernel.bin
	rm -rf ../iso/os.bin
	dd if=../iso/boot.bin >> ../iso/os.bin
	dd if=../iso/kernel.bin >> ../iso/os.bin
	dd if=/dev/zero bs=512 count=100 >> ../iso/os.bin

run: os.bin
	qemu-system-i386 -hda ../iso/$<
	make clean

clean:
	$(RM) *.bin *.o *.dis ../iso/boot.bin ../iso/kernel.bin