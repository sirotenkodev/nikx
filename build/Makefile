all: run

boot.bin:
	cd ../boot && nasm boot.asm -f bin -o ../build/$@ && cd -

run: boot.bin
	qemu-system-i386 -fda $<
	make clean

clean:
	$(RM) *.bin *.o *.dis