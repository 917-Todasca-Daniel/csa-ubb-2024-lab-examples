bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; no variables

segment code use32 class=code
    start:
    
        ; for all instructions below, notice what happens with CF - it usually is the value of the last disappearing bit
        ; shl - shift logical left
        mov AL, 0F0h
        shl AL, 2
        mov AL, 0F0h << 2
        ; >> sample task: using SHL, multiply a number with 16
        ; shl EAX, ?
        
        ; shr - shift logical right
        mov AL, 0F0h
        shr AL, 2
        mov AL, 0F0h >> 2
        ; >> sample tash: using SHR, divide a number with 16
        ; shr AL, ? 
        
        ; sal - shift arithmetic left, the same as shl
        mov AL, 0F0h
        sal AL, 2
        
        ; sar - shift arithmetic right, signed variant of shr
        mov AL, 0F0h
        sar AL, 2
        mov AL, 00Ch
        sar AL, 2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        