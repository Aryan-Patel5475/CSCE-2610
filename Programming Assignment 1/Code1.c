#include <stdio.h>

unsigned int pow_function(unsigned int num) {
    
    // declaring and initializing new_num
    unsigned int new_num = num;
    
    // declaring and initializing i
    int i = 1;
    
    // while loop until i < num
    while (i < num) {
        // multiplying new_num by num each time
        new_num = new_num * num;
        ++i;
    }
    
    // returning n^n
    return new_num;
}

int main() {
    
    // decalring and initializing variables in eqaution
    unsigned int y = 0, a, n = 1, b;
    
    // asking for and taking in user input for a & b
    printf("Enter the value of a: "); scanf("%u", &a);
    printf("Enter the value of b: "); scanf("%u", &b);
    
    // for loop until i != (a - 1)
    for (int i = 0; i < a; ++i) {
        // incremenating y by n^n + b
        y += pow_function(n) + b;
        ++n;	// incrementing n
    }
    
    // outputing final value of y
    printf("Value of y: %u\n", y);
    
    return 0;
}
