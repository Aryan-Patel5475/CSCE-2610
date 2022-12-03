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
	MOV X13, #4				//
	MOV X12, #2
	MOV X14, #2
	CBZ X13, zero
	SUB X15, X13, #1
	CBZ X15, one
loop:
	CMP X13, #1
	B.LE exit
	MUL X12, X12, X14
	SUB X13, X13, #1
	B loop
zero:
	MOV X12, #1
	B exit
one:
	MOV X12, X12
	B exit
exit:
	NOP
