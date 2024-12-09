bits 32                         
segment code use32 public class=code
    global sum
    ; int sum(int a, int b)
    sum:
        mov EAX, [ESP+4]
        mov ECX, [ESP+8]
        add EAX, ECX
        ret

