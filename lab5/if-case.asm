bits 32
global start        
extern exit             
import exit msvcrt.dll  
                          
segment data use32 class=data
    v1      db 0xFF
    v2      db 0x0F
    max     db 0
    min     db 0

segment code use32 class=code
    start:
        mov EAX, 0
        mov EDX, 0
        mov EBX, 0
        
        ; if (v1 > v2) 
        ;    max = v1
        ;    min = v2
        ; else
        ;    max = v2
        ;    min = v2

        ; SIGNED - numbers can be negative
        
        mov AL, [v1]
        mov BL, [v2]
        cmp AL, BL
        jg v1_signed_greater        ; if (v1 > v2)
        jmp v2_signed_greater       ; else 
        
        v1_signed_greater:
            mov byte [max], AL      ; max = v1
            mov byte [min], BL      ; min = v2
            jmp signed_if_end
        v2_signed_greater:
            mov byte [max], BL      ; max = v2
            mov byte [min], AL      ; min = v1
        signed_if_end:
       

        ; UNSIGNED - only positive numbers
        
        mov byte [max], 0
        mov byte [min], 0
        
        mov AL, [v1]
        mov BL, [v2]
        cmp AL, BL
        ja v1_unsigned_greater        ; if (v1 > v2)
        jmp v2_unsigned_greater       ; else 
        
        v1_unsigned_greater:
            mov byte [max], AL      ; max = v1
            mov byte [min], BL      ; min = v2
            jmp signed_if_end
        v2_unsigned_greater:
            mov byte [max], BL      ; max = v2
            mov byte [min], AL      ; min = v1
        unsigned_if_end:
        
        ; checking for equality - je
        ; if (v1 == v2)
        ;   EDX = -1
        cmp AL, BL
        jne values_not_equal
            mov EDX, -1 
        values_not_equal:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        