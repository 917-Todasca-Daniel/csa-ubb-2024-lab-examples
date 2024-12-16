bits 32 ; assembling for the 32 bits architecture

segment code use32 public code
  global is_leap_year

  ; bool is_leap_year(int year)
  is_leap_year:
    mov edx, 0      
    mov eax, [esp+4]
    mov bx, 4
    div bx

    cmp dx, 0
    je div4
    jmp answer_invalid_date

    div4:
    mov edx, 0
    mov eax,[esp+4]
    mov bx, 100
    div bx
    cmp dx, 0
      jne answer_leap_year
      
    mov edx,0
    mov eax, [esp+4]
    mov bx, 400
    div bx  
    cmp dx, 0
    je answer_leap_year
    jmp answer_invalid_date

    answer_leap_year:
      mov eax, 1
      ret        

    answer_invalid_date:
      mov eax, 0
      ret
