#include <stdio.h>

// power function
float pow_function(float num1, float num2) {
	
	float new_num = num1;
	
	// if n^0 return 1
	if (num2 == 0) {
		new_num = 1;
		return new_num;
	}
	
	// looping until i > 1
	// loop to raise n ^ 2n
	for (int i = num2; i > 1; --i) {
		new_num *= num1;
	}
	
	// returning n^2n floating point number
	return new_num;
}

// factorial function
float factorial_function(float num) {
	
	float fact_num = num;
	
	// if 0! return 1
	if (fact_num == 0) {
		fact_num = 1;
		return fact_num;
	}
	
	// incrementing n by n*1 each time untill we get final value for n!
	for (int i = (num - 1); i > 0; --i) {
		fact_num *= i;
	}
	
	// returing n! floating point number
	return fact_num;
}

int main() {
	
	// declaring and initializing equation variables
	float a, n = 0, y = 0, x;
	
	// asking and taking in user input for a and x
	printf("Enter the a: "); scanf("%f", &a);
	printf("Enter the x: "); scanf("%f", &x);
	
	// summing y untill n <= a
	for (int i = n; n <= a; ++n) {
		// incrementing y by (x^2n) / n! each time 
		y += (pow_function(x, (2*n))) / factorial_function(n);
	}
	
	// printing final value of y
	printf("Value of y: %.2f\n", y);
	
	return 0;
}