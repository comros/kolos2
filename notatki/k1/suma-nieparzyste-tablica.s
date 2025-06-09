###############################################################################
#       Wypisać w konsoli sumę i liczbę nieparzystych liczb w tablicy         #
###############################################################################

.data

.equ            tableSize, 10
table:          .long -1, 2, -3, 4, -5, 6, -7, 8, -9, 10
sum:            .long 0
oddCount:       .long 0

returnString:   .string "Sum: %d, odd count: %d\n"

.text
.global main
main:
        PUSH    %rbp  # zapisz ramkę stosu
        XOR     %ecx, %ecx              # %ecx iterator petli
loop:
        CMP     $tableSize, %ecx        # sprawdzenie czy %ecx >= tableSize
        JE      end     #jesli ta to koniec

        MOV     table(,%ecx,4), %eax    # Move the value of the current table element (%ecx, 4baits) into %eax
        CALL    isOdd              # Call isOdd function to check if the number is odd
        MOV     sum, %ebx              # Move the current sum into %ebx
        ADD     %eax, %ebx  #dodaj wartosc do sumy
        MOV     %ebx, sum              # Store the updated sum back to the variable

        INC     %ecx  #zwieksz licznik o 1
        JMP     loop

end:

        MOV     $returnString, %rdi
        MOV     sum, %esi
        MOV     oddCount, %edx
        XOR     %al, %al
        CALL    printf

        POP     %rbp
        XOR     %eax, %eax
        RET

###################################
.type isOdd, @function

# Input:  %rax - number
# Increments oddCount if even

isOdd:
        PUSH    %r8   #save current value of %r8
        TEST    $1, %eax       # Check if the number is odd, if 1, it is odd
        JZ      .notOdd         # If it is not odd, jump to .notOdd
        MOV     oddCount, %r8d      # Move oddCount to %r8d
        INC     %r8d                # Increment oddCount
        MOV     %r8d, oddCount       # Store the incremented value back to oddCount
.notOdd:
        POP     %r8
        RET