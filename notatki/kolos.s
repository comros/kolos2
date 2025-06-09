#################################################################
# Program rozwiązujący oba zadania + zadanie ratunkowe
#################################################################

        .data

text_a:     .string "Suma parzystych elementów = %d, liczba elementów < 0 = %d\n"

tab:        .short 6, 4, -3, 3, -5, 9, 7, 1, -2, 8, -3, 5, 9, -1, 2
count:      .long 15

sum:        .long 0
neg_count:  .long 0

text_b:     .string "Jan Niezbedny nr albumu %d\n"
text_c:     .string "%s nr albumu %d\n"
nr_albumu:  .long 12345
name:       .string "Jan Niezbedny"

        .text
        .global main

main:
        push    %rbp

# Ustawienia początkowe
        xor     %r8d, %r8d          # r8d = indeks tablicy (i)
        xor     %r9d, %r9d          # r9d = suma parzystych
        xor     %r10d, %r10d        # r10d = licznik liczb < 0

petla:
        cmp     count, %r8d         # Czy i < count?
        jge     koniec_petli        # Jeśli nie, koniec pętli

        movsx   %si, tab(,%r8,2)    # Wczytaj element tablicy (rozszerzanie znaku z short na int)

        # Sprawdzenie parzystości
        mov     %esi, %eax          # eax = wartość elementu
        and     $1, %eax            # sprawdzenie najmłodszego bitu
        cmp     $0, %eax
        jne     sprawdz_ujemne      # jeśli nieparzysty, przejdź dalej

        # Jeśli parzysty
        add     %esi, %r9d          # dodaj do sumy parzystych

sprawdz_ujemne:
        cmp     $0, %esi
        jge     dalej               # jeśli >=0, idź dalej

        # Jeśli ujemny
        inc     %r10d               # zwiększ licznik liczb < 0

dalej:
        inc     %r8d                # i++
        jmp     petla

koniec_petli:

#################################################################
# Wypisanie wyników zadania 1 i 2
#################################################################

        # Przygotowanie argumentów do printf (w odpowiednich rejestrach wg ABI System V)
        mov     %r10d, %esi         # 2. argument: liczba < 0 -> %esi
        mov     %r9d, %edi          # 1. argument: suma parzystych -> %edi
        lea     text_a(%rip), %rdi  # format string -> %rdi
        xor     %rax, %rax          # brak zmiennych zmiennoprzecinkowych
        call    printf

#################################################################
# Zadanie ratunkowe
#################################################################

        # printf("%s nr albumu %d\n", name, nr_albumu);

        lea     text_c(%rip), %rdi  # format string
        lea     name(%rip), %rsi    # pierwszy argument: wskaźnik na imię
        mov     nr_albumu(%rip), %edx  # drugi argument: numer albumu
        xor     %rax, %rax
        call    printf

#################################################################

# Koniec programu
        pop     %rbp
        xor     %rax, %rax
        ret
