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
            mov         eax,        0
            mov         [numWins],  eax                             ;; Initialize variable
            mov         [numLose],  eax                             ;; Initialize variable
            mov         [numDraw],  eax                             ;; Initialize variable

            ;; Entering the number of rounds
            PUTCHAR     10                                          ;; LF
            PRINT       "How many rounds do you want to play? "     ;; Macro for displaying a prompt to enter the number of rounds
            PRINT       "Please enter a number from 1 to 9: "       ;; Macro for displaying a prompt to enter the number of rounds
inputRnds:  GETCHAR                                                 ;; Macro for entering an ASCII character in the EAX register
            mov         [numRnds],  eax                             ;; Moving the entered character from EAX to a variable

            ;; Checking that the entered character is 'Q' or 'q'
            mov         edx,        81                              ;; Moving 'Q' symbol to EDX
            cmp         edx,        [numRnds]                       ;; Comparing the number of rounds with 'Q'
            je          terminate                                   ;; If the entered character is 'Q', then go to the label "terminate"
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

            PRINT       "Start!"                                    ;; Print text
            PUTCHAR     10                                          ;; LF

            ;; Print control keys
            PRINT       "Use    'R' or 'r' = Rock,"                 ;; Print text
            PUTCHAR     10                                          ;; LF
            PRINT       "       'P' or 'p' = Paper,"                ;; Print text
            PUTCHAR     10                                          ;; LF
            PRINT       "       'S' or 's' = Scissors."             ;; Print text
            PUTCHAR     10                                          ;; LF
            PRINT       "       'Q' or 'q' - To quit."              ;; Print text
            PUTCHAR     10                                          ;; LF

            ;; The main game loop 
main_loop:  push        ecx                                         ;; Save the counter in the stack

            ;; Input figure (Human choice)
            PUTCHAR     10                                          ;; LF
            PRINT       "Your choice: "                              ;; Print the invitation to enter
inputHuman: GETCHAR                                                 ;; Get human choice
            mov         [plrHuman],  eax                            ;; Moving the entered character from EAX to a variable

            ;; Checking that the entered character is 'P' or 'p'
            mov         edx,        80                              ;; Moving 'P' symbol to EDX
            cmp         edx,        [plrHuman]                      ;; Comparing the number of rounds with 'P'
            je          choiceP                                     ;; If the entered character is 'P', then go to the label "choiceP"
            mov         edx,        112                             ;; Moving 'P' symbol to EDX
            cmp         edx,        [plrHuman]                      ;; Comparing the number of rounds with 'P'
            je          choiceP                                     ;; If the entered character is 'p', then go to the label "choiceP"

            ;; Checking that the entered character is 'R' or 'r'
            mov         edx,        82                              ;; Moving 'R' symbol to EDX
            cmp         edx,        [plrHuman]                      ;; Comparing the number of rounds with 'R'
            je          choiceR                                     ;; If the entered character is 'R', then go to the label "choiceR"
            mov         edx,        114                             ;; Moving 'r' symbol to EDX
            cmp         edx,        [plrHuman]                      ;; Comparing the number of rounds with 'r'
            je          choiceR                                     ;; If the entered character is 'r', then go to the label "choiceR"

            ;; Checking that the entered character is 'S' or 's'
            mov         edx,        83                              ;; Moving 'S' symbol to EDX
            cmp         edx,        [plrHuman]                      ;; Comparing the number of rounds with 'S'
            je          choiceS                                     ;; If the entered character is 'S', then go to the label "choiceS"
            mov         edx,        115                             ;; Moving 's' symbol to EDX
            cmp         edx,        [plrHuman]                      ;; Comparing the number of rounds with 's'
            je          choiceS                                     ;; If the entered character is 's', then go to the label "choiceS"

            ;; Checking that the entered character is 'Q' or 'q'
            mov         edx,        81                              ;; Moving 'Q' symbol to EDX
            cmp         edx,        [plrHuman]                      ;; Comparing the number of rounds with 'Q'
            je          showStats                                   ;; If the entered character is 'Q', then go to the label "showStats"
            mov         edx,        113                             ;; Moving 'q' symbol to EDX
            cmp         edx,        [plrHuman]                      ;; Comparing the number of rounds with 'q'
            je          showStats                                   ;; If the entered character is 'q', then go to the label "showStats"

            jmp         inputHuman                                  ;; Otherwise, we always return to re-enter

choiceP:    mov         eax,        1                               ;; Save Human choice to variable
            mov         [plrHuman], eax                             ;; Save Human choice to variable
            jmp         choicePC                                    ;; Continue game

choiceS:    mov         eax,        2                               ;; Save Human choice to variable
            mov         [plrHuman], eax                             ;; Save Human choice to variable
            jmp         choicePC                                    ;; Continue game

choiceR:    mov         eax,        3                               ;; Save Human choice to variable
            mov         [plrHuman], eax                             ;; Save Human choice to variable
            jmp         choicePC                                    ;; Continue game

            ;; Continue game
