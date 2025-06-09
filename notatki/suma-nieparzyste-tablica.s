#################################################################
#       Wykonane zadanie suma i nieparzysta oraz ratunkowe	#
#################################################################

		.data

# text_a:	.string "X = %d,  Y = %d\n"
text_a:		.string "Sum = %d, oddCount = %d\n"

tab:		.long 6, 4, -3, 3, -5, 9, 7, 1, -2, 8, -3, 5, 9, -1, 2
count:		.long 15

sum:		.long 0

# text_b:	.string "Jan Niezbedny nr albumu %d\n"
text_c:		.string "%s nr albumu %d\n"
nr_albumu:	.long 12345
name:		.string "Jan Niezbedny"

oddCount:	.long 0

#################################################################

		.text
		.global main

main:
		push %rbp

		XOR 	%ecx,%ecx
		XOR	%eax,%eax
petla:

		CMP	count,%ecx
		JE	koniec

		MOV	tab(,%ecx,4),%eax
		CALL	czyNieparzysta

		INC	%ecx
		JMP	petla

koniec:

		MOV	$text_a,%rdi
		MOV	sum,%esi
		MOV	oddCount,%edx

		XOR	%al,%al
		CALL	printf

		MOV 	$text_c,%rdi
		MOV 	$name,%rsi
		MOV 	nr_albumu,%rdx

		XOR 	%al,%al
		call printf

		pop %rbp
		xor %rax,%rax
		ret

#################################################################

.type czyNieparzysta, @function
# Input: %eax - liczba całkowita
# Inkrementuje oddCount, jeżeli jest nieparzysta i dodaje ją do sum
# Output: brak - zapisuje wynik w pamięci

czyNieparzysta:
		PUSH	%r8
		TEST	$1,%eax
		JZ	.parzysta
		MOV	oddCount,%r8d
		INC	%r8d
		MOV	%r8d,oddCount
		ADD	%eax,sum
.parzysta:
		POP	%r8
		RET