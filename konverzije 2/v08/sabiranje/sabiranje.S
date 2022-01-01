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
.section .text
.global text_to_int
text_to_int:		#text_to_int(*string,baza,*rez)
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp	#promenljiva
	pushl %ebx
	pushl %esi
	pushl %edi
incijalizacija:
	
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret


.global int_to_text
int_to_text:
.global main
main: 
