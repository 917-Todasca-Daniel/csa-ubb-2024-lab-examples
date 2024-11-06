bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; merge 2 sorted lists a and b given as input
    a dw -25, -10, 0, 0, 10, 100, 300
    len1 equ $-a
    b dw -30, 0, 1, 2, 3, 150
    len2 equ ($-b) / 2
    result resw len1 + len2
    ; in this example, result = -30, -25, -10, 0, 0, 0, 1, 2, 3, 10, 100, 150, 300

segment code use32 class=code
    start:
        mov ESI, a ; index for a
        mov EBX, 0 ; index for b
        mov EDI, result ; index for result

        ; while (i < len1 && j < len2)
        
        while_loop_start:
            ; fill in the condition here
            cmp ESI, a + len1
            je while_loop_end
            cmp EBX, len2
            je while_loop_end
            lodsw
            cmp ax, [b + ebx * 2]
            jge if_2_start
            if_1_start:
                stosw
                jmp if_end
            if_2_start:
                mov ax, [b + ebx * 2]
                stosw
                dec esi
                dec esi
                inc ebx
            if_end:
            jmp while_loop_start
            ; if (a[i] < b[j]) {
            ;   result[k] = a[i]
            ;   k ++; i ++;
            ; }
            ; else {
            ;   result[k] = b[j];
            ;   k ++; j ++;
            ; }

        while_loop_end:

        ; while (i < len1) { ... }
        while_loop_i:
            cmp esi, a + len1
            je while_loop_j
            movsw
            jmp while_loop_i
            
        ; while (j < len2) { ... }
        while_loop_j:
            cmp ebx, len2
            je while_end
            mov ax, [b + ebx * 2]
            stosw
            inc ebx
            jmp while_loop_j
        while_end:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    