################################################################
#
# program ma scalic ciagi str1 i str3 zapisujac calosc do str2:
# 
# "abcdefgh\0" + "12345678\0" -> "abcdefgh12345678\0".
#
# Nalezy wydrukowac ciag str2 w oknie terminala.
#
# wydrukowanie ciagow str1 i str2
# funkcja System Call.

#################################################################

# gcc -nostartfiles -no-pie -o [nazwa-wyjsscia] [nazwa-pliku].s 

.data

str1:		.asciz	"abcdefgh"
str2:		.asciz	"----------------\n"
str3:		.asciz	"12345678"

#################################################################

.global	_start
.text

_start:

# Inicjuj zmienne wartosciami poczatkowymi.
    MOV $0, %ecx		# licznik elementow ciagu str1
    MOV $0, %edx		# licznik elementow ciagu str3

petla1:

# odczytanie elementow ciagow.

    mov	str1(,%ecx,1) , %al
    CMPB $0, %al		# porownanie ze znakiem konca linii
    JE petla2		# jezeli zero to koniec petli

    MOV %al, str2(,%ecx,1)	# skopiowanie elementu do str2
    INC %ecx		# inkrementacja licznika elementow ciagu str1

    JMP petla1

petla2:
    mov	str3(,%edx,1) , %al
    CMPB $0, %al		# porownanie z zerem
    JE koniec		# jezeli zero to koniec petli

    MOV %al, str2(,%ecx,1)	# skopiowanie elementu do str2
    INC %ecx		# inkrementacja licznika elementow ciagu str3
    INC %edx		# inkrementacja licznika elementow ciagu str3

    jmp	petla2

koniec:

# Wyswietl wynik - ciag "str2" wywolujac System Call.
    MOV $1, %eax		# System Call nr 1 - write
    MOV $1, %edi		# deskryptor pliku stdout
    MOV $str2, %esi		# adres bufora do wyslania
    INC %ecx		# dlugosc bufora do wyslania
    MOV %ecx, %edx		# dlugosc ciagu do wyslania w bajtach
    syscall        # wywolanie System Call

#wyswietlanie bezpetlowe

# Wyswietl ciag str1
#    MOV $1, %eax        # System Call nr 1 - write
#    MOV $1, %edi        # deskryptor pliku stdout
#    MOV $str1, %esi     # adres bufora do wyslania
#    MOV $9, %edx        # dlugosc ciagu str1 w bajtach (8 znakow + '\0')
#    syscall             # wywolanie System Call

# Wyswietl ciag str2
#    MOV $1, %eax        # System Call nr 1 - write
#    MOV $1, %edi        # deskryptor pliku stdout
#    MOV $str2, %esi     # adres bufora do wyslania
#    MOV $17, %edx       # dlugosc ciagu str2 w bajtach (16 znakow + '\n')
#    syscall             # wywolanie System Call
#

# Wywolaj System Call nr 60 - EXIT
    MOV $60, %eax		# System Call nr 60 - exit
    MOV %edi, %edi		# kod wyjscia 0

    syscall

################################################################
