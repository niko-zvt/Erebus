;; ========================================================================================
;;
;; ASM game "Rock, Papper & Scissors" to the console using only.
;; Runs on 32-bit and 64-bit Linux only.
;;
;; Copyright (c) Nikolay V. Zhivotenko, 2020
;; niko.zvt@gmail.com
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

            ;; Entering the number of rounds
inputRnds:  PUTCHAR     10                                          ;; LF
            PRINT       "How many rounds do you want to play? "     ;; Macro for displaying a prompt to enter the number of rounds
            PRINT       "Please enter a number from 1 to 9: "       ;; Macro for displaying a prompt to enter the number of rounds
            GETCHAR                                                 ;; Macro for entering an ASCII character in the EAX register
            mov         [numRnds],  eax                             ;; Moving the entered character from EAX to a variable

            ;; Checking that the entered character is 'Q'
            mov         edx,        81                              ;; Moving 'Q' symbol to EDX
            cmp         edx,        [numRnds]                       ;; Comparing the number of rounds with 'Q'
            je          terminate                                   ;; If the entered character is 'Q', then go to the label "terminate"

            ;; Checking that the entered character is 'q'
            mov         edx,        113                             ;; Moving 'q' symbol to EDX
            cmp         edx,        [numRnds]                       ;; Comparing the number of rounds with 'q'
            je          terminate                                   ;; If the entered character is 'q', then go to the label "terminate"

            ;; Shift the entered character in the ASCII table
            sub         [numRnds],  dword   48                      ;; Shift the entered character in the ASCII table to get a digit

            ;; Checking that the entered character is less than 1
            mov         edx,        1                               ;; Moving 1 to EDX
            cmp         edx,        [numRnds]                       ;; Comparing the number of rounds with 1
            jg          inputRnds                                   ;; If the number of rounds is less than 1 then go to the label "inputRnds"

            ;; Checking that the entered character is more than 9
            mov         edx,        9                               ;; Moving 9 to EDX
            cmp         edx,        [numRnds]                       ;; Comparing the number of rounds with 9
            jl          inputRnds                                   ;; If the number of rounds is more than 9 then go to the label "inputRnds"

            mov         ecx,        0                               ;; Reset the ECX register, which will be the counter
            PUTCHAR     10                                          ;; LF

            ;; The main game loop
main_loop:  PRINT       "Main Loop"                                 ;; Print temp text "Main loop"
            PUTCHAR     10                                          ;; LF
            ;; TODO
            inc         ecx                                         ;; Increasing the value of the ECX register (counter) by one
            cmp         ecx,        [numRnds]                       ;; Comparing the counter with the number of rounds
            jl          main_loop                                   ;; If ECX < [numRnds] jump to "main_loop" lable
terminate:  FINISH                                                  ;; Else process terminate

;; ----------------------------------------------
;; Section BSS
;; ----------------------------------------------
section     .bss

numRnds:    resb        4                                           ;; Variable for storing the number of rounds
plrHuman:   resb        4                                           ;; Variable for storing the human player figure
plrCPU:     resb        4                                           ;; Variable for storing the CPU player figure
