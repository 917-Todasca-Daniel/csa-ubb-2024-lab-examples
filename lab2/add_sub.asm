bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sum db 0

; our code starts here
segment code use32 class=code
    start:
        ; good practice: always clean your registers!
        mov EAX, 0
        mov ECX, 0
        
        ; all 5 possible types of instructions
        add AL, BL
        add AL, [sum]
        add AL, 0
        add [sum], BL
        add byte [sum], 0
        
        ; TASK: calculate 250 + 150
        ; using word-sized registers
        mov AX, 250
        mov CX, 150
        add AX, CX
        
        ; using byte-sized registers
        mov AL, 250
        mov CL, 150
        add AL, CL        
    
        ; TASK: calculate 1+2+..5 into the variable sum
        mov byte [sum], 0
        add byte [sum], 1
        add byte [sum], 2
        add byte [sum], 3
        add byte [sum], 4
    
        ; observe the difference between using constants and registers - the byte keyword
        mov AL, 5
        add [sum], AL
            ; note: not recommended to use registers when not needed at all
            ; don't take the example above as a good practice!
        
        sub [sum], AL
        add byte [sum], 5
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
