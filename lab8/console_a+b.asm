bits 32
global start        
extern exit, printf, scanf    
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
                          
segment data use32 class=data
    a_label db "a = ", 0
    a resd 1
    b_label db "b = ", 0
    b resd 1
    output_label db "a + b = %d", 0
    c resd 1

    ; %d is used for ints - dwords only!
    int_format db "%d"

segment code use32 class=code
    start:
        ; for more format specifiers: https://cplusplus.com/reference/cstdio/printf/
        ; https://cplusplus.com/reference/cstdio/scanf/
        
        ; in C:
            ; printf("a = ");
            ; scanf("%d", &a);
            ; printf("b = ");
            ; scanf("%d", &b);
            ; printf("a + b = %d", a+b)
        
        ; printf("a = ")
        push a_label
        call [printf]   ; external function needs []
        add ESP, 4 * 1
        
        ; scanf("%d", &a) --- because &a, we want the address of a 
        push a          ; so we push the address
        push int_format 
        call [scanf]    ; external function needs []
        add ESP, 4 * 2
        
        ; printf("b = ")
        push b_label
        call [printf]
        add ESP, 4 * 1

        ; scanf("%d", &b) --- because &b, we want the address of b
        push b         ; so we push the address
        push int_format 
        call [scanf]
        add ESP, 4 * 2

        mov EAX, [a]
        add EAX, [b]
        mov [c], EAX

        ; printf("a + b = %d", c)
        push dword [c]
        push output_label
        call [printf]
        add ESP, 4 * 2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    