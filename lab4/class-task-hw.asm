bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; no variables

segment code use32 class=code
    start:
    
        ; TASK 18. Given the word A, compute the doubleword B as follows:
        ; the bits 0-3 of B have the value 0;
        ; the bits 4-7 of B are the same as the bits 8-11 of A
        ; the bits 8-9 and 10-11 of B are the invert of the bits 0-1 of A (so 2 times) ;
        ; the bits 12-15 of B have the value 1
        ; the bits 16-31 of B are the same as the bits 0-15 of B.
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        