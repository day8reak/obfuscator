#include <iostream>
#include <cstdlib>
#include <limits>
#define CTX_NUM_INSTRUCTIONS 128
#define NUM_FILLBITMAP ${NUM_FILLBITMAP}$

double AntiDeep(double a) {
	if (a < 0.001)
		return 0;
	a = a / 2.0;
	return AntiDeep(a);
}
int AntiFunc(double input) {
	if (input < 0) {
		input = -input;
	} else if (input == 0) {
		input++;
	}
	return (int)AntiDeep(input);
}

int fibonacci(int n) {
	if (n <= 1)
		return n;
	return fibonacci(n - 1) + fibonacci(n - 2);
}
void HaHa_error() {
	int* ptr = nullptr;
	*ptr = 10;
}
int main() {
	int n;
	double input;

	do {
		 
		std::cout << "Enter the number of fibonacci numbers: ";
		std::cin >> input;

		if (std::cin.fail() || input <= 0 || input != static_cast<int>(input)) {
			input = AntiFunc(input) + input;
			std::cout << "Invalid input. Please enter a positive integer.\n";
			std::cin.clear();
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		} else if (input >= 48) {	
			input = AntiFunc(input) + input;
			std::cout << "Sorry, it exceeds the range of int.\n";
			std::cin.clear();
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}	
		else {
			n = static_cast<int>(input);
			break;
		}
	} while (true);
	if (n == 15) {
		HaHa_error();
	}
	std::cout << "Fibonacci Series:\n";
	for (int i = 0; i < n; i++) {
		std::cout << fibonacci(i) << " ";
	}
	std::cout << std::endl;

	return 0;
}
