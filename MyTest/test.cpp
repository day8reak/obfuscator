#include <iostream>
#include <cstdlib>
#include <limits>
int fibonacci(int n) {
	if (n <= 1)
		return n;
	return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
	int n;
	double input;

	do {
		 
		std::cout << "Enter the number of fibonacci numbers: ";
		std::cin >> input;

		if (std::cin.fail() || input <= 0 || input != static_cast<int>(input)) {
			std::cout << "Invalid input. Please enter a positive integer.\n";
			std::cin.clear();
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		} else if (input >= 48) {	
			std::cout << "Sorry, it exceeds the range of int.\n";
			std::cin.clear();
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}	
		else {
			n = static_cast<int>(input);
			break;
		}
	} while (true);
	std::cout << "Fibonacci Series:\n";
	for (int i = 0; i < n; i++) {
		std::cout << fibonacci(i) << " ";
	}
	std::cout << std::endl;

	return 0;
}
