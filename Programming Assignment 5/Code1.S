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
      FMOV S20, #1.5		  // set S20 = x = 1.5
      ADR X9, s
      LDUR S10, [X9, #0]	  // S10 = a
      LDUR S11, [X9, #4]	  // S11 = b
      LDUR S12, [X9, #8]      // S12 = c
      FMUL S13, S20, S20	  // S13 = S20 * S20 = x^2
      FMUL S21, S13, S10	  // S21 = S10 (a) * S13 (x ^ 2)
      FMUL S13, S11, S20	  // S13 = S11 (b) * S20 (x)
      FSUB S21, S21, S13	  // S21 = S21( a * x^2) - S13 (b * x)
      FADD S21, S21, S12      // S21 = S21 + S12 (c)
      B exit
exit:
	NOP
