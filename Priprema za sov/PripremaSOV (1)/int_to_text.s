#konverzija internog u oktalni tekstualni oblik
#convert_int_to_text(broj,*rez) eax = duzina
.section .text
.globl convert_int_to_text
convert_int_to_text:
	pushl %ebp
	movl %esp, %ebp
	pushl $8	#baza
	pushl $0	#duzina
	pushl %ebx
	pushl %esi
	pushl %edi
inc2:
	movl 8(%ebp), %eax
	movl 12(%ebp), %esi
petlja2:
	xorl %edx, %edx
	divl -4(%ebp)
	addb $48, %dl
	movb %dl, (%esi)
	incl %esi
	incl -8(%ebp)
	cmpl $0, %eax
	je obrni_pre
	jmp petlja2
obrni_pre:
	movb $0, (%esi)
	movl 12(%ebp), %ecx
	decl %esi
obrni:
	cmpl %ecx, %esi
	jbe kraj2
	movb (%ecx), %bl
	movb (%esi), %bh
	movb %bh, (%ecx)
	movb %bl, (%esi)
	incl %ecx
	decl %esi
	jmp obrni
kraj2:
	movl -8(%ebp), %eax
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
