/* This assembly code simply loads the lower case alphabets from the below   */
/* static array (str 1) and converts the alphabets to a upper case alphabets */
/* and stores the upper case alphabets in static array (str 2)               */

	 .data                       // data section
	 .type	str1, %object        // defining object str1
	 .size	str1, 5              // string 1
	 .type	str2, %object        // defining object str2
	 .size	str2, 4              // string 2

str1:
	 .byte	'c', 'i', 'v', 'i', 'c', 0

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
	BL chk_palin				// jumping to num_words
	MOV X9, X0					// moving the result to X9
	B Exit

chk_palin:
	SUB X21, X21, #56			// allocating space on stack
	STUR X9, [X21, #0]			// storing register value in the stack
	STUR X10, [X21, #8]
	STUR X11, [X21, #16]
	STUR X12, [X21, #24]
	STUR X13, [X21, #32]
	STUR X19, [X21, #40]
	STUR X20, [X21, #48]
	MOV X9, X1					// moving base address to X9
loop:
	LDURB W19, [X1, #0]			// loading character in W19
	CBZ W19, body				// if character is 0 (null) then exit the loop
	ADD X1, X1, #1				// adding 1 to the address of str1
	ADD X10, X10, #1			// adding 1 to X11 to find total number of characters
	B loop
body:
	ADD X11, X11, #2			// X11  = 2
	SDIV X12, X10, X11			// X12  = size of array / 2
	SUB X1, X1, #1				// skipping the null character and going back a character
loop2:
	CBZ X12, fake_exit			// checking if X12 is 0 or not
	LDURB W19, [X9, #0]			// loading character from the beginning of the str1
	LDURB W20, [X1, #0]			// loading character from the end of the str1
	SUB W13, W19, W20			// checking if they are equal if they are 0
	CBNZ W13, fake_exit2		// if they are not same means word is not palindrome
	ADD X9, X9, #1				// adding 1 from address of str1 to get next character
	SUB X1, X1, #1				// subbing 1 from address of str1 to get previous character
	SUB X12, X12, #1			// sub X12, i--
	B loop2						// looping again
fake_exit:
	ADD X0, X0, #1				// adding 1 to X0 since word is palindrome
	B fake_exit3
fake_exit2:
	ADD X0, X0, #0				// adding 0 to X0 since word is not palindrome
	B fake_exit3
fake_exit3:
	LDUR X9, [X21, #0]			// restoring register values back
	LDUR X10, [X21, #8]
	LDUR X11, [X21, #16]
	LDUR X12, [X21, #24]
	LDUR X13, [X21, #32]
	LDUR X19, [X21, #40]
	LDUR X20, [X21, #48]
	ADD X21, X21, #56			// deallocating space on stack
	BR X30						// return back to the caller

Exit:
	NOP
