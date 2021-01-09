;; ========================================================================================
;;
;; ASM game "Rock, Paper & Scissors" to the console using only.
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

;; Human starts the input the number of rounds
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
            PUTCHAR     10                                          ;; LF
            PRINT       "Your choice: "                             ;; Print the invitation to enter

;; Human starts the input the shape
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

;; Human chose paper as his shape
choiceP:    mov         eax,        [shapePaper]                    ;; Adding the right shape to the register EAX
            mov         [shapeR],   eax                             ;; Move shape from EAX to variable
            mov         eax,        1                               ;; Save Human choice to variable
            mov         [plrHuman], eax                             ;; Save Human choice to variable
            jmp         choicePC                                    ;; Continue game

;; Human chose scissors as his shape
choiceS:    mov         eax,        [shapeRightScissors]            ;; Adding the right shape to the register EAX
            mov         [shapeR],   eax                             ;; Move shape from EAX to variable
            mov         eax,        2                               ;; Save Human choice to variable
            mov         [plrHuman], eax                             ;; Save Human choice to variable
            jmp         choicePC                                    ;; Continue game

;; Human chose rock as his shape
choiceR:    mov         eax,        [shapeRightRock]                ;; Adding the right shape to the register EAX
            mov         [shapeR],   eax                             ;; Move shape from EAX to variable
            mov         eax,        3                               ;; Save Human choice to variable
            mov         [plrHuman], eax                             ;; Save Human choice to variable
            jmp         choicePC                                    ;; Continue game

            PUTCHAR     10                                          ;; LF

;; PC starts the input the shape            
choicePC:
            ;; Generate random number (PC choice)
            rdtsc                                                   ;; Quasirandom -> EDX:EAX
            xor         edx,        edx                             ;; Required because there's no division of EAX solely
            mov         ecx,        2 - 0 + 1                       ;; 3 possible values [1, 2, 3]
            div         ecx                                         ;; EDX:EAX / ECX --> EAX quotient, EDX remainder
            mov         eax,        edx                             ;; Number -> EAX = [0, 2]
            add         eax,        1                               ;; Shift -> EAX = [1, 3]
            mov         [plrPC],    eax                             ;; Save PC choice to variable

            ;; In the game, there are 3 situations where a person has chosen Scissors, Paper or Rock
            mov         edx,        2                               ;; Scissors ID -> EDX
            cmp         edx,        [plrHuman]                      ;; If EDX == [plrHuman]
            je          situationS                                  ;; If Human use Scissors - jump to lable "situationS"  
            jg          situationP                                  ;; If Human use Paper - jump to lable "situationP" 
            jl          situationR                                  ;; If Human use Rock - jump to lable "situationR" 
            
            ;; Let's hope it doesn't come to that
            jmp         checkLoop                                   ;; Jump to label "checkLoop"

;; Handling a situation where the user has selected a Scissors
situationS: mov         edx,        2                               ;; Scissors ID -> EDX            
            cmp         edx,        [plrPC]                         ;; If EDX == [plrPC]

            ;; Draw
            mov         ebx,        [shapeLeftScissors]             ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable
            je          draw                                        ;; Draw, EDX == [plrPC]       

            ;; Human Fail
            mov         ebx,        [shapeLeftRock]                 ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable     
            jg          fail                                        ;; Human Fail, EDX < [plrPC]

            ;; Human Win
            mov         ebx,        [shapePaper]                    ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable
            jl          win                                         ;; Human Win, EDX > [plcPC]

            ;; Let's hope it doesn't come to that
            jmp         checkLoop                                   ;; Jump to label "checkLoop"

;; Handling a situation where the user has selected a Paper
situationP: mov         edx,        2                               ;; Scissors ID -> EDX  
            cmp         edx,        [plrPC]                         ;; If EDX == [plrPC]

            ;; Human Fail
            mov         ebx,        [shapeLeftScissors]             ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable
            je          fail                                        ;; EDX == 2 == Scissors
                                                                    ;; [plrPC] == 2 == Scissors
                                                                    ;; [plrHuman] == 1 == Paper
                                                                    ;; Paper < Scissors

            ;; Draw
            mov         ebx,        [shapePaper]                    ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable
            jg          draw                                        ;; EDX == 2 == Scissors
                                                                    ;; [plrPC] == 1 == Paper
                                                                    ;; [plrHuman] == 1 == Paper
                                                                    ;; Paper == Paper
            ;; Human Win
            mov         ebx,        [shapeLeftRock]                 ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable
            jl          win                                         ;; EDX == 2 == Scissors
                                                                    ;; [plrPC] == 3 == Rock
                                                                    ;; [plrHuman] == 1 == Paper
                                                                    ;; Paper > Rock      

            ;; Let's hope it doesn't come to that
            jmp         checkLoop                                   ;; Else check loop

