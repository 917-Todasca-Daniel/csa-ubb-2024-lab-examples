bits 32

global _is_palindrome_date

; public keyword is important here! otherwise, the code will crash at runtime
segment data public data use32
    date_str resb 8
    ebx_copy resd 1

; the code in this module had to be changed to respect the CDECL convention
segment code use32 public class=code
    ; is_palindrome_date (int day, int month, int year) 
    _is_palindrome_date:
        mov eax, [esp + 4] ; day
        mov [ebx_copy], ebx ; use an aux variable to store up EBX
        mov bl, 10
        div bl
        mov [date_str], al 
        mov [date_str + 1], ah

        mov eax, [esp + 8]; month
        div bl
        mov [date_str + 2], al
        mov [date_str + 3], ah

        mov eax, [esp + 12] ; year
        ; use the stack to save ESI, EDI and restore them later (CDECL!)
        push esi
        push edi

        mov esi, 7
        mov ecx, 4
        mov bx, 10
        .loop_start:
            mov dx, 0
            div bx
            mov [date_str + esi], dl
            dec esi
        loop .loop_start

        mov esi, 0
        mov edi, 7
        .loop2_start:
            mov dl, [date_str + esi]
            cmp dl, [date_str + edi]
            jne .end_loop2
            inc esi
            dec edi
            cmp esi, edi
            jl .loop2_start
            jmp .is_palindrome 
        .end_loop2:
        
        ; restore non-volatile registers
        pop edi
        pop esi
        mov ebx, [ebx_copy]
        mov EAX, 0
        ret
        
        .is_palindrome:
        ; restore non-volatile registers
        pop edi
        pop esi
        mov ebx, [ebx_copy]
        mov EAX, 1
        ret
        