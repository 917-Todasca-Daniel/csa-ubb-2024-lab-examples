bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; no variables

segment code use32 class=code
    start:
    
        ; AND operator
        mov EAX, 00FFh
        mov EBX, 5h
        and EAX, EBX
        ; AND instruction
        mov EAX, 00FFh & 5h
        
        ; >> sample task: using AND, compute a number from EAX using only the 3rd and 4th bit
        ; and EAX, ?
    
        ; OR operator vs OR instruction
        mov EAX, 01h
        mov EBX, 04h
        or EAX, EBX
        mov EAX, 001h | 4h
        
        ; >> sample task: using OR, set all bits to 1
        ; or EAX, ?
        
        ; NOT operator vs NOT instruction
        mov EAX, 0FFFFFFFDh
        not EAX
        mov EAX, ~0FFFFFFFDh
        
        ; XOR operator vs XOR instruction
        mov EAX, 05h
        mov EBX, 06h
        xor EAX, EBX
        mov EAX, 05h ^ 06h
        
        ; >> sample task: using XOR, set a register to 0
        ; xor EAX, ?
        
        ; virtual AND: does the AND instruction, without moving the result into the registers
        ; however, flags will be affected as if the instruction really took place
        mov EAX, 1
        test EAX, 1
        test EAX, -1
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        