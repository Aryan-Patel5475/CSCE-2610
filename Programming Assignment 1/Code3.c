#include <stdio.h>

int main() {
	
	// declaring and initializing the length of the string upto 255 character
	char sentence[256];
	
	int senLength, vowelCounter = 0, wordCounter = 1;
	
	int i;
	
	// asking and taking in the user input
	printf("Enter the sentence: "); scanf("%[^\n]s", sentence);
	
	// printf("Output: %s\n", sentence);
	
	// looping untill the end of the sentence
	for (i = 0; sentence[i] != '\0'; ++i) {
		// checking for vowel and raising the vowel counter
		if (sentence[i] == 'A' || sentence[i] == 'a') {
			++vowelCounter;
		}
		else if (sentence[i] == 'E' || sentence[i] == 'e') {
			++vowelCounter;
		}
		else if (sentence[i] == 'I' || sentence[i] == 'i') {
			++vowelCounter;
		}
		else if (sentence[i] == 'O' || sentence[i] == 'o') {
			++vowelCounter;
		}
		else if (sentence[i] == 'U' || sentence[i] == 'u') {
			++vowelCounter;
		}
		
	}
	printf("\n");
	senLength = i;
	
	// looping until the end of the sentence to find out the number of words
	// since there will always be one more words then no. of spaces
	// we juat count number of spaces and increment it by 1 to get no. of words
	for (int j = 0; j < senLength; ++j) {
		if (sentence[j] == ' ') {
			++wordCounter;
		}
	}
	
	// outputing the result
	printf("Length of the sentence: %d\n", senLength);
	printf("Vowels in the sentence: %d\n", vowelCounter);
	printf("Words in the sentence: %d\n", wordCounter);
	
	return 0;
}