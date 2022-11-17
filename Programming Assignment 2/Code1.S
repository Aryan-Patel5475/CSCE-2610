	.text                 // program section
	.global	main          // main
	.arch armv8-a+fp+simd // processor type
	.type main, %function // main function

main:
	  ADD X9, X9, #1
	  ADD X20, X20, #1
Loop: SUBS X14, X9, X20
	  ADD X10, X13, #0
	  ADD X11, X13, #0
	  B.GE Exit
	  ADD X12, X9, #0
	  ADD X10, X12, #1
	  ADD X11, X12, #2
	  MUL X10, X11, X10
	  MUL X10, x10, X12
	  ADD X21, X10, X21
	  ADD X9, X9, #1
	  B Loop
Exit:
	NOP
