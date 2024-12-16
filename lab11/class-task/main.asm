bits 32
global start        
extern exit, printf, is_palindrome_date
import exit msvcrt.dll  
import printf msvcrt.dll 

segment data use32 class=data
  day   db 11 
  month db 11
  year  dw 1111
  print_str resb 4

segment code use32 class=code
  start:
    ; check if this date is a palindrome in DD/MM/YYYY format

    ; TASK: import the is_valid_date function
      ; (is_valid-date also uses is_leap_year)
    ; int is_leap_year(int day, int month, int year)
    ; return 1 if it is a valid date
    ; and 0 otherwise

    mov EAX, 0
    mov AL, [day]
    mov EBX, 0
    mov BL, [month]
    mov ECX, 0
    mov CX, [year]

    push ECX ; year
    push EBX ; month
    push EAX ; day
    call is_palindrome_date
    add ESP, 4*3

    cmp EAX, 0
    je .is_not_palindrome

    mov byte[print_str], 'Y'
    mov byte[print_str + 1], 'e'
    mov byte[print_str + 2], 's'

    jmp .over
    .is_not_palindrome:
        mov byte[print_str], 'N'
        mov byte[print_str + 1], 'o'
    .over:
    
    push print_str
    call [printf]
    add ESP, 4

    ; exit(0)
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program    