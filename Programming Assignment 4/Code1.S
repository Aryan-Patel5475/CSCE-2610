/* This assembly code simply loads the lower case alphabets from the below   */
/* static array (str 1) and converts the alphabets to a upper case alphabets */
/* and stores the upper case alphabets in static array (str 2)               */

	 .data                       // data section
	 .type	str1, %object        // defining object str1
	 .size	str1, 18              // string 1
	 .type	str2, %object        // defining object str2
	 .size	str2, 4              // string 2

str1:
	 .byte	'w', 'o', 'r', 'd', '1', ' ', 'w', 'o', 'r', 'd', '2', ' ', 'w', 'o', 'r', 'd', '3', 0

str2:
	 .byte	0, 0, 0, 0           // null char values

	 .text                       // program section
	 .global	main             // main
	 .arch armv8-a+fp+simd       // processor type
	 .type	main, %function      // main function

main:
	MOV X21, SP					// copying stack pointer to register X21
	ADR X24, str1				// load base address of array into X24
	MOV X1, X24					// moving the base address into X1
	BL num_words				// jumping to num_words
	MOV X9, X0					// moving the result to X9
	B Exit

num_words:
	SUB X21, X21, #16			// allocating space on stack
	STUR X19, [X21, #0]			// storing register onto stack
	STUR X20, [X21, #8]
	ADD X0, X0, #1				// add 1 to X0 since there will atleast be 1 word
loop:
	LDURB W19, [X1, #0]			// loading character into W19
	CBZ W19, fake_exit			// checking if the character is 0 (null character)

	SUB W20, W19, #32			// subtracting 32 to see if the character is space or not
	CBZ W20, pop				// if character is space then jump to pop

	ADD X1, X1, #1				// adding 1 to address of str1
	B loop						// looping again
pop:
	ADD X0, X0, #1				// adding 1 to X0
	ADD X1, X1, #1				// adding 1 to address of str1
	B loop						// looping again
fake_exit:
	LDUR X19, [X21, #0]			// restoring orginial value of register
	LDUR X20, [X21, #8]
	ADD X21, X21, #16			// deallocating space on stack
	BR X30						// return to the main function
Exit:
	NOP
