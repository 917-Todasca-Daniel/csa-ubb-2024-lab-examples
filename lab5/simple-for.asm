bits 32
global start        
extern exit             
import exit msvcrt.dll  

; TASK: compute the square of every element of an array
; and move the squares to another array
                          
segment data use32 class=data
    seq1   db   1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    length equ  $-seq1
    res1   resb length
    res2   resb length

segment code use32 class=code
    start:
        mov EAX, 0
        mov EDX, 0
        mov EBX, 0
        
        ; for (i=0; i<n; i++)
        ;   DO_STUFF

        ; mov ECX, n
        ; jecxz loop_end
        ; loop_start:
        ;   DO_STUFF
        ; loop_end:

        ; using LOOP
        mov ESI, 0
        mov ECX, length                 ; ECX = n
        jecxz loop_end

        loop_start:
            mov AL, [seq1 + ESI]        ; DO_STUFF
            mul AL                      ; DO_STUFF 
            mov byte [res1 + ESI], AL   ; DO_STUFF

            inc ESI
        loop loop_start    ; dec ECX; cmp ECX, 0; jne 0;
        loop_end:

        ; re-written without LOOP
        mov ESI, 0
        mov ECX, length                 ; ECX = n
        jecxz loop_end_v2 

        loop_start_v2:
            mov AL, [seq1 + ESI]        ; DO_STUFF
            mul AL                      ; DO_STUFF
            mov byte [res2 + ESI], AL   ; DO_STUFF

            inc ESI

            dec ECX
            cmp ECX, 0
            jne loop_start_v2  ; OR i could have used jecxz
        loop_end_v2:

    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        