;; Handling a situation where the user has selected a Rock
situationR: mov         edx,        2                               ;; Scissors ID -> EDX  
            cmp         edx,        [plrPC]                         ;; If EDX == [plrPC]

            ;; Human win
            mov         ebx,        [shapeLeftScissors]             ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable
            je          win                                         ;; EDX == 2 == Scissors
                                                                    ;; [plrPC] == 2 == Scissors
                                                                    ;; [plrHuman] == 3 == Rock
                                                                    ;; Rock > Scissors

            ;; Human Fail
            mov         ebx,        [shapePaper]                    ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable
            jg          fail                                        ;; EDX == 2 == Scissors
                                                                    ;; [plrPC] == 1 == Paper
                                                                    ;; [plrHuman] == 3 == Rock
                                                                    ;; Rock < Paper

            ;; Draw
            mov         ebx,        [shapeLeftRock]                 ;; Adding the left shape to the register EBX
            mov         [shapeL],   ebx                             ;; Move shape from EBX to variable
            jl          draw                                        ;; EDX == 2 == Scissors
                                                                    ;; [plrPC] == 3 == Rock
                                                                    ;; [plrHuman] == 3 == Rock
                                                                    ;; Rock == Rock      

            ;; Let's hope it doesn't come to that
            jmp         checkLoop                                   ;; Else check loop

;; Play a draw
draw:       PRINTFIGS   shapeR,    shapeL                           ;; Printing selected shapes
            PRINT       "       - Play a DRAW!"                     ;; Printing a phrase
            mov         eax,        [numDraw]                       ;; Moving the number of draws to the register
            inc         eax                                         ;; Increase the value in the register by one
            mov         [numDraw],  eax                             ;; Moving the new number of draws to the variable
            jmp         checkLoop                                   ;; Jump to the loop check for the next iteration

;; Fail
fail:       PRINTFIGS   shapeR,    shapeL                           ;; Printing selected shapes
            PRINT       "       - You LOSE!"                        ;; Printing a phrase
            mov         eax,        [numLose]                       ;; Moving the number of fails to the register
            inc         eax                                         ;; Increase the value in the register by one
            mov         [numLose],  eax                             ;; Moving the new number of fails to the variable
            jmp         checkLoop                                   ;; Jump to the loop check for the next iteration

;; Win
win:        PRINTFIGS   shapeR,    shapeL                           ;; Printing selected shapes
            PRINT       "       - You WIN!"                         ;; Printing a phrase
            mov         eax,        [numWins]                       ;; Moving the number of wins to the register
            inc         eax                                         ;; Increase the value in the register by one
            mov         [numWins],  eax                             ;; Moving the new number of wins to the variable
            jmp         checkLoop                                   ;; Jump to the loop check for the next iteration

;; Checking the iterator of the number of steps
checkLoop:  PUTCHAR     10                                          ;; LF
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

;; Completing the process
terminate:  FINISH                                                  ;; Terminate process

;; ----------------------------------------------
;; Section BSS
;; ----------------------------------------------
section     .bss

numRnds:    resb        4                                           ;; Variable for storing the number of rounds
plrHuman:   resb        4                                           ;; Variable for storing the human player shape
plrPC:      resb        4                                           ;; Variable for storing the PC player shape
numWins:    resb        4                                           ;; Variable for storing the number of wins
numLose:    resb        4                                           ;; Variable for storing the number of losses
numDraw:    resb        4                                           ;; Variable for storing the number of draws
shapeR:     resb        4                                           ;; Variable for storing the right shape
shapeL:     resb        4                                           ;; Variable for storing the left shape

;; ----------------------------------------------
;; Section DATA
;; ----------------------------------------------
section     .data

shapeRightScissors:     db          "8<"                            ;;A string that represents the display of the right scissors
shapeLeftScissors:      db          ">8"                            ;;A string that represents the display of the left scissors
shapeRightRock:         db          "O "                            ;;A string that represents the display of the right rock
shapeLeftRock:          db          " O"                            ;;A string that represents the display of the left rock
shapePaper:             db          "##"                            ;;A string that represents the display of the paper
