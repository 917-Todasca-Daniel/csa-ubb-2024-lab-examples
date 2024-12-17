#include <iostream>

extern "C" int is_palindrome_date(int day, int month, int year);

int main()
{
    // bonus TASK: add the is_valid_date call here as well
    // you will need to modify is_leap_year to adhere to the CDECL
    
    int day, month, year;
    std::cout << "Hello world!" << std::endl;
    std::cout << "Day, month, year: ";
    std::cin >> day >> month >> year;
    
    if (is_palindrome_date(day, month, year) == 1) 
    {
        std::cout<<"Yes";
    }
    else std::cout<<"No";
	return 0;
}