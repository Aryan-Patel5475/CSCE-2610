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
	MOV X9, #3
	FMOV D9, #3.0
	FMOV D10, #1.0
	FMOV D11, #1.0
loop:
	CMP X9, #0
	B.LE exit
	FMUL D10, D9, D10
	SUB X9, X9, #1
	FSUB D9, D9, D11
	B loop
exit:
	NOP
