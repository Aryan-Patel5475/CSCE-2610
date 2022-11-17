#include <stdio.h>

// factorial function n!
unsigned long long int factorial_function(unsigned long long num) {
	
	// declaring and initializing new fact_num
	unsigned long long fact_num = num;
	
	// if 0! then just return 1
	if (fact_num == 0) {
		fact_num = 1;
		return fact_num;
	}
	
	// for loop untill i > 0
	for (unsigned long long int i = (num - 1); i > 0; --i) {
		fact_num *= i;
	}
	
	// returning n!
	return fact_num;
}

int main() {
	
	// declaring and initializing equation variables
	unsigned long long int y = 0, a, n = 0, b;
	
	// asking and taking in user input for a & b
	printf("Enter the value of a: "); scanf("%llu", &a);
	printf("Enter the value of b: "); scanf("%llu", &b);
	
	// looping untill n <= a
	for (unsigned long long int i = n; n <= a; ++n) {
		// increment y by (2n)! + b each time
		y += factorial_function(2*n) + b;
	}
	
	// outputing final value of y
	printf("Value of y: %llu\n", y);
	
	return 0;
}