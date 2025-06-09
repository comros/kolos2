	.data
txt_1:	.string "X = %6.f -> Y = %6.f\n"
txt_2:	.string "Pole = %6.1f -> Obwod = %6.1f\n"
txt_3:	.string "X = %6.Lf -> Y = %6.Lf\n"

dwapi:	.double 6.28
x_1:	.long	1
x_2:	.float	2.0
x_3:	.double	3.0
x_4:	.tfloat	4.0

x_tab:	.double	0.0, 1.0, 2.0, 3.0, 4.0	# xxx zamienilem na double
x_cnt:	.long	5

cw:	.word	0

pole:	.double 0.0
obwod:	.double	0.0
pol:	.double	0.5	# dwapi * 0.5 = jedenpi :D 

	.text
	.global main
main:
	push	%rbp
	
	finit

	fstcw	cw
	
	mov	cw,%ax
	and	$0xFCFF,%ax	# Wyczyszczenie bitów precyzji
	or	$0x003F,%ax	# Wyłączenie wyjątków
	or	$0x0200,%ax	# Ustawienie podwójnej precyzji (double)
	mov	%ax,cw

	fldcw	cw

	xor	%r12,%r12	# Czyszczenie licznika pętli
loop:
	mov	x_cnt,%eax	# Przekazanie wartosci do rejestru
	cmp	%eax,%r12d	# Odczytywanie wartosci z rejestru 32bit !!!
	jz	end

	fldl	x_tab(,%r12,8)
	fldl	x_tab(,%r12,8)
	call	fpole

	fldl	x_tab(,%r12,8)
	call	fobwod

	movsd	pole,%xmm0
	movsd	obwod,%xmm1
	mov	$txt_2,%rdi
	mov	$2,%al
	call	printf

	inc	%r12
	jmp	loop
end:
	pop	%rbp
	xor	%eax,%eax
	ret

# pole = pi * r^2
.type pole, @function
fpole:
	push	%rbp
	fmulp		# r * r
        fldl    dwapi
        fmulp		# 2pi * r^2
        fldl    pol
        fmulp		# 0.5 * 2pi * r^2 = pi * r^2
        fstpl   pole
	pop	%rbp
	ret

# obwod = 2pi * r
.type obwod, @function
fobwod:
	push	%rbp
	fldl	dwapi
	fmulp		# r * 2pi
	fstpl	obwod
	pop	%rbp
	ret
