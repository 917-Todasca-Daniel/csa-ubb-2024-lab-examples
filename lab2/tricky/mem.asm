bits 32
global start        
extern exit
import exit msvcrt.dll 

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; in assembly, you can have 3 types of operands: register, variables, constants

    ; this is how we can declare a variable
        ; 4 data types for variables:
        ; 1 byte = 8 bits
        ; 1 word = 2 bytes = 16 bits
        ; 1 dword = 4 bytes = 32 bits
        ; 1 qword = 8 bytes = 64 bits
    var_byte    db 10
    var_word    dw 10
    var_dword   dd 10
    var_qword   dq 10
    
    ; this is how we can declare a constant
    c_10        equ 10
    
    ; 2's complement: intepretation is different from representation
    ; observe all declarations are completely equivalent
    var_minus1  db -1
    var_plus255 db 255
    var_bin     db 0b11111111
    var_hex     db 0xFF
    
    ; observe how this quadword declaration is the same as the 4 declarations above
    var_q1      dq -1
    
    ; little endian: bytes are stored in reverse in memory! 
    var_qendian dq 0xABCDEFDD
    var_dendian dd 0xABCD
    
    ; other interesting types of declarations
    ; might find these in exam questions!   
    
    ; these 2 declarations are equivalent
    var_seq10           db 10, 10, 10, 10
    var_seq10_2 TIMES 4 db 10
    
    ; this will be equal to the 32-bit number of the ADDRESS (not the value of the variable!)
    var_address dw var_seq10    

; our code starts here
segment code use32 class=code
    start:
        ; we always clean the residue values of the registries before computing with them
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        
        ; EAX - 32 bits, AX - 16 bits, AH and AL - 8 bits
        ; AL range: [0, 255] or [-126, 125] depending on representation
        ; from 0x00 to 0xFF
        
        ; always dereference the values of the variables!
        mov AL,  [var_byte]
        mov AH,  [var_byte]
        mov AX,  [var_word]
        mov EAX, [var_dword]
        
        ; these 2 instructions are equivalent
        mov EAX, 0xABCD
        mov EBX, [var_dendian]
        
        ; 2's complement in action - representation is not the same as interpretation!
        mov AL, -1
        mov BL, 255
        mov CL, 0xFF
        mov DL, 0b11111111
        
        ; working with variables might get tricky
        mov [var_byte], AL
        mov byte [var_byte], 10
        mov byte [var_byte], c_10

        ; !!! observe this is also possible, but might bring hard to debug errors on your homework assignments:)
        ; EAX is the value of the 32-bits address
        mov EAX, var_dword

        ; !!! observe this is also logically wrong, but the program still runs - might also bring hard to debug errors
        ; EAX is not 10 but instead 0x10101010
        mov EAX, [var_byte]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
