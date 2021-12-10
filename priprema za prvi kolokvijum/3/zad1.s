.section .data
max_len = 20
S1: .fill max_len,1,42
S2: .fill max_len,1,42
R: .byte 0
poruka1: .ascii "Unesite S1: \0"
poruka1_len = . - poruka1
poruka2: .ascii "Unesite S2: \0"
poruka2_len = . - poruka2
plus1: .long 0
minus2: .long 0
.section .text
.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	leal poruka1, %ecx
	movl $poruka1_len, %edx
	int $0x80
	movl $3, %eax
	movl $0, %ebx
	leal S1, %ecx
	movl $max_len, %edx
	int $0x80
	movl %eax, %esi		#esi = duzina prvog stringa
unos2:
	movl $4, %eax
	movl $1, %ebx
	leal poruka2, %ecx
	movl $poruka2_len, %edx
	int $0x80
	movl $3, %eax
	movl $0, %ebx
	leal S2, %ecx
	movl $max_len, %edx
	int $0x80
	movl %eax, %edi		#edi = duzina drugog stringa
petlja1_pre:
	movl %esi, %eax		#priprema za petlju 1 gde eax postavljam na duzinu prvog stringa
	decl %eax
petlja1:
	cmpl $0, %eax
	jl petlja2_pre
	cmpb $43, S1(,%eax,1)
	jne dalje1
	incl plus1
dalje1:
	decl %eax
	jmp petlja1
petlja2_pre:			#priprema za petlju 2 gde eax postavljam na duzinu drugog stringa
	movl %edi, %eax
	decl %eax
petlja2:
	cmpl $0, %eax
	jl odredi
	cmpb $45, S2(,%eax,1)
	jne dalje2
	incl minus2
dalje2:
	decl %eax
	jmp petlja2
odredi:
	movl plus1, %ecx
	cmpl minus2, %ecx
	jl manje
	jg vise
	movb $3, R
	jmp kraj
manje:
	movb $2, R
	jmp kraj
vise:
	movb $1, R
	jmp kraj
kraj:
	movl $1, %eax
	movl R, %ebx
	int $0x80
