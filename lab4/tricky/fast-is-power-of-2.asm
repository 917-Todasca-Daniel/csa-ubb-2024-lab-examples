bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    vard dd 32
    var_result db "?AY!"

segment code use32 class=code
    start:
    
        ; task - check if [vard] is a power of 2
        ; 1, 2, 4, 8, 16 ... - powers of 2
        ; write 'YAY!' inside var_result if it is a power of 2, write 'NAY!' otherwise
        ; explanation: https://stackoverflow.com/questions/600293/how-to-check-if-a-number-is-a-power-of-2
        
        ; first, check if it is 0
        mov EAX, [vard]
        cmp EAX, 0
        je is_not_power_of_two
        
        ; n AND (n-1)
        mov EBX, EAX
        dec EBX
        and EAX, EBX
        
        cmp EAX, 0
        je is_power_of_two
        
        ; if/else case
        is_not_power_of_two:
            mov byte [varb], 'N'
            jmp end_if_case
        is_power_of_two:
            mov byte [varb], 'Y'
            jmp end_if_case
        end_if_case:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        