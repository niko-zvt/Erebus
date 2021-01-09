# Rock, Paper & Scissors

This is a very simple console game for machines based on processors compatible with the Intel x86 (i386) architecture. The game is delivered for systems based on the Linux kernel.

To build and execute, use commands 

``` bash
nasm -f elf -dOS_LINUX gRPS.asm     # Compile (Linux Kernel)
ld -m elf_i386 -s -o gRPS gRPS.o    # Link (i386)
sudo chmod +x gRPS                  # Change mode
./gRPS                              # Run
```
or see `Install.sh`

### Build tools
- Free assembler compiler `nasm` for the Intel x86 architecture.
- Free executable file linker `ld`. 

### Remark about Windows Subsystem for Linux
You can compile, link, and execute this game under `Windows Subsystem for Linux`.
- It is important to know that WSL 1 doesn't support 32-bit ELF. It seems that since the UserVoice was raised, there is no progress - and will not be. 
- If you are a lucky owner of WSL 2 (or are ready to upgrade to the next version) you can execute the app. 

*If you are having problems updating the WSL version, be sure to read this [discussion on GitHub](https://github.com/microsoft/WSL/issues/5014), most likely you will solve your problem.*

### License
I have made this game available for you under the [Apache License Version 2.0](https://www.apache.org/licenses/LICENSE-2.0.txt). Feel free to remix and re-share this game.