bits 32
global start        
extern exit ; this is an external function
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; TASK: write a function for a+b
    a dd 15
    b dd 25
    
segment code use32 class=code
    ; CDECL says we use the stack to push arguments
    ; also a function can freely modify EAX, ECX, EDX
    
    ; int a_plus_b(int a, int b)
    a_plus_b:
        mov EAX, [ESP + 4] ; EAX = a
        mov ECX, [ESP + 8] ; ECX = b
        add EAX, ECX ; EAX = a + b
        ret
    
    ; this is the label where our program starts - we can write our functions before it, as they won't get executed until a CALL
    start:
        ; a_plus_b(a, b)
        push dword [b]
        push dword [a]
        call a_plus_b ; by CDECL, result is in EAX
        add ESP, 4 * 2
        ; the functions we define ourselves dont need the brackets: [a_plus_b]
        ; however, external functions ned it: call [exit]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    