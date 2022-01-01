#unsigned int inter_to_oct_str(unsigned int broj, char* str, unsigned int duzina)
.section .text
.globl inter_to_oct_str
inter_to_oct_str:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
inicijalizacija:
	movl 8(%ebp), %eax		#eax = broj
	movl 12(%ebp), %ebx 	#ebx = adresa stringa
	movl $1, %ecx 			# sa registrom ecx proveravam da li je izaslo van opsega
	movl $8, %esi			#esi =- baza
	movl 16(%ebp), %edi
petlja:
	cmpl 16(%ebp), %ecx
	je greska
	xorl %edx, %edx			#postavlja edx na 0
	divl %esi
	addb $'0', %dl
	movb %dl, (%ebx)
	incl %ebx
	incl %ecx
	andl %eax, %eax			#proverava da li je eax 0
	jnz petlja
	movb $0, (%ebx)			#stavlja nulu na kraju
	decl %ebx				#ebx pokazuje na poslednji element
	movl 12(%ebp), %ecx		#ecx je pokazivac na pocetak stringa
obrni:
	cmpl %ebx, %ecx
	jae pre_kraj
	movb (%ebx), %ah
	movb (%ecx), %al
	movb %ah, (%ecx)
	movb %al, (%ebx)
	decl %ebx
	incl %ecx
	jmp obrni
greska:
	movl $1, %eax
	jmp kraj
pre_kraj:
	movl $0, %eax			#nema greske
kraj:
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
