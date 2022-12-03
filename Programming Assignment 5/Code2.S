/* This assembly code performs simple cacluations using single and */
/* double precision values by loading from the static array.       */

	 .data                    // data section
	 .type	s, %object        // defining object s
	 .size	s, 8              // single-precision values
	 .type	d, %object        // defining object d
	 .size	d, 9              // double-precision values

s:                            // s array
    .float 2.0, 2.1, 3.0, 5.0, 4.0, 7.0, 5.0, 1.0, 6.0    // 32-bit single precision values {1.0, 2.0, 3.0}

d:                            // d array
    .double 1.0, 2.0, 3.0     // 64-bit double precision values {1.0, 2.0, 3.0}

	 .text                    // program section
	 .global	main          // main
	 .arch armv8-a+fp+simd    // processor type
	 .type	main, %function   // main function

main:
	MOV X20, #9				// length of array
	ADR X9, s				// base address of array
	MOV X21, SP				// stack pointer
	MOV X1, X9				// moving base address to X1
	MOV X2, X20				// moving length of the array to X2
	BL rng_val				// calling rng_val function
	FMOV S20, S0				// stroing range into D20
	B exit

rng_val:
	SUB X21, X21, #20		// allocating space on stack
	STUR S9, [X21, #0]		// storing value of register onto stack
	STUR S10, [X21, #4]
	STUR S11, [X21, #8]
	STUR X9, [X21, #12]
	STUR X10, [X21, #20]

	LDUR S9, [X1, #0]		// initializing smallest value so we can reference it
	LDUR S10, [X1, #0]		// initializing largest value so we can reference it
	MOV X10, #0				// for looping through array
loop:
	CMP X2, #0				// comapring X1 to 0
	B.LE fake_exit			// exiting the loop if X1 is less then 0

	LSL X9, X10, #2			// i * 4
	ADD X9, X1, X9			// adding base to offset
	LDUR S11, [X9, #0]		// loading values from array into S11

	FCMP S9, S11			// comparing S11 to S9
	B.GT less				// if S9 is less then S11, then go to less

	FCMP S10, S11			// comapring S10 to S9
	B.LT great				// if S11 is greater then S9, then go to great

	ADD X10, X10, #1		// incrementing 1 so we can read next value from array
	SUB X2, X2, #1			// decrementing
	B loop					// looping again

less:
	FMOV S9, S11			// moving S9 to S11
	ADD X10, X10, #1
	SUB X2, X2, #1
	B loop

great:
	FMOV S10, S11			// moving S10 to S11
	ADD X10, X10, #1
	SUB X2, X2, #1
	B loop

fake_exit:
	FSUB S0, S10, S9		// range = highest - lowest
	LDUR S9, [X21, #0]		// restoring value of registers
	LDUR S10, [X21, #4]
	LDUR S11, [X21, #8]
	LDUR X9, [X21, #12]
	LDUR X10, [X21, #20]
	ADD X21, X21, #20		// deallocating stack
	BR X30					// going back to main function

exit:
	NOP
