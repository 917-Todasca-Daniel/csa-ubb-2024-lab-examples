bits 32
global start        
extern exit, fprintf, fopen, fclose
import exit msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
                          
segment data use32 class=data
    ; TASK: write the first 100 fibonacci numbers in a text file, on separate lines
    no_fib equ 100
    fibo resd no_fib ; reserve space for the array

    num_on_newline db "%d", 10, 0
    write_access_mode db "w", 0
    file_path db "files/fibo-100.txt", 0

segment code use32 class=code
    start:
        mov ecx, no_fib
        jecxz stop_program

        mov dword [fibo + 0*4], 1 ; fibo[0] = 1
        dec ecx 
        jecxz loop_fibo_end

        mov dword [fibo + 1*4], 1 ; fibo[1] = 1
        dec ecx 
        jecxz loop_fibo_end

        mov ESI, 2
        loop_fibo: ; this will loop for n-2 times
            mov EAX, [fibo + ESI*4 - 8]
            add EAX, [fibo + ESI*4 - 4  ]
            mov [fibo + ESI*4], EAX
            inc ESI
        loop loop_fibo
        loop_fibo_end:

        ; open file
        ; fopen(&file_path, "w")
        push write_access_mode
        push file_path
        call [fopen] ; EAX = file handler
        add ESP, 4 * 2
        mov EBX, EAX ; keep handler in EBX
        
        cmp EBX, 0 ; check if we were able to succesfully create the file
        je stop_program ; something happened and we were unable to create the file
        
        mov ECX, no_fib ; here we know no_fib > 0
        mov ESI, 0
        print_fibo:
            ; note: calling the fprintf function might modify ECX!
            ; so we keep a copy of ECX on the stack
            push ECX

            ; fprintf(&FILE, "%d\n", fibo[i])
            push dword [fibo + ESI * 4]
            push num_on_newline
            push EBX ; the file handler
            call [fprintf]
            add ESP, 4 * 3

            pop ECX
            inc ESI
        loop print_fibo

        ; close file
        ; fclose(&FILE)
        push EBX 
        call [fclose]
        add ESP, 4 * 1

        stop_program:
        ; note: fibonacci numbers will start overflowing after 46th

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    