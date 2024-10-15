bits 32
global start        
extern exit               
import exit msvcrt.dll    

; original task: https://www.geeksforgeeks.org/puzzle-3-calculate-total-distance-travelled-by-bee/
                          
segment data use32 class=data
    v1 db 10
    v2 db 15
    v3 db 30
    dist equ 50

    tdist resw 1

; our code starts here
segment code use32 class=code
    start:
        mov EAX, 0
        mov EDX, 0

        mov AL, [v1]
        add Al, [v2]

        mov DL, AL
        mov AX, dist

        div DL

        mul byte [v3]
        mov [tdist], AX

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program