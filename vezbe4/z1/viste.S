.section .data
poruka1: .ascii "Unesite ime i prezime: \0"
poruka1_len = . - poruka1
poruka2: .ascii "Vi ste: \0"
poruka2_len = . - poruka2
imeprez: .fill 50,1,42
.section .text
.global main
main:
	movl $0, %edi 
	movl $4, %eax
	movl $1, %ebx
	leal poruka1, %ecx
	movl $poruka1_len, %edx
	int $0x80
unos:
	movl $3, %eax
	movl $0, %ebx
	leal imeprez, %ecx
	movl $50, %edx
	int $0x80
	movl %eax, %esi		#unutar eax-a se nalazi duzina
for:					#povecava slova
	cmpl %esi, %edi
	je ispis
	cmpb $96, imeprez(,%edi,1)
	jg povecaj
	incl %edi
	jmp for
povecaj:
	subb $32, imeprez(,%edi,1)
	incl %edi
	jmp for
ispis:
	movl $4, %eax
	movl $1, %ebx
	leal poruka2, %ecx
	movl $poruka2_len, %edx
	int $0x80
ispis_imena:
	movl $4, %eax
	movl $1, %ebx
	leal imeprez, %ecx
	movl %esi, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	


