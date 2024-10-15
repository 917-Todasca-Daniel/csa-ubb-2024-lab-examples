bits 32
global start        
extern exit            
import exit msvcrt.dll 
                       

segment data use32 class=data
    var_byte    db 10
    var_word    dw 10
    var_dword   dd 10
    var_qword   dq 10

segment code use32 class=code
    start:
        mov EAX, 0
        mov EBX, 0
        
        ; 4 signed conversion instructions
        cbw     ; byte to word:             AL is cast to AX
        cwd     ; word to dword:            AX is cast to DX:AX
        cwde    ; word to dword extended:   AX is cast to EAX
        cdq     ; dword to qword:           ?  is cast to ?
        
        ; QUESTION:
        ; 1. what does this program do?
        ; 2. what happens if instead of idiv i write div?
        mov AX, -1
        cwd
        mov BX, 1
        idiv BX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
