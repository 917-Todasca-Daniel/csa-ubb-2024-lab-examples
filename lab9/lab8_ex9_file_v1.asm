bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern fopen, fread, fclose
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll

                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    text_file db "resource/file.txt", 0
    read_access_mode db "r", 0
    
    ; whatever is not a-zA-Z0-9, whitespace == special character
    normal_character db "abcdefghijklABCDEFGHIJK01234567890 "
    len equ $ - normal_character
    frequency times 256 db 0
    
    buffer resb 200
    
; A text file is given. Read the content of the file, determine the special character with the highest frequency and display the character along with its frequency on the screen. The name of text file is defined in the data segment.


; our code starts here
segment code use32 class=code
    start:
        ; OPEN the file
        ; EAX = fopen(text_file, read_access_mode)
        push read_access_mode
        push text_file
        call [fopen]   ; EAX = file handler
        add ESP, 4*2
        
        mov EBX, EAX
        cmp EBX, 0
        je fin
       
        ; READING/WRITING into the file
        ; EAX = fread(buffer, 1, 200, EBX)
        ; fread while there are still characters to read
        
        while_loop_read_file:
            push EBX
            push dword 200
            push dword 1
            push buffer
            call [fread]  ; EAX = the count of characters read 
            add ESP, 4*4
            
            push EAX 
            
            mov ECX, EAX
            mov ESI, buffer
            jecxz iterate_buffer_end
            iterate_buffer:
                mov EAX, 0
                lodsb ; AL - buffer[i]
                
                push ECX
                
                mov ECX, len
                mov EDX, 0
                mov EDI, 0
                nested_loop_special_characters:
                    push EBX
                    mov BL, [normal_character + EDX]
                    cmp AL , BL
                    jne skip_update
                    
                    mov EDI, 1
                    skip_update:
                    
                    inc EDX
                    pop EBX
                loop nested_loop_special_characters
                
                cmp EDI, 0
                jne is_a_normal_character
                ; frequency[AL]
                inc byte [frequency + EAX]
                
                is_a_normal_character:
                
                pop ECX
            loop iterate_buffer
            iterate_buffer_end:
        
            pop EAX ; EAX - contains the number of characters read
            ; EAX < 200
            cmp EAX, 200
            jl while_loop_read_file_end
            jmp while_loop_read_file
        while_loop_read_file_end:
        
        
        ; CLOSE the file
        ; fclose(EBX)
        push EBX
        call [fclose]
        add ESP, 4*1
    
        ; exit(0)
        
        fin:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
