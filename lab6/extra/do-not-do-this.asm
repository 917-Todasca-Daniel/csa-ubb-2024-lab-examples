bits 32
global start        
extern exit             
import exit msvcrt.dll  
                          
segment data use32 class=data
    ; no variables

segment code use32 class=code
    start:
        mov DX, 5
        mov AX, 5
        div DX     ; this is a runtime error
        ; because DX:AX / DX cannot fit inside AX
        ; as a general use, do not use EDX for divs
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        