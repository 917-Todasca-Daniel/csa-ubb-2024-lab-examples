bits 32
global start        
extern exit ; this is an external function
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; TASK: write a function for a+b
    a db 15
    b db 25
    
segment code use32 class=code
    ; CDECL says we use the stack to push arguments
    ; also a function can freely modify EAX, ECX, EDX
    
    ; this is the label where our program starts - we can write our functions before it, as they won't get executed until a CALL
    start:
    
        call a_plus_b ; by CDECL, result is in EAX
        ; the functions we define ourselves dont need the brackets: [a_plus_b]
        ; however, external functions ned it: call [exit]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    