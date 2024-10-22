segment data use32 class=data
    a dw -1
    B resd 1

; our code starts here
segment code use32 class=code
    start:
        ; 1.Given the words A and B, compute the doubleword C as follows:
        ; the bits 0-3 of B have the value 0
        ; the bits 4-7 of B are the same as the bits 8-11 of A
        ; the bits 8-9 and 10-11 of B are the invert of the bits 0-1 of A (so 2 times)
        ; the bits 12-15 of B have the value 1
        ; the bits 16-31 of B are the same as the bits 0-15 of B

        ; proposed strategy: build every partial task in EBX and add them together in EAX
        
        ; the bits 0-3 of B have the value 0
        mov EAX, 0
        
        ; the bits 4-7 of B are the same as the bits 8-11 of A
        mov EBX, 0
        mov BX, [a]             
        and BX, 0000_1111_0000_0000b ; get bits 8-11 from a
        shr BX, 4                    ; move those bits to positions 4-7
        
        or EAX, EBX                  ; move the bits to the result
        
        ; the bits 8-9 and 10-11 of B are the invert of the bits 0-1 of A (so 2 times)
        mov EBX, 0
        mov BX, [a]
        and BX, 011b                 ; bits 0-1 of A
        xor BX, 011b                 ; we can use XOR to invert bits!
        shl BX, 8                    ; move to positions 8-9
        or EAX, EBX                  ; move the bits into the result
        shl BX, 2                    ; move the bits to positions 10-11
        or EAX, EBX                  ; move the bits into the result
        
        ; the bits 12-15 of B have the value 1
        mov EBX, 0
        mov EBX, 1111_0000_0000_0000b
        or EAX, EBX                  ; could have been simplified, but keeping the initial strategy
        
        ; the bits 16-31 of B are the same as the bits 0-15 of B
        ; so we need to double everything here
        mov EBX, EAX
        shl EBX, 16
        or EAX, EBX
        
        mov [B], EAX

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program