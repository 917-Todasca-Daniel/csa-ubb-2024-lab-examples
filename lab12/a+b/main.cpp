#include <stdio.h>

extern "C" int sum(int a, int b);

int main()
{
	int a = 10;
    int b = 20;
	printf("%d + %d = %d", a, b, sum(a, b));
	return 0;
}