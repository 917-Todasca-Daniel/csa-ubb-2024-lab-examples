bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; no variables

segment code use32 class=code
    start:
    
        ; for all instructions below, notice what happens with CF - it usually is the value of the last disappearing bit
        ; rol - rotate left
        mov AL, 11110000b
        rol AL, 2
        
        ; ror - rotate right
        mov AL, 11110000b
        rol AL, 2

        ; rcl - rotate with carry left (it's a rotate operation with a delay)
        stc 
        mov AL, 0001111b
        rcl AL, 2
        ; >> sample task - move the value of the highest bit of EAX into another register
        ; rcl EAX, 1
        ; mov EBX, 0
        ; adc EBX, 0
        
        ; rcr - rotate with carry right (it's a rotate operation with a delay)
        clc
        mov AL, 00001111b
        rcr AL, 2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        