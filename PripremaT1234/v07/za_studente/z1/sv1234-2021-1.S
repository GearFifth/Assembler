#autor: Imenko Prezimić INDEX ra1234-2018
.section .data
str_max = 50
unos: .fill str_max,1,42
prompt_1: .ascii "Unesite string: \0"
prompt_1len = . - prompt_1
prompt_2: .ascii "Enkodovan string: \0"
prompt_2len = . - prompt_2
.section .text
.globl main
main:
	movl $4, %eax		#ovo ispisuje "Unesite string"
	movl $1, %ebx
	leal prompt_1, %ecx
	movl $prompt_1len, %edx
	int $0x80
preuzmi:			#ovim preuzimamo unet string
	movl $3, %eax		
	movl $0, %ebx
	leal unos, %ecx
	movl $str_max, %edx
	int $0x80
	movl %eax, %esi		#esi = broj unetih karaktera
	movl %esi, %edi		#edi = cuva vrednost esi-ja posto ce se esi kasnije smanjivati
ispis:
	movl $4, %eax		#ovo ispisuje "Enkodovan string"
	movl $1, %ebx
	leal prompt_2, %ecx
	movl $prompt_2len, %edx
	int $0x80
petlja:
	cmpl $0, %esi
	jl enkodovan
provera:		#proveravam da li je slovo ili nije
	cmpb $65, unos(,%esi,1)
	jl vrati
	cmpb $91, unos(,%esi,1)
	jl veliko_slovo
	cmpb $97, unos(,%esi,1)
	jl vrati
	cmpb $123, unos(,%esi,1)
	jl malo_slovo
	jmp vrati
malo_slovo:
	cmpb $99, unos(,%esi,1)
	jg dalje1		#ako je broj veci od 99 necu sabirati sa 26
	addb $26, unos(,%esi,1)
dalje1:
	subb $3, unos(,%esi,1)
	jmp vrati
veliko_slovo:
	cmpb $67, unos(,%esi,1)
	jg dalje2		#ako je broj veci od 67 necu sabirati sa 26
	addb $26, unos(,%esi,1)
dalje2:
	subb $3, unos(,%esi,1)
	jmp vrati
vrati:
	decl %esi
	jmp petlja
enkodovan:
	movl $4, %eax		#ovo ispisuje "Enkodovan string"
	movl $1, %ebx
	leal unos, %ecx
	movl %edi, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
