#int SaberiMnozi(int n, unsigned short *a, unsigned short *b, unsigned short *resenje)
.section .text
.globl SaberiMnozi
SaberiMnozi:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	movl 8(%ebp), %esi		#esi = n
	movl 12(%ebp), %eax	#eax = adresa niza a	
	movl 16(%ebp), %ebx	#ebx = adresa niza b
	movl 20(%ebp), %ecx	#ecx = adresa niza resenje
petlja:
	cmpl $0, %esi		#smanjujem indekse od pozadi do 0
	je kraj
	movl %esi, %edi		#edi je broj indeksa
	decl %edi
	testl $1, %edi
	jz paran
neparan:
	movl 12(%ebp), %ebx
	movw (%ebx,%edi,2), %ax
	movl 16(%ebp), %ebx
	addw (%ebx,%edi,2), %ax
	jc greska
	movw %ax, (%ecx,%edi,2)
	decl %esi
	jmp petlja
paran:
	movl 12(%ebp), %ebx
	movw (%ebx,%edi,2), %ax
	movl 16(%ebp), %ebx
	mulw (%ebx,%edi,2)
	jc greska
	movw %ax, (%ecx,%edi,2)
	decl %esi
	jmp petlja
greska:
	movw $11111, (%ecx,%edi,2)
	decl %esi
	jmp petlja
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
