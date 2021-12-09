.section .data

poruka1: .ascii "Unesite string: \0"
poruka1_len = . - poruka1
poruka2: .ascii "Izlazni kod programa: \0"
poruka2_len = . - poruka2
unos: .fill 40,1,42
samoglasnici: .ascii "AaEeIiOoUu\0"
brojac: .long 0

.section .text
.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	leal poruka1, %ecx
	movl $poruka1_len, %edx
	int $0x80
korisnik:
	movl $3, %eax
	movl $0, %ebx
	leal unos, %ecx
	movl $40, %edx
	int $0x80
	movl %eax, %esi		#esi = broj unetih karaktera
	movl $0, %eax
petlja1:				#krece se po unetim karakterima
	cmpl %esi, %eax
	je ispis
	movb unos(,%eax,1), %bl
	movl $0, %ecx
petlja2:				#krece se po samoglasnicima
	cmpl $0, samoglasnici(,%ecx,1)	
	je petlja1_dalje
	cmpb %bl, samoglasnici(,%ecx,1)
	jne dalje
	incl brojac
dalje:
	incl %ecx
	jmp petlja2
petlja1_dalje:
	incl %eax
	jmp petlja1
ispis:
	movl $4, %eax
	movl $1, %ebx
	leal poruka2, %ecx
	movl $poruka2_len, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl brojac, %ebx
	int $0x80
