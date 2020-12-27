<img src="ErebusLogo.png" align="right" />

# Erebus

Erebus is a primordial deity, representing the personification of darkness. The repository contains assembly language projects.

## Rock, Paper & Scissors

This is a very simple console game for machines based on processors compatible with the Intel x86 (i386) architecture. The game is delivered for systems based on the Linux kernel.

To build and execute, use commands

``` bash
nasm -f elf -dOS_LINUX gRPS.asm     # Compile (Linux Kernel)
ld -m elf_i386 -s -o gRPS gRPS.o    # Link (i386)
sudo chmod +x gRPS                  # Change mode
./gRPS                              # Run
```
###### Build tools
- Free assembler compiler `nasm` for the Intel x86 architecture.
- Free executable file linker `ld`. 

###### License
I have made this game available for you under the [Apache License Version 2.0](https://www.apache.org/licenses/LICENSE-2.0.txt). Feel free to remix and re-share this game.