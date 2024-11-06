bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; this example shows the concept of SHORT addresses and why we might care about different kinds of addresses

segment code use32 class=code
    start:
        ; notice the loop instruction cannot handle this
        ; the different between loop_fail_end and loop_fail_start labels
        ; is too big (greater than 128)
        mov ecx, 5
        jecxz loop_fail_end
        loop_fail_start:
            mov AL, 10
            mul AL

            a1 resb 200

        loop loop_fail_start
        loop_fail_end:

        ; however, jump instruction works (it can handle SHORT and NEAR addresses)
        mov ecx, 5
        jecxz loop_success_end
        loop_success_start:
            mov AL, 10
            mul AL

            a2 resb 200
            
        dec ecx
        jecxz loop_success_end
        jmp loop_success_start
        loop_success_end:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        