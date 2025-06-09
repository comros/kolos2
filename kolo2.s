#################################################################
# Program ma wyliczyc wartosc formuly podanej przez prowadzacego
# i wydrukowac wynik w oknie terminala (funkcja printf):
# (maks. 6 punktów): pojedynczy wynik
# (maks. 10 punktów): kilka wynikow dla danych zawartych w tablicy
#
# Uwaga: zmiana wartosci i/lub typow danych bedzie traktowana
# jako rozwiazanie nie w pełni poprawne!
#################################################################

		.data

# Zdefiniuj odpowiednie napisy do wyswietlenia wynikow
txt_1:	.string "X = %6.f -> Y = %6.f\n"
txt_2:	.string "X = %6.1f -> Y = %6.1f\n"
txt_3:	.string "X = %6.Lf -> Y = %6.Lf\n"

# Wartosc poczatkowa zmiennych i niezbedne stale.

dwapi:	.double	6.28
x_1:	.long	1
x_2:	.float	2.0
x_3:	.double	3.0
x_4:	.tfloat 4.0

x_tab:	.xxx	0.0, 1.0, 2.0, 3.0, 4.0
x_cnt:	.long	5

cw:		.word	0


		.text
		.global main
		
main:
		push %rbp

		finit

# Ustaw odpowiednia precyzje obliczen, wylacz wyjatki

		fstcw cw
		# ...
		fldcw cw

# Policz wartosc wg formuly podanej przez prowadzacego zajecia


# Wydrukuj wynik konwersji zgodnie z typem wyniku

		call printf 

# Koniec funkcji main

		pop %rbp
		xor %eax, %eax
		ret
#################################################################
