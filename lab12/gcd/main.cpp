#include <stdio.h>

extern "C" int gcd(int a, int b);

int main()
{
	int a = 36;
    int b = 60;
	printf("gcd(%d, %d) = %d", a, b, gcd(a, b));
	return 0;
}