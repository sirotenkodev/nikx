all: run

boot.bin:
	cd ../boot && nasm boot.asm -f bin -o ../build/$@ && cd -
	mkdir -p ../iso && cp boot.bin ../iso/boot.bin
	

run: boot.bin
	qemu-system-i386 -hda $<
	make clean

clean:
	$(RM) *.bin *.o *.dis