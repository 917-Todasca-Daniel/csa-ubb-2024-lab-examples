bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    

segment code use32 class=code
    ; int fib(int n)
    ; as reminders:
        ; fib(0) = 1
        ; fib(1) = 1
        ; fib(n) = fib(n-1) + fib(n-2)
    fib:
        ; CDECL says we can use EAX, ECX, EDX
        mov ECX, [ESP + 4] ; ECX = n
        cmp ECX, 1
        jg continue_fib ; n > 1
        
        ; else return 1
            mov EAX, 1
            ret 
        
        continue_fib:
            push ECX ; keep a copy of ECX on the stack
            
            dec ECX  ; ECX = n-1
            push ECX
            call fib ; EAX = fib(n-1)
            add ESP, 4 * 1
            pop ECX  ; ECX = n
            push EAX ; >>>> save fib(n-1) on the stack
            
            sub ECX, 2 ; ECX = n-2
            push ECX 
            call fib ; EAX = fib(n-2)
            add ESP, 4 * 1
            pop EDX  ; >>> restore here EDX = fib(n-1)
            add EAX, EDX ; EAX = fib(n-2) + fib(n-1)
        
            ret
            
    start:
        push dword 10
        call fib ; EAX = fib(10)
        ; internal function doesnt need [] like call [fib]
        add ESP, 4 * 1
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    