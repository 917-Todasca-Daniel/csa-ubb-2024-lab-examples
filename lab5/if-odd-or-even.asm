bits 32
global start        
extern exit             
import exit msvcrt.dll  
                          
segment data use32 class=data
    v1  db 0xFF
    odd db 0

segment code use32 class=code
    start:
        mov EAX, 0
        mov EDX, 0
        mov EBX, 0
        
        ; rem = v1 % 2
        ; if (rem == 1)
        ;    odd = 1
        ; else
        ;    odd = 0

        ; using basic conditional jump instructions
        mov AL, [v1]
        mov BL, 2
        div BL
       
        cmp AH, 1
        jl is_even
        jmp is_odd
        
        is_even:
            mov byte [odd], 1
            jmp if_case_end
        is_odd:
            mov byte [odd], 0
        if_case_end:

        ; EASIER and faster code using TEST
        mov AL, [v1]
        test AL, 1
        jnz is_odd_test
        
        is_even_test:
            mov byte [odd], 1
            jmp if_case_test_end
        is_odd_test:
            mov byte [odd], 0
        if_case_test_end:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        