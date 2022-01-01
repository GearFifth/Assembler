.section .text
.global convert_base
convert_base:		#convert_base(*string,*greska)	unutar eax-a mi se nalazi rezultat koji se vraca
	pushl %ebp
	movl %esp, %ebp
 	pushl $10       #baza za konverziju
	pushl %ebx
	pushl %esi
	pushl %edi
incijalizacija:
	movl 8(%ebp), %ecx	#ecx = trenutni polozaj pokazivaca na string
	xorl %eax, %eax	#eax = rez, postavljam ga na nulu na pocetku
	xorl %ebx, %ebx
	xorl %edx, %edx
petlja:
	movb (%ecx), %bl
	cmpb $10, %bl		#pitam da li je \n karakter i ako jeste to je kraj stringa
	je check
	subb $48, %bl
	cmpb $9, %bl
	ja greska1		#ako broj nije izmedju 0 i 9
	cmpb $0, %bl
	jb greska1
	mull -4(%ebp)
	addl %ebx, %eax
	incl %ecx
	jmp petlja
check:
	cmpl $16, %eax
	ja greska2
	cmpl $2, %eax
	jl greska2
	jmp kraj
greska1:
	movl 12(%ebp), %esi
	movl $1, (%esi)
	jmp kraj
greska2:
	movl 12(%ebp), %esi
	movl $2, (%esi)
	jmp kraj
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
