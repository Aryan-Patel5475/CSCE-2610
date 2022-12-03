/* This assembly code performs simple cacluations using single and */
/* double precision values by loading from the static array.       */

	 .data                    // data section
	 .type	s, %object        // defining object s
	 .size	s, 8              // single-precision values
	 .type	d, %object        // defining object d
	 .size	d, 9              // double-precision values

s:                            // s array
    .float 2.0, 2.0, 3.0, 5.0, 4.0, 7.0, 5.0, 1.0, 6.0    // 32-bit single precision values {1.0, 2.0, 3.0}

d:                            // d array
    .double 1.0, 2.0, 3.0     // 64-bit double precision values {1.0, 2.0, 3.0}

	 .text                    // program section
	 .global	main          // main
	 .arch armv8-a+fp+simd    // processor type
	 .type	main, %function   // main function

main:
      MOV X9, #9			  // length of the array
      MOV X10, #0			  // for looping array
      ADR X11, s			  // base of the array
      LDUR S14, [X11, #0]	  // initalizing smallest value
      LDUR S15, [X11, #0]	  // initalizing largest value
loop:
      CMP X9, #0				// comparing length of array to 0
      B.LE exit					// if length of array is 0 then exit
      LSL X12, X10, #2			// multiply i*4
      ADD X12, X11, X12			// adding base address
      LDUR S13, [X12, #0]		// loading value in S13
      FCMP S14, S13				// comapring S14 and S13
      B.GT less					// if S13 is less than S14 then go to less
      FCMP S15, S13				// comapring S15 to S13
      B.LT great				// if S15 is S13 then go to great
      ADD X10, X10, #1			// add 1 to X10
      SUB X9, X9, #1			// sub 1 from array length
      B loop					// looping again
less:
	FMOV S14, S13				// moving S13 to S14
	ADD X10, X10, #1			// add 1 to X10
    SUB X9, X9, #1				// sub 1 from array length
	B loop						// looping again
great:
	FMOV S15, S13			    // moving S13 to S15
	ADD X10, X10, #1			// add 1 to X10
    SUB X9, X9, #1				// sub 1 from array length
	B loop						// looping again
exit:
	NOP
