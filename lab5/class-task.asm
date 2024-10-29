bits 32
global start        
extern exit             
import exit msvcrt.dll  

; TASK: Two character strings S1 and S2 are given. Obtain the string D which contains all the elements of S1 that do not appear in S2.
; S1: '+', '4', '2', 'a', '8', '4', 'X', '5'
; S2: 'a', '4', '5'
; D: '+', '2', '8', 'X'

; read for more efficient implementations: https://softwareengineering.stackexchange.com/questions/280361/list-comparing-techniques-for-faster-performance
                          
segment data use32 class=data
    ; no variables

segment code use32 class=code
    start:
        ; brute implementation
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        