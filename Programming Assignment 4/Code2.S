/* This assembly code simply loads the lower case alphabets from the below   */
/* static array (str 1) and converts the alphabets to a upper case alphabets */
/* and stores the upper case alphabets in static array (str 2)               */

	 .data                       // data section
	 .type	str1, %object        // defining object str1
	 .size	str1, 15             // string 1
	 .type	str2, %object        // defining object str2
	 .size	str2, 4              // string 2

str1:
	 .byte	'!', 'a', 'b', '!', 'c', '.', 'd', '?', ''', '"', '3', '.', '!', 'r', 0

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
	BL num_punc					// jumping to num_words
	MOV X9, X0					// moving the result to X9
	B Exit

num_punc:
	SUB X21, X21, #16			// allocating space on stack
	STUR X19, [X21, #0]			// storing register value onto the stack
	STUR X20, [X21, #8]
loop:
	LDURB W19, [X1, #0]			// loading character into the W19
	CBZ W19, fake_exit			// checking if the character is 0 (null)

	SUB W20, W19, #33			// checking if the character is exclamation (!) or not
	CBZ W20, pop				// if character is ! then jump to pop

	SUB W20, W19, #34			// checking if the character is quotation (") or not
	CBZ W20, pop				// if character is " then jump to pop

	SUB W20, W19, #39			// checking if the character is apostrophe (') or not
	CBZ W20, pop				// if character is ' then jump to pop

	SUB W20, W19, #44			// checking if the character is comma (,) or not
	CBZ W20, pop				// if character is , then jump to pop

	SUB W20, W19, #46			// checking if the character is period (.) or not
	CBZ W20, pop				// if character is . then jump to pop

	SUB W20, W19, #63			// checking if the character is question (?) or not
	CBZ W20, pop				// if character is ? then jumpt to pop

	ADD X1, X1, #1				// adding 1 to the address of str1
	B loop						// looping back
pop:
	ADD X0, X0, #1				// adding 1 to X0
	ADD X1, X1, #1				// adding 1 to the address of str1
	B loop						// looping back
fake_exit:
	LDUR X19, [X21, #0]			// restoring register original values
	LDUR X20, [X21, #8]
	ADD X21, X21, #16			// deallocating space on X21
	BR X30						// return back to caller

Exit:
	NOP
