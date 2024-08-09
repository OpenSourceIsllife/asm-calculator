nasm -f elf32 calculator.asm -o calculator.o
ld -m elf_i386 calculator.o -o calculator
./calculator
