bits 32
global start        
extern exit            
import exit msvcrt.dll 
                       

segment data use32 class=data
    vard dd -1

segment code use32 class=code
    start:
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        
        ; basic usecase for the stack: convert DX:AX to EAX
        mov AX, -1
        mov BX, -1
        imul BX
        
                    ; ESP = EBP
        push DX     ; ESP = EBP - 2
        push AX     ; ESP = EBP - 4
        pop EAX     ; ESP = EBP        mov EAX, [ESP]
        
        ; we can also do de reverse!
        mov EBX, -1
        push EBX
        pop AX
        pop DX
        
        ; pushing the value of a variable: possible
        push dword [vard]
        ; pushing the value of an address: possible
        push vard
        ; pushing a 32-bit constant: possible
        push dword 0
        ; pushing a 8-bit register: not possible
        ; push AL
        
        ; save and load ALL flags
        pushfd
        popfd
        
        ; save and load ALL 32-bits extended registers
        pushad 
        popad
        
        ; save and load ALL 16-bits registers
        pusha
        popa
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
