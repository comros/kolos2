#################################################################
# Program skopiować reprezentujace litery elementy ciagu str1
# do kolejnych bajtow ciagu str2:
# 
# "a2c4e6g8" -> "aceg----"
#
# wydrukowanie tekstu "str1"
# (funkcja system call).
#
#################################################################

.global	_start

.data

str1:		.asciz	"a2c4e6g8\n"
str2:		.asciz	"--------\n"

#################################################################

.text

_start:

# Inicjuj zmienne wartosciami poczatkowymi.
    XOR %ecx, %ecx # %ecx - licznik elementow ciagu str1
    XOR %edx, %edx # %edx - licznik elementow ciagu str2

petla1:
    mov	str1(,%ecx,1) , %al # Odczytaj bajt z ciagu str1
    CMP $0, %al # Sprawdz czy to koniec ciagu
    je koniec # Jezeli tak - skocz do konca

    CMP $'a', %al # Sprawdz czy to litera a
    JL nie # jesli nie to skocz do nie
    CMP $'z', %al # Sprawdz czy to litera z
    JG nie # jesli nie to skocz do nie

    mov %al, str2(,%edx,1) # jesli ta litera to skopiuj ja do str2
    inc %edx # Zwieksz licznik elementow ciagu str2

nie:
    INC %ecx # Zwieksz licznik elementow ciagu str1
    jmp	petla1

koniec:

# Wyswietl wynik - ciag "str2" wywolujac System Call.
    mov $1, %eax # Syscall number for sys_write
    mov $1, %edi # File descriptor 1 (stdout)
    lea str2, %esi # Pointer to the string to print
    INC %ecx # Zwieksz licznik elementow ciagu str2
    mov %ecx, %edx # Length of the string to print
    syscall # Call the kernel

# Wywolaj System Call 60 - EXIT
    MOV $60, %rax # Syscall number for sys_exit
    XOR %edi, %edi # Exit code 0
    syscall

#################################################################

