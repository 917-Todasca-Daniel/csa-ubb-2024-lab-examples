# Links
- [Lab 11 theory](https://www.cs.ubbcluj.ro/~vancea/asc/en-lab11-teorie.php)
- [Lab 11 exercises](https://www.cs.ubbcluj.ro/~vancea/asc/en-lab11-exercitii.php)

## Running the examples
#### a+b
```
cd a+b
nasm -f obj main.asm
nasm -f obj sum.asm
alink main.obj sum.obj -oPE -subsys console -entry start
```
#### gcd
```
cd gcd
nasm -f obj main.asm
nasm -f obj gcd.asm
alink main.obj gcd.obj -oPE -subsys console -entry start
```
```
cd class-task
nasm -f obj main.asm ; nasm -f obj is_palindrome_date.asm ; alink main.obj is_palindrome_date.obj -oPE -subsys console -entry start ; .\main.exe
```
### Add nasm and alink to PATH
[Add to PATH](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/) the folder where you have nasm.exe and alink.exe, e.g. C:\Users\{USER_NAME}\Documents\ubb\ASM_tools\asm_tools\nasm.