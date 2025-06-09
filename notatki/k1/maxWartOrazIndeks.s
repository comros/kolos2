#################################################################
#
# Program ma przeszukac tablice i wydrukowac w oknie terminala:
#
# - maksymalna wartosc przechowywana w tablicy (typy 16 bitowe, ze znakiem),
# - dodatkowo - numer elementu (indeks), w ktorym przechowywana jest najwieksza wartosc.
#
#################################################################

.data

.equ	liczba_elementow, 16
napis:		.asciz	"max = %hd w elemencie %hu\n"
tablica:	.word	64, 4, 3, 3, 0, 8, 7, 10, -1, 8 ,8 ,8 ,-8, 4, 15, 72
element:	.long	0
maks:		.long	0

#################################################################

.text
.global	main

main:
    sub	$8,%rsp # rezerwacja miejsca na stosie

# Inicjacja zmiennych wartosciami poczatkowymi.
    XOR %ecx, %ecx #licznik iteracji = 0

petla:

# odczytanie tablicy i zapisanie do rejestru %ax
    mov	tablica(,%ecx,2) , %ax

# Sprawdz czy odczytana z tablicy wartosc jest wieksza od najwiekszej dotychczas znalezionej,
# jesli tak - zaktualizuj odpowiednie zmienne.

    CMP maks, %ax
    JL nie_jest_wieksza
    MOV %ecx, element  # zapisz numer elementu
    MOV %ax, maks  # zapisz maksymalna wartosc

nie_jest_wieksza:
# Zaktualizuj licznik iteracji, sprawdz warunek zakonczenia petli.
    INC %ecx  # inkrementacja licznika iteracji
    CMP $liczba_elementow, %ecx  # porownanie licznika z liczba elementow
    jne	petla  # skok do petli, jezeli nie osiagnieto konca tablicy

koniec:

# Wyswietl wynik (printf) zgodnie z formatowaniem ciagu "str"
# przekazujac argumenty zgodnie ABI.

    MOV $napis, %rdi    # adres formatu
    MOV maks, %esi   # maksymalna wartosc
    MOV element, %edx  # numer elementu (indeks)
    XOR %al, %al  # zerowanie rejestru %al (printf wymaga tego rejestru)

    call	printf

# Koniec funkcji main.

    add	$8,%rsp
    xor	%eax,%eax
    ret

#################################################################