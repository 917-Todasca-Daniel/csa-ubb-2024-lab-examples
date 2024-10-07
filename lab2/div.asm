bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

; our code starts here
segment code use32 class=code
    start:
        ; always clean your registers!
        mov EAX, 0
        mov ECX, 0
        
        ; word / byte = byte
        ; AX / <op> = AL, rest AH
        mov AX, 101
        mov CL, 10
        div CL
        
        ; dword / word = word
        ; DX:AX / <op> = AX, rest DX
        mov DX, 0
        mov AX, 10001
        mov CX, 10
        div CX
        
        ; qword / dword = dword
        ; EDX:EAX / <op> = EAX, rest EDX
        mov EDX, 0b1
        mov EAX, 0xFFFFFFFF
        mov ECX, 0b100
        div ECX
 
        ; error cases
        ; 1. division by 0
        mov ECX, 0
        div ECX
        
        ; 2. divide too large numbers
        mov EDX, -1
        mov EAX, -1
        mov ECX, 1
        div ECX
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
