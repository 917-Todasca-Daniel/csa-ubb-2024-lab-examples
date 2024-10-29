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
    s1 db '+', '4', '2', 'a', '8', '4', 'X', '5', 'X'
    len1 equ $-s1
    s2 db 'a', '4', '5'
    len2 equ $-s2
    
    d resb len1 ; '+', '2', '8', 'X', 'X'

segment code use32 class=code
    start:
        ; brute implementation
        mov ESI, 0
        mov EDI, 0
        mov ECX, len1
        jecxz for_loop_end
        for_loop_start:
            mov AL, [s1 + ESI]
            
            mov EDX, 0
            ; while (EDX < len2) {...}
            inner_while:
                cmp EDX, len2
                jge inner_while_end
                mov BL, [s2 + EDX]
                inc EDX
               
                cmp AL, BL
                je end_put_into_result  ; AL == BL   s1[i] == s2[j]
                jmp inner_while
            inner_while_end:
            
            mov byte [d+EDI], AL
            inc EDI
            end_put_into_result:
            
            inc ESI
        loop for_loop_start
        for_loop_end:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        