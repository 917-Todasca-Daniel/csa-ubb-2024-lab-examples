bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; TASK: iterate over a dword list and count how many numbers are multiples of 7 or 17
    input dd 49, 32, 70, 0, -17, 2 ; 49, 70, 0, -17 
    len equ ($-input)/4
    counter db 0

segment code use32 class=code
    ; NOTE: usually we don't write functons in assembly using CALL/RET because a simple label with some jumps will usually be enough (CALL is not worth the hassle)
    
    ; bool is_multiple_of(int number, int divisor)
    ; EAX will return 1 or 0 for true or false
    is_multiple_of:
        ; CDECL says we can use EAX, ECX, EDX
        mov EAX, [ESP + 4]   ; EAX = number
        mov ECX, [ESP + 4*2] ; ECX = divisor
        cdq     ; EAX -> EDX:EAX
        idiv ECX ; EDX:EAX / ECX = EAX, remainder in EDX
        cmp EDX, 0
        je is_multiple
        jne is_not_multiple
        is_multiple:
            mov EAX, 1 ; return value
            jmp is_multiple_end
        is_not_multiple:
            mov EAX, 0 ; return value
        is_multiple_end:
        ret
            
    start:
        mov esi, input
        mov ecx, len
        jecxz loop_end
        loop_start:
            lodsd   ; EAX = input[i]
            mov EBX, EAX ; EBX is not modified by the function conform CDECL

            push ECX ; ECX might get overriden by our functon calls --- lets save it
            
            ; call is_multiple_of(input[i], 7)
            push dword 7
            push EBX
            call is_multiple_of ; EAX is either 1 or 0
            ; internal function doesnt need [] like call [is_multiple_of]
            add ESP, 4 * 2      ; good practice after every function call
            cmp EAX, 1
            je increase_counter
            
            ; call is_multiple_of(input[i], 17)
            push dword 17
            push EBX
            call is_multiple_of ; EAX is either 1 or 0
            ; internal function doesnt need [] like call [is_multiple_of]
            add ESP, 4 * 2      ; good practice after every function call
            cmp EAX, 1
            je increase_counter

            jmp increase_counter_end
            increase_counter:
                inc byte [counter]
            increase_counter_end:
            
            pop ECX ; let's restore ECX after all function calls
            
        loop loop_start
        loop_end:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    