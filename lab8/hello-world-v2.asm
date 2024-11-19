bits 32
global start        
extern exit, printf
import exit msvcrt.dll    
import printf msvcrt.dll
                          
segment data use32 class=data
    hello_world db "Hola Mundo!", 10, "Hello World!", 0
    string_format db "%s", 0

segment code use32 class=code
    start:
        ; printf("%s", &hello_world)
        push hello_world
        push string_format
        call [printf]
        add ESP, 4 * 2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    