bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; no variables

segment code use32 class=code
    start:
    
        ; TASK - move the value 0 into AX using a single line of code; bring as many examples
        
        mov AX, 0
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        