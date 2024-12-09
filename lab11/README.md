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