#################################################################
#
#Na maks. 7 punktow:
#program ma wykonac dzialanie (a + b + c + d ) / 8 i wyswietlic wynik.
#
#Liczby a, b i c (32 bitowe ze znakiem) maja zostac przekazane
#jako parametry z linii komend.
#
#Na maks. 10 punktow - dopisac obsluge bledow.
#Np. jak liczba przekazanych parametrow jest rozna od 4
#wyjdz po wydrukowaniu odpowiedniego komunikatu.
#
##Zadanie ratunkowe - na maks. 4 punkty: wydrukowanie tekstu "str"
#z wartosciami (w rejestrach) podanymi przez prowadzacego (funkcja "printf").
#
#################################################################

.globl    main

.data

str:        .asciz    "(%d + %d + %d + %d) / 8 = %d\n"
err:        .asciz     "Zbyt duzo argumentow\n"

arg_a:        .long    0
arg_b:        .long    0
arg_c:        .long    0
arg_d:        .long    0
result:    .long    0

#################################################################

.text

main:

sub    $8,%rsp

#Przykladowe etapy zadania.
#Sprawdz warunek:
#jezeli liczba parametrow jest rozna od 5 to wyjdz
#wydrukuj odpowiedni komunikat i wyjdz.
#Konwersja string->int przekazanych jako parametry liczb.
#program:


mov    8(%rsi),%rdi
call    atoi
mov    %eax,arg_a


...
mov    arg_a,%esi
mov    arg_b,%r11
mov    arg_c,%ecx
mov    arg_d,%r8

#Wykonaj dzialanie (a + b + c + d) / 8.
#Wyswietl wynik (printf) zgodnie z formatowaniem ciagu "str"
#przekazujac argumenty zgodnie ABI.
mov    $str, %rdi

call    printf

#Koniec funkcji main.
koniec:

add    $8,%rsp
xor    %eax,%eax
ret

#################################################################
#sprobuj sobie to przekopiowac do notatnika i sprawdz czy dziala