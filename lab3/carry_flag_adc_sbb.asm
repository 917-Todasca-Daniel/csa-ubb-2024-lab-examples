bits 32
global start        
extern exit            
import exit msvcrt.dll 

; WHAT WE NEED TO KNOW ABOUT ADC AND SBB:
; * mostly used in combination with MUL instructions
; * helps us work with DX:AX or EDX:EAX
                       

segment data use32 class=data
    ; ...

segment code use32 class=code
    start:
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        
        ; instructions for manipulating CF
        CLC
        STC
        CMC
        
        ; basic usecase for adc and sbb: working with quadwords
        ; compute EDX:EAX + ECX:EBX
        add EAX, EBX
        adc EDX, ECX

        ; compute DX:AX + CX:BX
        add AX, BX
        adc DX, CX
        
        ; QUESTIONS:
        ; 1. what does this program do?
        mov EAX, 0
        adc EAX, 0
        
        ; QUESTION:
        ; 1. what does this program do?
        ; 2. rewrite this without ADC
        add AL, BL
        mov AH, 0
        adc AH, 0
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
