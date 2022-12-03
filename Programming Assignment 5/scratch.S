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
	FMOV D20, #2.0			// x
	MOV X20, #3				// a
	MOV X9, XZR				// n = 0
	FMOV D9, XZR
	FMOV D21, XZR            // Set S3 = 0.0
	MOV X22, SP				// stack pointer
	FMOV D19, #1.0

loop:
	CMP X9, X20				// comparing n and a
	B.GE exit

	MOV X1, X9				// X1 = n
	FMOV D2, D21			// D2 = x
	BL pow_func				// calling pow_func function
	FMOV D10, D2			// D10 = D2

	MOV X1, X9				// X1 = n
	FMOV D1, D9
	BL factorial			// calling factorial function
	FMOV D11, D0			// D11 = D0

	FDIV D12, D10, D11		// D12 = D10 / D11
	FADD D21, D21, D12		// adding value divided value to D12
	ADD X9, X9, #1			// incrementing by 1
	FADD D9, D9, D19
	B loop					// calling function again

pow_func:
	SUB X22, X22, #24		// allocating space on the stack
	STUR X12, [X22, #0]		// storing register value onto stack
	STUR X13, [X22, #8]
	STUR D14, [X22, #16]

	MOV X12, #2
	FMOV D14, D2
	MUL X12, X1, X12		// X12 = 2 * n

	CBZ X12, zero

	SUB X13, X12, #1
	CBZ X13, one

loop2:
	CMP X12, #1
	B.LE fake_exit
	FMUL D2, D2, D14
	SUB X12, X12, #1
	B loop2

zero:
	FMOV D2, #1.0
	B fake_exit

one:
	FMOV D2, D2
	B fake_exit

fake_exit:
	LDUR X12, [X22, #0]
	LDUR X13, [X22, #8]
	LDUR D14, [X22, #16]
	ADD X22, X22, #24
	BR X30

factorial:
	FMOV D0, #1.0
loop3:
	CMP X1, #0
	B.LE fake_exit2
	FMUL D0, D1, D0
	SUB X1, X1, #1
	SUB D1, D1, D19
	B loop3

fake_exit2:
	BR X30

exit:
	NOP
