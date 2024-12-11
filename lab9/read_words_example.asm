bits 32 
global start        
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
extern scanf
extern printf
import scanf msvcrt.dll
import printf msvcrt.dll

; read words until the word "stop" is written

segment data use32 class=data
    format db "%s",0 
    buffer resb 100
    stop db "stop"
    count db 0
    output db "%d words were read", 0
; our code starts here
segment code use32 class=code
    start:
        while_loop:
            ; scanf("%s", format)
            push buffer
            push format
            call [scanf]
            add ESP, 4*2

            mov ESI, 0
            iterate_over_buffer:
                mov AL, [buffer + ESI]
                cmp AL, 0
                je iterate_stop ; means we iterated over the whole buffer
                cmp AL, [stop + ESI]
                jne iterate_stop
                inc ESI
                cmp ESI, 4
                jne while_loop_end
            iterate_stop:
            
            inc byte [count]
        jmp while_loop
        while_loop_end:

        mov EAX, 0
        mov AL, [count]

        push EAX
        push output
        call [printf] ; printf("%d words were read", count)
        add ESP, 4*2

        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
 
 