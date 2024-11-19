bits 32
global start        
extern exit, printf
import exit msvcrt.dll    
import printf msvcrt.dll
                          
segment data use32 class=data
    hello_world db "Hello World!", 10, "Hola Mundo!", 0

segment code use32 class=code
    start:
        ; printf(&hello_world)
        push hello_world
        call [printf]
        add ESP, 4 * 1
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    