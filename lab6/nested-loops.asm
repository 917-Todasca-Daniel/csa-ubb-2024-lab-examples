bits 32
global start        
extern exit, fprintf, fopen, fclose
import exit msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
                          
segment data use32 class=data
    ; TASK: for an array of length M and an array of length N, compute an array of length M * N
    ; with the sum of all pairs of numbers
    ; A: 2, 10
    ; B: 0, 3, 5
    ; C: 2, 5, 7, 10, 13, 15
    
    A db 2, 10
    len1 equ $-A
    B db 0, 3, 5
    len2 equ $-B
    C resb len1 * len2


segment code use32 class=code
    start:
        mov EDI, C
        mov ESI, A
        mov ECX, len1
        jecxz loop_through_A_end
        loop_through_A:
            lodsb ; AL = A[i]
            push ESI  ; keep a copy of ESI
            push ECX  ; and a copy of ECX
            mov BL, Al ; BL = A[i]

            mov ESI, B
            mov ECX, len2
            jecxz loop_through_B_end
            loop_through_B:
                lodsb ; AL = B[j]
                add AL, BL
                stosb ; put that into the result
            loop loop_through_B
            loop_through_B_end:
            
            pop ECX
            pop ESI
        loop loop_through_A
        loop_through_A_end:

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    