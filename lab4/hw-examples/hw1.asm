bits 32 
global start        
extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    a dw 011001111b
    b dw 011110010101b
    c resd 1

; our code starts here
segment code use32 class=code
    start:
        ; 1.Given the words A and B, compute the doubleword C as follows:
        ; the bits 0-4 of C are the same as the bits 11-15 of A
        ; the bits 5-11 of C have the value 1
        ; the bits 12-15 of C are the same as the bits 8-11 of B
        ; the bits 16-31 of C are the same as the bits of A
        
        mov eax, 0
        mov ebx, 0
        mov ecx, 0

        ; proposed strategy: build everything in EAX and move it in later inside C
        
        ; the bits 0-4 of C are the same as the bits 11-15 of A
        mov ax, [a]
        and ax, 01111100000000000b  ; we get the bits 11-15 from A, but they need to be in positions 0-4
        rol ax, 5                   ; rotate to the left 5 times to move bits 11-15 of A to positions 0-4
                                    ; we could also shr 11 instead
                     
        ; the bits 5-11 of C have the value 1
        or ax, 0111111100000b       ; force-set the bits 5-11

        ; the bits 12-15 of C are the same as the bits 8-11 of B
        mov bx, [b]
        and bx, 0111100000000b      ; get bits 8-11 of B

        shl bx, 4                   ; move these bits to position 12-15
        or ax, bx                   ; so far, we have in AX half of the result for C (bits 0-15)

        ; the bits 16-31 of C are the same as the bits of A
        mov cx, [a]                 ; cx contains 16 bits from A
        shl ecx, 16                 ; shift them to move to positions 16-31
        or eax, ecx                 ; add what we have so far together

        mov [c], eax                ; move the result in memory

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program