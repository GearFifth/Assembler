#int_to_text(broj,*rez)	#duzina je u eax-u
.section .text
.globl int_to_text
int_to_text:
	pushl %ebp
	movl %esp, %ebp
	pushl $10
	pushl %ebx
	pushl %esi
	pushl %edi
inc2:
	movl 8(%ebp), %eax
	movl 12(%ebp), %esi
	xorl %edi, %edi	#edi = duzina stringa
petlja2:
	xorl %edx, %edx
	divl -4(%ebp)
	addb $48, %dl
	movb %dl, (%esi)
	incl %edi
	incl %esi
	cmpl $0, %eax
	je obrni_pre
	jmp petlja2
obrni_pre:
	movb $0, (%esi)
	decl %esi
	movl 12(%ebp), %ecx
obrni:
	cmpl %ecx, %esi
	jbe kraj2
	movb (%esi), %ah
	movb (%ecx), %al
	movb %ah, (%ecx)
	movb %al, (%esi)
	incl %ecx
	decl %esi
	jmp obrni
kraj2:
	movl %edi, %eax
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
