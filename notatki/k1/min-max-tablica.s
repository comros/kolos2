#####################################################
# Program ma wyznaczyc i wydrukowac w oknie terminala (funkcja printf):
#
# maksymalna wartosc wszystkich elementow tablicy oraz liczbe wartosci rownych 0
#
# dodatkowo minimalna wartosc elementow tablicy
#
# wydrukowanie tekstu "Imie nazwisko nr_albumu", 
# przy czym nr_albumu ma stanowic wartosc zmiennej        
#
#####################################################


.data

text_a: .string "Max=%d, min = %d, Zera: %d\n"  # napis zwracjacy wynik

tab:     .long 15, -21, 0, 0, 5, 9, 7, 1, 2, -38, 3, -5, 9, 123, 0
count:   .long 15

text_b: .string "Imie nazwisko nr %d\n" 
number: .long 12345

#####################################################

.text
.global main

main:
# nadanie wartosci poczatkowych licznikom i wartosciom max, min 

        PUSH %rbp # zapisanie ramki stosu

        XOR %esi, %esi  # max = 0
        XOR %edx, %edx # min = 0
        XOR %ecx, %ecx # licznik zer = 0

        MOV $-1, %eax # licznik iteracji            

# usun bledy i odczytaj w prawidlowy sposob element tablicy


petla:
        INCL %eax                 #indeks tab = 1
        CMP    count, %eax        #sprawdz czy koniec tablicy
        JE     koniec_petli       #jeśli count=wielkosc tab to koniec petli

#jesli nie koniec
        mov     tab(,%eax,4), %r8d      # przypisz wartosc tab[iter] do %r8d
        CMP     $0, %r8d        # sprawdz czy %r8d == 0
        JE      zero            #jesli zero to skocz do zero

to_zero:
        CMP     %r8d, %esi  # sprawdz czy %r8d > max
        JL max   # jesli %r8d < max to skocz do max

to_max:
        CMP %r8d, %edx   # sprawdz czy %r8d < min
        JG min     # jesli %r8d > min to skocz do min
        JMP petla   # jesli %r8d < min to skocz do petla

max:
        MOV %r8d, %esi   # przypisz wartosc %r8d do max
        JMP to_max   # skocz do to_max

min:
        MOV %r8d, %edx  # przypisz wartosc %r8d do min
        JMP petla   # skocz do petla

zero:
        INCL %ecx   # zwieksz licznik zer
        JMP to_zero  # skocz do to_zero

koniec_petli:

# przekaz argumenty
# wyswietl wyniki (printf)

       MOV      $text_a, %rdi  # załaduj adres tekstu do %rdi
       XOR      %al, %al      # wyzeruj %al (dla printf)
       call     printf    # wywołanie funkcji printf

# koniec funkcji main
koniec:
        XOR     %eax, %eax  # wyzeruj rejestr %eax
        pop     %rbp  # przywróć ramkę stosu

        MOV      $text_b, %rdi   # załaduj adres tekstu do %rdi
        MOV      number, %esi    # załaduj wartość zmiennej number do %esi
        XOR      %al, %al        # wyzeruj %al (dla printf)
        call     printf          # wywołanie funkcji printf

        ret  # koniec programu
#####