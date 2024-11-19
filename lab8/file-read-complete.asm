bits 32
global start        
extern exit, fopen, fread, printf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
                          
segment data use32 class=data
    ; TASK: how many times the character e appears in the file
    total_count dw 0
    file_path db "files/raven.txt", 0
    read_access_mode db "r", 0
    buffer resb 100
    count_read resb 1

    output_format db "Number of times lowercase 'e' appears is: %d", 0

segment code use32 class=code
    start:
        ; FILE* file = fopen("files/raven.txt", "r")
        push read_access_mode
        push file_path
        call [fopen]  ; EAX contains the file handler
        add ESP, 4 * 2
        mov EBX, EAX  ; moved the handler to EBX because EAX might get modified by other functions
        
        cmp EBX, 0    ; check if the file was opened correctly
        je skip_program ; basically FILE == NULL; cannot do anything more

        while_file_has_characters:
            ; fread(&buffer, 1, 100, &FILE) - read 100 bytes
            ; EAX will contain how many characters were read
            push EBX
            push dword 100
            push dword 1
            push buffer
            call [fread] ; EAX = how many characters were read
            add ESP, 4 * 4
            mov [count_read], AL ; save this to a variable

            mov ECX, EAX    ; we want to loop over every character read
            mov ESI, 0
            jecxz process_end
            process_characters_on_buffer:
                mov AL, [buffer + ESI] ; AL = buffer[i]
                cmp AL, 'e'
                jne skip_inc ; bufer[i] != 'e'
                    inc word [total_count]
                skip_inc:
                inc ESI
            loop process_characters_on_buffer
            process_end:

            cmp byte [count_read], 100
            jae while_file_has_characters
            
        ; fclose(FILE)
        push EBX
        call [fclose]
        add ESP, 4 * 1
        
        ; printf("Number of times lowercase 'e' appears is: %d", count_read)
        mov EAX, 0
        mov AX, [total_count]
        push EAX
        push output_format
        call [printf]
        add ESP, 4 * 2
        
        skip_program:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program    