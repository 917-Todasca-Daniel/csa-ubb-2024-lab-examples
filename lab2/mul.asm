bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    var_b db 0

; our code starts here
segment code use32 class=code
    start:
        ; always clean your registers!
        mov EAX, 0
        mov ECX, 0
    
        ; 2 types of MUL:
            ; MUL <reg>
            ; MUL [byte] <variable>
        mul AL
        mul byte [var_b]
        
        ; byte * byte = word
        ; AX = AL * <operand>
        mov AL, 100
        mov byte [var_b], 100
        mul byte [var_b]
        
        mov AL, 100
        mul AL
        
        ; word * word = dword
        ; DX:AX = AX * <operand>
        mov AX, 1000
        mul AX
        
        ; dword * dword = qword
        ; EDX:EAX = EAX * <operand>
        mov EAX, 0x10000
        mov ECX, 0x111111
        mul ECX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
