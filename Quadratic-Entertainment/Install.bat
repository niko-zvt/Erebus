:: Not to output the respective command
@echo off

:: Clear screen
cls

:: Print info
echo Compiling...

:: Compile C part
start /b /w gcc -Wall program.c -o program.exe

:: Wait
pause