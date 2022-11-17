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
	ADD X23, X23, #5	// ARRAY LENGTH (CHANGE THIS VALUE TO TRY DIFFERENT SIZE ARRAY)
	MOV X1, X23			// STORING SIZE OF THE ARRAY IN X1
	BL med_val			// CALLING MED_VAL FUNCTION
	MOV X21, X0			// STORING FINAL VALUE IN X21
	B exit				// EXITING THE PROGRAM

med_val:
	SUB SP, SP, #96			// ALLOCATING SPACES IN STACK
	STUR X9, [SP, #0]		// ADDING REGISTER ON THE STACK
	STUR X10, [SP, #8]
	STUR X11, [SP, #16]
	STUR X12, [SP, #24]
	STUR X13, [SP, #32]
	STUR X14, [SP, #40]
	STUR X15, [SP, #48]
	STUR X16, [SP, #56]
	STUR X17, [SP, #64]
	STUR X18, [SP, #72]
	STUR X19, [SP, #80]
	STUR X20, [SP, #88]
	ADD X9, X1, #0
	ADD X10, X10, #2	// X10 = 2
	ADD X11, X11, #1	// X11 = 1

	AND X12, X9, X11	// X20 = X9 & X11
	CBNZ X12, Else

	ADR X15, v			// ARRAY BASE ADDRESS

	SDIV X13, X9, X10	// X13 = SIZE OF ARRAY / 2
	LSL X14, X13, #3	// X14 = 8 (2^3)
	ADD X14, X15, X14	// X14 = BASE + OFFSET
	LDUR X16, [X14, #0]	// X16 = MIDDLE VALUE

	SUB X17, X13, #1	// SINCE EVEN WE NEED ONE MORE VALUE
	LSL X18, X17, #3	// X18 = 8 (2^3)
	ADD X18, X15, X18	// X18 = BASE + OFFSET
	LDUR X19, [X18, #0]	// X19 = MIDDLE VALUE + 1

	ADD X20, X16, X19	// X20 = X16 + X19
	SDIV X20, X20, X10	// X20 = MEDIAN VALUE
	ADD X0, X20, #0		// SAVING FINAL OUTPUT IN X0
	B fake_exit
Else:
	ADR X15, v			// ARRAY BASE ADDRESS
	SDIV X13, X9, X10	// MIDDLE INDEX
	LSL X14, X13, #3	// X14 = 8 (2^3)
	ADD X14, X15, X14	// X14 = BASE + OFFSET
	LDUR X16, [X14, #0]	// LOADING VALUE OF MIDDLE VALUE
	ADD X0, X16, #0		// STORING MIDDLE VALUE IN X0
	B fake_exit
fake_exit:
	LDUR X9, [SP, #0]		// RESTORING REGISTER ORIGANL VALUE BACK TO THEM
	LDUR X10, [SP, #8]
	LDUR X11, [SP, #16]
	LDUR X12, [SP, #24]
	LDUR X13, [SP, #32]
	LDUR X14, [SP, #40]
	LDUR X15, [SP, #48]
	LDUR X16, [SP, #56]
	LDUR X17, [SP, #64]
	LDUR X18, [SP, #72]
	LDUR X19, [SP, #80]
	LDUR X20, [SP, #88]
	ADD SP, SP, #96			// ADDING THE STACK BACK
	BR X30
exit:
	NOP
