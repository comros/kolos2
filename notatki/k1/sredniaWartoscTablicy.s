###############################################################
# 
# Program ma obliczyc i wydrukowac w oknie terminala
# srednia wartosc elementow przechowywanych w tablicy (liczby calkowite, 16 bitowe, bez znaku).
#
#################################################################

.data

.equ	liczba_elementow, 16

napis:		.asciz	"avg = %hd\n"

tablica:	.word	64, 4, 3, 3, 0, 8, 7, 10, 1, 8 ,8 ,8 , 8, 4, 15, 72

avg:		.long	0

#################################################################

.text
.global	main


main:
    sub	$8,%rsp

# Inicjuj zmienne wartosciami poczatkowymi.
    XOR %ecx, %ecx      # licznik iteracji
    XOR %bx, %bx       # suma elementow tablicy = 0
petla:
# Odczytaj element tablicy i dodaj go do sumy.
    mov	tablica(,%ecx,4) , %ax
    ADD %ax, %bx

# Zaktualizuj licznik iteracji, sprawdz warunek zakonczenia petli.
    inc	%ecx  # (incline) Zwieksz licznik iteracji o 1
    CMP $liczba_elementow, %ecx # Porownaj licznik iteracji z liczba elementow tablicy
    jne	petla

koniec:

# obliczenie sredniej
    MOV %bx, %ax # Przypisz sume do rejestru %ax
    CLTD # Rozszerz %ax do %dx:%ax

    MOV $liczba_elementow, %bx # Przypisz liczbe elementow do rejestru %bx
    IDIV %bx # Dziel %dx:%ax przez %bx, wynik w %ax, reszta w %dx
    MOV %ax, avg # Przypisz wynik do zmiennej avg

# Wyswietl wynik (printf) 
    MOV $napis, %rdi # Adres napisu do %rdi
    MOV avg, %esi # Wartość do wyswietlenia do %rsi
    XOR %al, %al # Ustaw %al na 0 (printf wymaga tego dla zmiennych typu long)
    call	printf

# Koniec funkcji main.

    add	$8,%rsp
    xor	%eax,%eax
    ret

#################################################################