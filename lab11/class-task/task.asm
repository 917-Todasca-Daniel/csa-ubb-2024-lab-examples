bits 32
global start        
extern exit, printf
import exit msvcrt.dll    
import printf msvcrt.dll
                          
segment data use32 class=data
    day   db 31
    month db 13
    year  db 2024

segment code use32 class=code
    start:
        ; check if this date is a palindrome in DD/MM/YYYY format
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    