bits 32
global start        
extern exit             
import exit msvcrt.dll  

; TASK: given a poem, extract the first line in a separate array
; result shouldn't contain the new line
                          
segment data use32 class=data
    poem db  "We've got five years, stuck on my eyes\Five years, what a surprise\We've got five years, my brain hurts a lot\Five years, that's all we've got"
    line resb 200

segment code use32 class=code
    start:
        mov EAX, 0
        mov EDX, 0
        mov EBX, 0
        
        ; while (CONDITION)
        ;   DO_STUFF

        ; loop_start:
        ;   if NOT CONDITION then jump to loop_end
        ;   DO_STUFF
        ;   jump to while_loop_begin_label
        ; loop_end:

        ; CONDITION here is character != '\'
        ; DO_STUFF is moving the character from the poem to the line

        mov ESI, 0
        find_first_new_line:
            mov AL, [poem + ESI]
            cmp AL, '\\'             ; if !CONDITION then jump to stop_loop_label
            je stop_loop             ; if !CONDITION then jump to stop_loop_label

            mov [line + ESI], AL     ; DO_STUFF

            inc ESI                  ; increase counter
            jmp find_first_new_line  ; jump to the beginning
        stop_loop:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        