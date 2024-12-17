bits 32             

extern is_leap_year        

segment code use32 public code
    global is_valid_date

    ; is_valid_date(day, month, year)
    ; return 1 for TRUE and 0 for FALSE
    is_valid_date:
        mov EAX, [ESP+4]  ; EAX = day
        mov ECX, [ESP+8]   ; ECX = month
        mov EDX, [ESP+12]   ; EDX = year

        cmp EDX, 0
        jle .invalid_date

        cmp ECX, 0
        jle .invalid_date
        cmp ECX, 12
        jg .invalid_date

        cmp ECX, 2
        je .check_feb

        cmp ECX, 1
        je .check_non_feb_31
        cmp ECX, 3
        je .check_non_feb_31
        cmp ECX, 5
        je .check_non_feb_31
        cmp ECX, 7
        je .check_non_feb_31
        cmp ECX, 8
        je .check_non_feb_31
        cmp ECX, 10
        je .check_non_feb_31
        cmp ECX, 12
        je .check_non_feb_31

        jmp .check_non_feb_30

        .check_non_feb_31:
            cmp EAX, 0
            jle .invalid_date
            cmp EAX, 31
            jg .invalid_date
            jmp .valid_date
        .check_non_feb_30:
            cmp EAX, 0
            jle .invalid_date
            cmp EAX, 30
            jg .invalid_date
            jmp .valid_date
        .check_feb:
            cmp EAX, 0
            jle .invalid_date

            mov EDX, [ESP+12]   ; EDX = year
            push EDX
            call is_leap_year
            cmp EAX, 0
            je .not_leap_year
            cmp EAX, 29
            jg .invalid_date
            jmp .valid_date

            .not_leap_year:
            cmp EAX, 28
            jg .invalid_date
            jmp .valid_date

        .valid_date:
        mov EAX, 1
        ret

        .invalid_date:
        mov EAX, 0
        ret

