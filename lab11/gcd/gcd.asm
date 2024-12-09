bits 32                         
segment code use32 public class=code
    global gcd
    ; int gcd(int a, int b)
    ; if (b == 0) return a
    ; return gcd(b, a%b)
    gcd:
        mov EAX, [ESP+4] ; EAX = a
        mov ECX, [ESP+8] ; ECX = b
        cmp ECX, 0
        jne .rec_call
        ret 

        .rec_call:
        cdq
        idiv ECX ; EDX = EDX:EAX % ECX
        ; gcd(b, EAX % ECX)
        push EDX
        push ECX
        call gcd 
        add ESP, 4*2
        ret

