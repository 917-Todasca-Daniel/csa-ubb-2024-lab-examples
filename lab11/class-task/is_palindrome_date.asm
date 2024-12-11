bits 32

global is_palindrome_date
                          
segment data use32 class=data
    date_str resb 8

segment code use32 public class=code
    ; is_palindrome_date (int day, int month, int year) 
    is_palindrome_date:
        mov eax, [esp + 4] ; day
        mov bl, 10
        div bl
        mov [date_str], al 
        mov [date_str + 1], ah

        mov eax, [esp + 8]; month
        div bl
        mov [date_str + 2], al
        mov [date_str + 3], ah

        mov esi, 7
        mov ecx, 4
        mov eax, [esp + 12] ; year
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

        mov EAX, 0
        ret
        .is_palindrome:
        mov EAX, 1
        ret