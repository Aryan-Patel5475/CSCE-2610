    .data                 // data section
	.type	x, %object    // defining object v
	.size	x, 3          // size 3 elements

x:                        // v array
	.xword	1, 2, 3       // elements of size 64-bit


	.text                 // program section
	.global	main          // main
	.arch armv8-a+fp+simd // processor type
	.type main, %function // main function

main:
	ADR X13, x			  // load base address of x into X13

	ADD X20, X21, #5	  // a = b + 5
	LSR X10, X21, #2	  // X10 = b / 4
	LSL X11, X10, #3      // X11 = a * 8( x^3)
	ADD X11, X13, X11	  // X11 = base + offset
	LDUR X11, [X11, #0]   // X12 = x[b / 3]
	ADD X14, X12, X22     // X14 = x[b / 3] + c
	STUR X14, [x11, #16]  // x[a / 4] = x[2 * c] + (b << 4)

	ADD X9, X15, #0       // X9 = 0
	ADD X10, X15, #0      // X10 = 0
	ADD X11, X15, #0      // X11 = 0
	ADD X12, X15, #0      // X12 = 0
	ADD X14, X15, #0      // X14 = 0

	LSL X10, X21, #4	  // X10 = b << 4
	LSR X11, X22, #1      // X11 = ( 2 * C)
	LSL X11, X11, #3      // X11 = (2 * c) * (8) (2 ^ 3)
	ADD X11, X13, X11     // X11 =  base + offset
	LDUR X12, [X11, #0]   // X12 = x[2 * c]
	ADD X11, X15, #0      // X11 = 0
	ADD X10, X12, X10     // X10 = x [ 2 * c] + ( b << 4)
	LSL X11, X20, #2      // X11 = a / 4
	LSL X14, X11, #3      // X14 = (a / 4) * 8
	ADD X14, X13, X14     // X14 = base + offset
	STUR X11, [X14, #0]   // x[a / 4] = x [ 2 * c] + (  b << 4)
