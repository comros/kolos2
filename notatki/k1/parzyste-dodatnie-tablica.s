##############################################################################
#       Wypisać w konsoli liczbę dodatnich i parzystych liczb w tablicy       #
###############################################################################

.data

.equ            tableSize, 10
table:          .long -1, 2, -3, 4, -5, 6, -7, 8, -9, 10
positiveCount:  .long 0
evenCount:      .long 0

returnString:   .string "Positive count: %d, even count: %d\n"
#positive = dodatnie, even = parzyste

.text
.global main
main:
        PUSH    %rbp                # zapszanie ramki stosu
        XOR     %ecx, %ecx              # %ecx iterator petli = 0
loop:
        CMP     $tableSize, %ecx        # sprawdzenie czy iterator nie przekroczyl rozmiaru tab
        JE      end                     # jesli ta to koniec

        MOV     table(,%ecx,4), %eax    # przeniesienie wartosci z tablicy do rejestru
        CALL    isEven          # wywolanie funkcji isEven - czy parzysta
        CALL    isPositive      # wywolanie funkcji isPositive - czy dodatnia

        INC     %ecx            # inkrementacja iteratora
        JMP     loop            # powrot do petli

end:

        MOV     $returnString, %rdi     # adres formatu
        MOV     positiveCount, %esi   # liczba dodatnich
        MOV     evenCount, %edx    # liczba parzystych
        XOR     %al, %al          # zerowanie rejestru %al
        CALL    printf       # wywolanie printf

        POP     %rbp            # przywracanie ramki stosu
        XOR     %eax, %eax    # zerowanie rejestru %eax
        RET  # koniec programu

###################################
.type isEven, @function

# Input:  %rax - number
# Increments evenCount if even

isEven:
        PUSH    %r8  #zapis do rejestru %r8
        TEST    $1, %eax  # sprawdzenie czy liczba jest parzysta
        JNZ     .notEven  # jesli nie to skok do notEven
        MOV     evenCount, %r8d  # przeniesienie liczby parzystych do rejestru
        INC     %r8d  # inkrementacja liczby parzystych
        MOV     %r8d, evenCount  # zwiekszenie liczby parzystych 
.notEven:
        POP     %r8  # przywracanie rejestru %r8
        RET  # koniec funkcji isEven

.type isPositive, @function

# Input: %rax - number
# Increments positiveCount if positive

isPositive:
        PUSH    %r8   #zapis do rejestru %r8
        CMP     $0, %eax  # porownanie liczby z 0
        JL      .negative  # jesli ujemna to skok do negative
        MOV     positiveCount, %r8d   # przeniesienie liczby dodatnich do rejestru
        INC     %r8d  # inkrementacja liczby dodatnich
        MOV     %r8d, positiveCount  # zwiekszenie liczby dodatnich
.negative:
        POP     %r8   # przywracanie rejestru %r8
        RET