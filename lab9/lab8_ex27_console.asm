; Petru Chetrari

bits 32 ; assembling for the 32 bits architecture
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
extern scanf
extern printf
import scanf msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    format db "%c",0 ; %
    the_character resb 1
    db 0
    the_string db "the fox jumps over the frog", 0
    end_string equ $
    print_format db "%c %d call_1",10,0
    print_format2 db "%s %d call_2",0
; our code starts here
segment code use32 class=code
    start:
        ; scanf(&format, &the_Character)
        push the_character
        push format
        call [scanf] 
        add ESP, 4*2         ; 2 variables of 4 bytes
        mov ECX, 0
        mov ESI, the_string
        mov DL, [the_character]
        start_while:
        lodsb ; into AL
        cmp AL, 0
        je fin
        cmp DL, AL
        jne next
        inc ECX
        next:
        jmp start_while

        ; exit(0)
        fin:
        mov EDX, 0
        mov DL, [the_character]
        ;push ECX
        ; printf("%c %d", the_character, occurences)
        push ECX
        push EDX
        push print_format
        call [printf]
        add ESP, 4*2

        pop ECX ; redundant
        ; printf("%s %d", the_character, occurences)0
        push ECX ;redundant
        push the_character
        push print_format2
        call [printf]
        add ESP, 4*3


        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
 
 