bits 32
global start        
extern exit             
import exit msvcrt.dll    
                          
segment data use32 class=data
    ; A word string s is given. Build the byte string d such that each element d[i] contains:
    ; - the count of zeros in the word s[i], if s[i] is a negative number
    ; - the count of ones in the word s[i], if s[i] is a positive number
    s dw -22, 145, -48, 127 ; in binary: 1111111111101010, 10010001, 1111111111010000, 1111111
    len equ ($-s)/2
    result resb len

segment code use32 class=code
    start:
        ; in the homework, when you want to build the output result:
        ; please use stosb, stosw...

        ; when you want to iterate over your input:
        ; please use lodsb, lodsw...

        ; scasb and scasw are very situational, as comparing also increases the index...
        ; ... which is usually an unwanted result, except for searching elements in an array
		
		mov ESI, s
		mov EDI, result
		mov ECX, len
		
		for_loop:
			lodsw    ; AX = s[i]; i++
			
			; lets find the count of 1s in s[i] using rcl and save it in DL 
			mov DL, 0
			
			push ECX ; save ECX from the outer for loop
            push AX ; keep a copy of the number
	
			mov ECX, 16 ; 16 bits in the word s[i]
			count_1s:
				rcl AX, 1 ; this moves 1 bit from AX into CF
				adc DL, 0 ; add that bit to the bit count
			loop count_1s
			count_1s_stop:
			
			pop AX ; reset the number
			; if s[i] is a negative number, instead of count of 1s, we need count of 0s
			cmp AX, 0
			jge skip_flip
			; DL = 16 - DL
			neg DL
			add DL, 16
			skip_flip:
			
			mov AL, DL
			stosb ; put the counter into the result
			
			pop ECX  ; revert ECX for the outer loop
		loop for_loop
		for_loop_end:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program