bits 32
global start        
extern exit, printf
import exit msvcrt.dll    
import printf msvcrt.dll

extern sum
                          
segment data use32 class=data
    a dd 10
    b dd 20
    format db "%d + %d = %d", 0

segment code use32 class=code
    start:
        ; sum(a, b)
        push dword [b]
        push dword [a]
        call sum

        ; printf(&format, a, b, c)
        push EAX
        push dword [b]
        push dword [a]
        push format
        call [printf]
        add ESP, 4 * 4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    