# Links
- [Lab 12 theory](https://www.cs.ubbcluj.ro/~vancea/asc/en-lab12-teorie.php)
- [Lab 12 exercises](https://www.cs.ubbcluj.ro/~vancea/asc/en-lab12-exercitii.php)
- [Lab 11+12 homework](https://docs.google.com/spreadsheets/d/1lJjrBtxA8gJ3xqEYycmYH1hT-lp5giulONPYLN0Nrq0/edit?usp=sharing)

## Running the examples
#### a+b
```
cd a+b
nasm -f win32 sum.asm
g++ -m32 -Wall -no-pie gcd.obj main.cpp -o main.exe
.\main.exe
```
Or short version:
```
cd a+b
nasm -f win32 sum.asm ; g++ -m32 -Wall -no-pie gcd.obj main.cpp -o main.exe ; .\main.exe
```
#### gcd
```
cd gcd
nasm -f win32 gcd.asm
g++ -m32 -Wall -no-pie gcd.obj main.cpp -o main.exe
.\main.exe
```
### Add g++ to PATH
Install [MinGW](https://sourceforge.net/projects/mingw/) and then [add to PATH](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/) the folder where you g++.exe.
### Small benchmark
[Comparison between C++ and Python and Assembly](https://www.youtube.com/watch?v=3PcIJKd1PKU)