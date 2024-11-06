bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; array of words
    input dw -10, 10, 3, -46
    len equ $-input
    ; move only the positive numbers to a new array
    positive_only resw len

segment code use32 class=code
    start:
        mov esi, input
        mov edi, positive_only
        mov ecx, len / 2
        ; if input is empty
        jecxz loop_end
        
        loop_start:
            lodsw           ; AX = [ESI], ESI += 2
            cmp AX, 0        
            jg add_to_array ; AX > 0 ? then jump to add_to_array
            jmp add_to_array_end ; else skip the next lines

            add_to_array:
                stosw       ; positive_only[EDI++] = AX
            add_to_array_end:
        loop loop_start
        loop_end:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        