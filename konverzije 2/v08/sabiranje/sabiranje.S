# Program za sabiranje dva broja u proizvoljnoj bazi
# Imenko Prezimić ra1234

# Napisati asemblerski program koji, koristeći potprograme za konverziju
# za bilo koju bazu 2‑36, vrši sabiranje dva neoznačena cela broja data u
# znakovnom obliku i rezultat vraća u znakovnom obliku. Sve konverzije
# raditi odmah nakon unosa, a u slučaju greške prekinuti dalji rad
# programa i ispisati odgovarajuću poruku. Primer korišćenja:
#       Unesite bazu broja:16
#       Unesite broj:Fa
#       Unesite bazu broja:8
#       Unesite broj:123
#       Unesite bazu rezultata:2
#       Rezultat:101001101
# Za ostale primere pokrenuti testiraj.sh.
# Dodatni primeri se mogu napraviti pomoću kalkulatora (Accessories/Calculator)

#convert_base(*string,*greska)	unutar eax-a mi se nalazi rezultat koji se vraca
#convert_text_to_int(*string,baza,*greska)
#convert_int_to_text(broj,baza,*rez)	#duzina je u eax-u

.section .data
ulaz1:      .ascii "Unesite bazu broja:\0"
ulaz1_len = . - ulaz1
ulaz2:      .ascii "Unesite broj:\0"
ulaz2_len = . - ulaz2
ulaz3:      .ascii "Unesite bazu rezultata:\0"
ulaz3_len = . - ulaz3
izlaz1:     .ascii "Rezultat:\0"
izlaz1_len = . - izlaz1
greska1:    .ascii "Greska: pogresan znak!\0"
greska1_len = . - greska1
greska2:    .ascii "Greska: prekoracenje!\0"
greska2_len = . - greska2
input_baza1: .fill 3,1,42
input_baza1_len = . - input_baza1
input_broj1: .fill 30,1,42
input_broj1_len = . - input_broj1
input_baza2: .fill 3,1,42
input_baza2_len = . - input_baza2
input_broj2: .fill 30,1,42
input_broj2_len = . - input_broj2
input_bazarez: .fill 30,1,42
input_bazarez_len = . - input_bazarez
base1: .long 0
base2: .long 0
num1: .long 0
num2: .long 0
bazarez: .byte 0
rezultat: .fill 30,1,42
rezultat_len: .long 0
greska: .long 0
.section .text
.global main
main: 
	movl $4, %eax
	movl $1, %ebx
	leal ulaz1, %ecx
	movl $ulaz1_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	leal input_baza1, %ecx
	movl $input_baza1_len, %edx
	int $0x80

	pushl $greska
	pushl $input_baza1
	call convert_base
	addl $8, %esp	#oslobadjanje prostora na steku
	cmpl $1, greska
	je greska1_ispis
	cmpl $2, greska
	je greska2_ispis
	movl %eax, base1
unos_broja1:
	movl $4, %eax
	movl $1, %ebx
	leal ulaz2, %ecx
	movl $ulaz2_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	leal input_broj1, %ecx
	movl $input_broj1_len, %edx
	int $0x80

	pushl $greska
	pushl base1
	pushl $input_broj1
	call convert_text_to_int
	addl $12, %esp
	cmpl $1, greska
	je greska1_ispis
	cmpl $2, greska
	je greska2_ispis
	movl %eax, num1

unos_baze2:
	movl $4, %eax
	movl $1, %ebx
	leal ulaz1, %ecx
	movl $ulaz1_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	leal input_baza2, %ecx
	movl $input_baza2_len, %edx
	int $0x80

	pushl $greska
	pushl $input_baza2
	call convert_base
	addl $8, %esp	#oslobadjanje prostora na steku
	cmpl $1, greska
	je greska1_ispis
	cmpl $2, greska
	je greska2_ispis
	movl %eax, base2

unos_broja2:
	movl $4, %eax
	movl $1, %ebx
	leal ulaz2, %ecx
	movl $ulaz2_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	leal input_broj2, %ecx
	movl $input_broj2_len, %edx
	int $0x80

	pushl $greska
	pushl base2
	pushl $input_broj2
	call convert_text_to_int
	addl $12, %esp
	cmpl $1, greska
	je greska1_ispis
	cmpl $2, greska
	je greska2_ispis
	movl %eax, num2

unos_bazerez:
	movl $4, %eax
	movl $1, %ebx
	leal ulaz3, %ecx
	movl $ulaz3_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	leal input_bazarez, %ecx
	movl $input_bazarez_len, %edx
	int $0x80

	pushl $greska
	pushl $input_bazarez
	call convert_base
	addl $8, %esp	#oslobadjanje prostora na steku
	cmpl $1, greska
	je greska1_ispis
	cmpl $2, greska
	je greska2_ispis
	movl %eax, bazarez
saberi:
	movl num1, %eax
	movl num2, %ebx
	addl %ebx, %eax
	jc greska2_ispis
cnvrt_to_string:	#convert_int_to_text(broj,baza,*rez)	duzina je u eax-u
	pushl $rezultat
	pushl bazarez
	pushl %eax
	call convert_int_to_text
	addl $12, %esp
	movl %eax, rezultat_len
ispis:
	movl $4, %eax               #rezultat
    movl $1, %ebx
    movl $izlaz1, %ecx
    movl $izlaz1_len, %edx
    int $0x80

    movl $4, %eax               #rezultat
    movl $1, %ebx
    movl $rezultat, %ecx
    movl rezultat_len, %edx
    int $0x80
    jmp kraj
greska1_ispis:
	movl $4, %eax
	movl $1, %ebx
	leal greska1, %ecx
	movl $greska1_len, %edx
	int $0x80
	jmp kraj
greska2_ispis:
	movl $4, %eax
	movl $1, %ebx
	leal greska2, %ecx
	movl $greska2_len, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
