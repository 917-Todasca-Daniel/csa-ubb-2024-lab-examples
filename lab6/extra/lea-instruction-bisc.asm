bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; this examples shows how we can use LEA for our convenience in doing simple computations
    ; works hand in hand with the 4AM formula (BISC)
    ; based + index << scale + constant
    a dw 10

segment code use32 class=code
    start:
        ; compute 5*a + 2
        mov BX, [a]
        mov AX, 5
        mul AX
        add AX, 2
        adc DX, 0
        ; result is in DX:AX

        ; using LEA
        mov BX, [a]
        ; cast BX to EBX - unsigned
        and EBX, 0xFFFFh
        ; if we wanted the signed version, we would have to use cwde
        mov EAX, [EBX * 5 + 2]
        ; result is in EAX
        
        ; EBX * 5 + 2 = EBX + EBX * 4 + 2
            ; base - EBX
            ; index - EBX
            ; scale = 2^2
            ; constant = 2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        