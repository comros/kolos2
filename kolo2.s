.data

# Dane:
a:		.double 1.0
alfa:		.double 15.0, 30.0, 45.0, 60.0, 75.0
alfaCount:	.quad 5

# Obliczone:
alfarad:	.double 0.0
b: 		.double 0.0
c:		.double 0.0
sin:		.double 0.0
cos:		.double 0.0
tan:		.double 0.0

# Mnozniki:
radmul:		.double 180.0
areamul:	.double 2.0

# Wyniki:
area:		.double 0.0
circ:		.double 0.0

# Precyzja:
.equ PRECISION,		0xFCFF
.equ PREC_DOUBLE,	0x0200

# Tekst wyjsciowy
outputText:	.string "Pole: %6.11lf, obwod: %6.11lf, alfa: %6.11lf\n"

# Control word do ustawiania precyzji
cw:		.word 0

.text
.global main
main:
	PUSH %rbp

	# Ustawianie precyzji
	FINIT
	FSTCW cw
	MOV cw, %ax
	AND $PRECISION, %ax
	OR $PREC_DOUBLE, %ax
	FLDCW cw

	# Zerowanie licznika petli
	XOR %r12, %r12
petla:
	CMP alfaCount, %r12	# Sprawdzenie warunki
	JZ end			# Jesli jest spelniony, koniec

	FLDL alfa(,%r12,8)	# Zaldowanie alfa
	CALL deg2rad		# Obliczenie alfa w radianach
	CALL calcTrig		# Obliczenie funkcji trygonomterycznych sin, cos, tan
	CALL calcB		# Obliczenie b
	CALL calcC		# Obliczenie c
	CALL calcArea		# Obliczenie powierzchni
	CALL calcCirc		# Obliczenie obwodu

	# Wypisanie
	MOVQ $outputText, %rdi
	MOVQ area, %xmm0
	MOVQ circ, %xmm1
	MOVQ alfa(,%r12,8), %xmm2
	MOVQ $3, %rax
	CALL printf

	# Licznik++ i powrot do petli
	INC %r12
	JMP petla
end:
	# Piekne wyjscie z pieknego programu
	POP %rbp
	XOR %rax, %rax
	RET

.type deg2rad, @function
# IN: st(0) = alfa
# OUT: store alfarad
deg2rad:
	PUSH %rbp
	FLDPI		# st: alfa, pi
	FMULP		# st: alfa*pi
	FDIVL radmul	# st: alfa*pi/180
	FSTPL alfarad
	POP %rbp
	RET

.type calcTrig, @function
# OUT: store sin, cos, tan
calcTrig:
	PUSH %rbp
	# Sinus:
	FLDL alfarad
	FSIN
	FSTPL sin
	# Cosinus:
	FLDL alfarad
	FCOS
	FSTPL cos
	# Tangens:
	FLDL alfarad
	FSINCOS
	FDIVRP
	FSTPL tan
	POP %rbp

.type calcB, @function
# OUT: store b
calcB:
	PUSH %rbp
	FLDL tan	# st: tan
	FMULL a		# st: a*tan
	FSTPL b
	POP %rbp
	RET

.type calcC, @function
# OUT: store c
calcC:
	PUSH %rbp
	FLDL a		# st: a
	FDIVL cos	# st: a/cos
	FSTPL c
	POP %rbp
	RET

.type calcArea, @function
# OUT: store area
calcArea:
	PUSH %rbp
	FLDL a		# st: a
	FMULL b		# st: a*b
	FDIVL areamul	# st: a*b/areamul
	FSTPL area
	POP %rbp
	RET

.type calcCirc, @function
# OUT: store circ
calcCirc:
	PUSH %rbp
	FLDL a		# st: a
	FADDL b		# st: a+b
	FADDL c		# st: a+b+c
	FSTPL circ
	POP %rbp
	RET