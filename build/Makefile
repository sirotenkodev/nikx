all: run

kernel.bin: kernel.asm.o
	i686-elf-ld -g -relocatable kernel.asm.o -o kernelfull.o
	i686-elf-gcc -T linker.ld -o ../iso/kernel.bin -ffreestanding -O0 -nostdlib kernelfull.o

boot.bin:
	cd ../boot && nasm boot.asm -f bin -o ../build/$@ && cd -
	mkdir -p ../iso && mv boot.bin ../iso/boot.bin

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