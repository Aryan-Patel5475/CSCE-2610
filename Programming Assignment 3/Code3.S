    .data                 // data section
	.type	v, %object    // defining object v
	.size	v, 5          // size 3 elements

v:                        // v array
	.xword	2, 4, 6, 8, 9       // elements of size 64-bit


	.text                 // program section
	.global	main          // main
	.global sum			  // sum
	.arch armv8-a+fp+simd // processor type
	.type main, %function // main function

main:
	ADD X9, X9, #5			// VALUE OF N
	ADD X10, X10, #1		// INITIALIZING TO 1
	MOV X1, X9				// STORING N IN X1
	MOV X2, X10				// INITAL VALUE IN X2
	BL sum					// CALLING THE FUNCTION
	MOV X11, X0				// STORING THE FINAL VALUE IN X11
	B exit					// EXITING THE PROGRAM

sum:
	SUB SP, SP, #16			// ALLOCATING SPACE IN STACK
	STUR X9, [SP, #0]		// STROING REGISTER VALUE IN STACK
	STUR X10, [SP, #8]
	ADD X1, X1, #1			// ADDING 1 TO N
	ADD X11, X2, #0			// STORING INITAL VALUE IN X11
loop:
	CMP X1, X11				// COMPARING X11 AND X1
	BLE pop					// EXITING THE LOOP IF FALSE
	MUL X9, X2, X2			// MUL X9 = A * A = A^2
	ADD X0, X9, X0			// X0 = X9 + X0
	ADD X2, X2, #2			// INCRMENTING INITIAL VALUE BY 2 SO ITS ALWAYS ODD
	ADD X11, X11, #1		// INCREMENTING ITERATOR BY 1
	B loop
pop:
	LDUR X9, [SP, #0]		// RESTORING VALUES BACK IN REGISTER
	LDUR X10, [SP, #8]
	ADD SP, SP, #16			// DEALLOCATING SPACES FROM STACK
	BR X30					// GOING BACK TO MAIN FUNCTION
exit:
	NOP
