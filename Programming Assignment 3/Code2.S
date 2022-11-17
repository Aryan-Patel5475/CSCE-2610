    .data                 // data section
	.type	v, %object    // defining object v
	.size	v, 5          // size 3 elements

v:                        // v array
	.xword	2, 4, 6, 8, 9       // elements of size 64-bit


	.text                 // program section
	.global	main          // main
	.global sum_srs		  // sum
	.arch armv8-a+fp+simd // processor type
	.type main, %function // main function

main:
	ADD X9, X9, #5		// VALUE OF A (CHANGE THIS VALUE TO CHANGE VALUE OF A)
	ADD X10, X10, #3	// VALUE OF B (CHANGE THIS VALUE TO CHANGE VALUE OF B)
	MOV X1, X9			// STORING A IN X1
	MOV X2, X10			// STORING B IN X2
	BL sum_srs			// CALLING THE FUNCTION
	MOV X23, X0			// STORING THE FINAL RESULT IN X23
	B exit				// EXITING THE PROGRAM

sum_srs:
	SUB SP, SP, 80		// ALLOCATING SPACE IN STACK
	STUR X9, [SP, #0]	// STORING REGISTER VALUES IN STACK
	STUR X10, [SP, #8]
	STUR X11, [SP, #16]
	STUR X12, [SP, #24]
	STUR X13, [SP, #32]
	STUR X14, [SP, #40]
	STUR X18, [SP, #38]
	STUR X19, [SP, #56]
	STUR X20, [SP, #64]
	STUR X21, [SP, #72]
	ADD X9, X1, #0		// X9 = A = X1
	ADD X10, X2, #0		// X10 = B = X2
	ADD X11, X11, #1	// X11 = N = 1
	ADD X19, X9, #1
loop:
	CMP X11, X19		// COMPARING N AND A
	B.GE pop
	ADD X12, X9, #0		// X12 = X9
	ADD X13, X22, #1	// X13 = 1
	SUB X14, X11, #1
	CBNZ X14, Else		// IF N == 1 THEN X12 = X9
	ADD X12, X9, #0
	B fake_exit
Else:
	SUB X18, X11, #1	// NO IDEA, LOOP SEEM TO RUN 1 TIME MORE THEN REQUIRED SO I SUB 1
loop2:
	CMP X13, X18		// COMAPRING X13 TO N
	B.GT fake_exit
	MUL X12, X12, X9	// X12 = X12 * X9
	ADD X13, X13, #1	// X13 = X13 + 1
	B loop2
fake_exit:
	ADD X20, X12, X10	// X21 = X12 + X10
	ADD X0, X20, X0		// X0 = X20 + X0
	ADD X11, X11, #1	// X11 = X11 + 1
	B loop
pop:
	LDUR X9, [SP, #0]		// RESTORING VALUES OF REGISTERS
	LDUR X10, [SP, #8]
	LDUR X11, [SP, #16]
	LDUR X12, [SP, #24]
	LDUR X13, [SP, #32]
	LDUR X14, [SP, #40]
	LDUR X18, [SP, #48]
	LDUR X19, [SP, #56]
	LDUR X20, [SP, #64]
	LDUR X21, [SP, #72]
	ADD SP, SP, #80		// DEALLOCATING SPACE IN STACK
	BR X30				// GOING BACK TO MAIN FUNCTION
exit:
	NOP
