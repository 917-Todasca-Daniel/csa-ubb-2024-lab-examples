bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; array of words
    input dw -10, 17, 3, 7, -5, -5
    len $-input
    ; find 2 adjacent equal numbers
    adjacent_equal resw 1

segment code use32 class=code
    start:

        mov esi, input      ; ESI points to the first element
        mov edi, input+2    ; EDI points to the second element
        mov ecx, len / 2
        ; if input is empty
        jecxz loop_end

        dec ecx
        jecxz loop_end ; if input is a single number array, we should also skip

        loop_start:
            cmpsw ; this compares input[i] with input[i+1], as well as increments the indexes
            je found_equal ; input[i] == input[i+1]
            jmp did_not_find_equal ; else skip the next lines

            found_equal:
                lodsw      ; loads the result into AX
                mov [adjacent_equal], ax
            did_not_find_equal:
        loop loop_start
        loop_end:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        