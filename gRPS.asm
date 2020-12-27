;; ========================================================================================
;;
;; ASM game "Rock, Papper & Scissors" to the console using only.
;; Runs on 32-bit and 64-bit Linux only.
;;
;; Copyright (c) Nikolay Zhivotenko, 2020
;;
;; I, the author, hereby grant everyone the right to use this file for any
;; purpose, in any manner, in it's original or modified form, provided that
;; modified versions are clearly marked as such AND the original author's
;; copyright notice is kept along with the other authors' copyright notices
;; as appropriate within the file.
;;
;; Only the file as such must retain the copyright notice. Programs created
;; using this file (e.g. binaries) don't need to have any mentions of the fact
;; this file was used to create them.
;; 
;; This file is provided as is, with absolutely NO WARRANTY, and this
;; statement must be taken literally: "NO" means "NO", period. Should
;; this needs additional clarifications, I'd like you to search Internet
;; for various types of warranty (e.g., implied, hidden, etc) and take
;; into account that you don't have them all.
;;
;; To assemble and run:
;;
;;      nasm -f elf -dOS_LINUX gRPS.asm 
;;      ld -m elf_i386 -s -o gRPS gRPS.o
;;      (sudo) chmode +x gRPS
;;      ./gRPS
;;
;; or
;;
;;      (sudo) bash Install.sh
;;      ./gRPS
;;
;; ========================================================================================

;; ----------------------------------------------
;; Directive for I/O macros
;; ----------------------------------------------
%include "gRPS_io.inc"                                  

;; ----------------------------------------------
;; Directive definition of a global label
;; ----------------------------------------------
global      _start                                           

;; ----------------------------------------------
;; Text section
;; ----------------------------------------------
section     .text

;; Entry point                                                 
_start:     PRINT       "Hello, *USERNAME*! "                       ;; Macro for displaying the greeting line
            PRINT       "This is a Rock, Paper & Scissors ASM game!";; Macro for displaying the greeting line
            PUTCHAR     10                                          ;; Macro for displaying a newline character (LF/0x0A/10)
            PUTCHAR     10                                          ;; LF
            PRINT       "How many rounds do you want to play? "     ;; Macro for displaying a prompt to enter the number of rounds
            PRINT       "Please enter a number from 1 to 9: "       ;; Macro for displaying a prompt to enter the number of rounds
            GETCHAR                                                 ;; Macro for entering an ASCII character in the EAX register
            ;; TODO                                                 ;; Checking digit input
            mov         [numRnds],  eax                             ;; Moving the entered character from EAX to a variable
            sub         [numRnds],  dword   48                      ;; Shift the entered character in the ASCII table to get a digit
            mov         ecx,        0                               ;; Reset the ECX register, which will be the counter
            PUTCHAR     10                                          ;; LF

;; The main game loop
main_loop:  PRINT       "Main Loop"                                 ;; Print temp text "Main loop"
            PUTCHAR     10                                          ;; LF
            ;; TODO
            inc         ecx                                         ;; Increasing the value of the ECX register (counter) by one
            cmp         ecx,        [numRnds]                       ;; Comparing the counter with the number of rounds
            jl          main_loop                                   ;; If ECX < [numRnds] jump to "main_loop" lable
            FINISH                                                  ;; Else process terminate

;; ----------------------------------------------
;; Section BSS
;; ----------------------------------------------
section     .bss

numRnds:    resb        4                                           ;; Variable for storing the number of rounds
plrHuman:   resb        4                                           ;; Variable for storing the human player figure
plrCPU:     resb        4                                           ;; Variable for storing the CPU player figure
