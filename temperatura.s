	.data
txt_cnv:.string "Tc = %6.1lf -> Tf = %6.1lf\n"
c32:	.double 32.0
tf:	.double 0.0
tc:	.double 100.0

c9:	.double 9
c5:	.double 5

tc_array: .double 0.0, 25.0, 100.0
.equ	tableSize, 3

cw:	.word 0

	.text
	.global main
main:
	PUSH	%rbp
	FINIT	

	FSTCW	cw
	MOV	cw,%ax
	AND	$0xFCFF,%ax
	OR	$0x003F,%ax
	OR	$0x0200,%ax
	MOV	%ax,cw
	FLDCW	cw
	
	XOR	%r12,%r12
loop:
	CMP	$tableSize,%r12
	JZ	end	

	FLDL	tc_array(,%r12,8)
	CALL	convert

	MOVSD	tf,%xmm1
	MOVSD	tc_array(,%r12,8),%xmm0
	MOV	$txt_cnv,%rdi
	MOV	$2,%al
	CALL	printf
	
	INC	%r12
	JMP	loop
end:
	POP	%rbp
	XOR	%rax,%rax
	RET

# F = 32 + 9C/5
.type convert, @function
convert:
	PUSH	%rbp
	FMULL   c9	# 9 * C
        FDIVL   c5	# 9C/5
        FADDL   c32	# 32 + 9C/5 
        FSTPL   tf
	POP	%rbp
	RET

