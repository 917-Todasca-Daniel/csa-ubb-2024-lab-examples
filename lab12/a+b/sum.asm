bits 32                         
segment code use32 public class=code
    global _sum
    ; int sum(int a, int b)
    _sum:
        mov EAX, [ESP+4]
        mov ECX, [ESP+8]
        add EAX, ECX
        ret

