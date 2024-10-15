bits 32
global start        
extern exit            
import exit msvcrt.dll 
                       

segment data use32 class=data
    ; ...

segment code use32 class=code
    start:
        mov EAX, 0
        mov EBX, 0
    
        ; signed interpreation
        mov AL, -1
        mov BL, -1
        imul BL
        
        ; unsigned interpretation
        mov AL, -1
        mov BL, -1
        mul BL
        
        ; QUESTIONS:
        ; 1. what is the value of DX?
        mov AX, -1
        mov BX, 1
        imul BX
        
        ; QUESTIONS:
        ; 2. what is the value of EDX?
        mov EAX, -1
        mov EBX, 1
        imul EBX
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
