bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, printf, fclose
import fopen msvcrt.dll  
import fread msvcrt.dll              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import printf  msvcrt.dll 
import fclose msvcrt.dll  ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
;A text file is given. Read the content of the file, determine the special character with the highest frequency and display the character along with its frequency on the screen. The name of text file is defined in the data segment
    normal db 'ABCDEabcde1234567890 '
    len equ $-normal
    frq times 256 db 0
    nr db 0
    text_file db 'text_file.txt', 0
    ; 400 caractere
    maxx db 0
    buffer resb 200
    r db 'r', 0
    printformat db 'character %c frequency %d', 0
    ;printf(printformat, c, maxx)
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;fopen('text_file.txt', 'r')
        push r 
        push text_file
        call [fopen]
        add ESP, 4*2
        mov EBX, EAX
        cmp EBX, 0
        je end_of_program
        
        
        
        
        ;fread(buffer, 1, 200, EBX)
        while_read:
        
        push EBX
        push dword 200
        push dword 1
        push buffer
        
        call [fread]
        
        
        
        add ESP, 4*4
        push EAX
        mov ECX, EAX
        
        mov EDX, 0
        jecxz while_read_end
        iterate_buffer:
        and EAX, 0
        mov al, [buffer + EDX]
        
        mov EDI, 0
        
        mov ESI, 1
        
        iterate_normal:
        cmp EDI, len
        je iterate_normal_end
        cmp al, [normal + EDI]
        jne skip
        and ESI, 0
        skip:
        inc EDI
        jmp iterate_normal
        
        
        iterate_normal_end:
        
        add [frq + EAX], ESI
        
        inc EDX
        loop iterate_buffer
        
        pop EAX
        cmp EAX, 200
        je while_read
        
        
        
        
        
        while_read_end:
        
        mov ECX, 256
        mov EAX, 0
        mov EDI, 0
        iter_freq:
        mov BL, [frq + EDI]
        cmp byte [maxx], BL
        jge skip1
        
        mov byte[maxx], BL
        mov EAX, EDI
        
        skip1:
        inc EDI
        loop iter_freq
        
        ;printf(printformat, c, maxx)
        and EDX, 0
        mov DL, [maxx]
        push EDX
        push eax
        push printformat
        
        call [printf]
        
        add ESP ,4*3
        
        push EBX
        call [fclose]
        add ESP, 4
        
        
        end_of_program:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
