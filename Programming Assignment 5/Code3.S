/* This assembly code performs simple cacluations using single and */
/* double precision values by loading from the static array.       */

	 .data                    // data section
	 .type	s, %object        // defining object s
	 .size	s, 3              // single-precision values
	 .type	d, %object        // defining object d
	 .size	d, 3              // double-precision values

s:                            // s array
    .float 1.0, 2.0, 3.0      // 32-bit single precision values {1.0, 2.0, 3.0}

d:                            // d array
    .double 1.0, 2.0, 3.0     // 64-bit double precision values {1.0, 2.0, 3.0}

	 .text                    // program section
	 .global	main          // main
	 .arch armv8-a+fp+simd    // processor type
	 .type	main, %function   // main function

main:
	MOV X27, #2				// x
	MOV X20, #4				// a
	MOV X9, XZR				// n
	MOV X21, XZR			// y
	MOV X22, SP				// stack pointer
loop:
	CMP X9, X20				// comparing n and a
	B.GE exit				// exiting the loop if n is not less than a
	MOV X1, X9				// X1 = n
	MOV X2, X27				// X2 = x
	BL pow_function			// calling pow_function
	MOV X10, X2				// moving answer we got from pow_function to X10
	MOV X1, X9				// X1 = n
	BL factorial			// calling factoriall function
	MOV X11, X0				// moving result from factorial functio X11
	SDIV X12, X10, X11		// Diving two results and storing it in X12
	ADD X21, X21, X12		// Adding divided value to X21
	ADD X9, X9, #1			// incrementing
	B loop

pow_function:
	SUB X22, X22, #32		// allocating space on stack
	STUR X12, [X22, #0]		// storing value of registers
	STUR X13, [X22, #8]
	STUR X14, [X22, #16]
	STUR X15, [X22, #24]
	MOV X12, X2
	MUL X13, X12, X1		// X13 = 2*n
	CBZ X13, zero
	SUB X15, X13, #1
	CBZ X15, one
loop2:
	CMP X13, #1
	B.LE fake_exit
	MUL X2, X12, X2
	SUB X13, X13, #1
	B loop2
zero:
	MOV X2, #1
	B fake_exit
one:
	MOV X2, X2
	B fake_exit
fake_exit:
	LDUR X12, [X22, #0]
	LDUR X13, [X22, #8]
	LDUR X14, [X22, #16]
	LDUR X15, [X22, #24]
	ADD X22, X22, #32
	BR X30

factorial:
	MOV X0, #1
loop3:
	CMP X1, #0
	B.LE fake_exit2
	MUL X0, X1, X0
	SUB X1, X1, #1
	B loop3
fake_exit2:
	BR X30

exit:
	NOP