choicePC:   PUTCHAR     10                                          ;; LF

            ;; Generate random number (PC choice)
            rdtsc                                                   ;; Quasirandom -> EDX:EAX
            xor         edx,        edx                             ;; Required because there's no division of EAX solely
            mov         ecx,        2 - 0 + 1                       ;; 3 possible values [1, 2, 3]
            div         ecx                                         ;; EDX:EAX / ECX --> EAX quotient, EDX remainder
            mov         eax,        edx                             ;; Number -> EAX = [0, 2]
            add         eax,        1                               ;; Shift -> EAX = [1, 3]
            mov         [plrPC],    eax                             ;; Save PC choice to variable

            ;; In the game, there are 2 situations where a person has chosen Scissors or something else
            mov         edx,        2                               ;; Scissors ID -> EDX
            cmp         edx,        [plrHuman]                      ;; If EDX == [plrHuman]
            je          situationA                                  ;; If Human use Scissors - jump to lable situationA                                      
            jmp         situationB                                  ;; If Human use Paper or Rock - jump to lable situationB

            ;; Handling a situation where the user has selected a Scissors
situationA: mov         eax,        2                               ;; Scissors ID -> EDX            
            cmp         edx,        [plrPC]                         ;; If EDX == [plrPC]
            je          draw                                        ;; Draw            
            jg          fail                                        ;; Human Fail
            jl          win                                         ;; Human Win
            jmp         continue

            ;; Handling a situation where the user has selected a Rock or Paper
situationB: PRINT       "TODO"
            jmp         continue

            ;; Play a draw
draw:       PRINT       "8< vs >8"
            PRINT       "       - Play a DRAW! (Scissors vs Scissors)"
            mov         eax,        [numDraw]
            inc         eax
            mov         [numDraw],  eax
            jmp         continue

            ;; Fail
fail:       PRINT       "8< vs 0 "
            PRINT       "       - You LOSE! (Scissors vs Rock)"
            mov         eax,        [numLose]
            inc         eax
            mov         [numLose],  eax
            jmp         continue

            ;; Win
win:        PRINT       "8< vs ##"
            PRINT       "       - You WIN! (Scissors vs Paper)"
            mov         eax,        [numWins]
            inc         eax
            mov         [numWins],  eax
            jmp         continue

continue:   PUTCHAR     10                                          ;; LF
            pop         ecx                                         ;; Load the counter from the stack
            inc         ecx                                         ;; Increasing the value of the ECX register (counter) by one
            cmp         ecx,        [numRnds]                       ;; Comparing the counter with the number of rounds
            jl          main_loop                                   ;; If ECX < [numRnds] jump to "main_loop" lable

            ;; Show statistics
showStats:  PUTCHAR     10                                          ;; LF
            PRINT       "Statistics:"                               ;; Print statistics text
            PUTCHAR     10                                          ;; LF
            PUTCHAR     10                                          ;; LF

            PRINT       "   You WINS: "                             ;; Print how many wins were there
            mov         eax,        [numWins]                       ;; Moving [numWins] to EAX
            add         eax,        48                              ;; Shift the entered character in the ASCII table to get a digit
            mov         [numWins],  eax                             ;; Moving EAX to [numWins]
            PUTCHAR     [numWins]                                   ;; Print how many wins were there
            PUTCHAR     10                                          ;; LF

            PRINT       "   You LOSE: "                             ;; Print how many losses were there
            mov         eax,        [numLose]                       ;; Moving [numLose] to EAX
            add         eax,        48                              ;; Shift the entered character in the ASCII table to get a digit
            mov         [numLose],  eax                             ;; Moving EAX to [numLose]
            PUTCHAR     [numLose]                                   ;; Print how many losses were there
            PUTCHAR     10                                          ;; LF

            PRINT       "   You play a DRAW: "                      ;; Print how many play a draw
            mov         eax,        [numDraw]                       ;; Moving [numDraw] to EAX
            add         eax,        48                              ;; Shift the entered character in the ASCII table to get a digit
            mov         [numDraw],  eax                             ;; Moving EAX to [numDraw]
            PUTCHAR     [numDraw]                                   ;; Print how many play a draw
            PUTCHAR     10                                          ;; LF
            PUTCHAR     10                                          ;; LF

terminate:  FINISH                                                  ;; Else process terminate

;; ----------------------------------------------
;; Section BSS
;; ----------------------------------------------
section     .bss

numRnds:    resb        4                                           ;; Variable for storing the number of rounds
plrHuman:   resb        4                                           ;; Variable for storing the human player figure
plrPC:      resb        4                                           ;; Variable for storing the PC player figure
numWins:    resb        4                                           ;; Variable for storing the number of wins
numLose:    resb        4                                           ;; Variable for storing the number of losses
numDraw:    resb        4                                           ;; Variable for storing the number of draws
