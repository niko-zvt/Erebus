nasm -f elf -dOS_LINUX gRPS.asm     # Compile (Linux Kernel)
#nasm -f elf -dOS_FREEBSD gRPS.asm  # Compile (FreeBSD Kernel)

ld -m elf_i386 -s -o gRPS gRPS.o    # Link (i386)

sudo chmod +x gRPS                  # Change mode
