.section .text
.globl saberi_niz
saberi_niz:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	movl 20(%ebp), %esi 		#esi = n
	movl $0, %edi 			#Indeksni registar
petlja:
	cmpl $0, %esi
	je kraj

	movl 8(%ebp), %ecx
	movl (%ecx,%edi,4), %eax		#low A
	movl 12(%ebp), %ecx
	movl (%ecx,%edi,4), %edx		#low B
	addl %edx,%eax
	movl 16(%ebp), %ecx				#low adresa i-tog elementa niza C
	movl %eax, (%ecx,%edi,4)
	incl %edi

	movl 8(%ebp), %ecx
	movl (%ecx,%edi,4), %eax		#high A
	movl 12(%ebp), %ecx
	movl (%ecx,%edi,4), %edx		#high B
	adcl %edx,%eax
	jo greska
	movl 16(%ebp), %ecx				#high adresa i-tog elementa niza C
	movl %eax, (%ecx,%edi,4)
	incl %edi
	decl %esi
	jmp petlja

greska:
	movl $1, %eax
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
kraj:
	movl $0, %eax
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
	
