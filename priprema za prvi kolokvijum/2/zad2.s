#void shiftujDvostruko(unsigned long long *a, unsigned char *b, unsigned n)
.section .text
.globl shiftujDvostruko
shiftujDvostruko:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	movl $0, %ecx	#indeksni registar
petlja:
	cmpl %ecx, 16(%ebp)
	je kraj
	movb (%ebx,%ecx,1), %dl			#dl = broj koliko puta pomeram bite
	testl $1, %ecx		#proverava da li je paran ili neparan indeks
	jnz paran
neparan:			#pomeram u levu stranu ako je neparan
	cmpb $0, %dl
	je vrati
	shll $1,(%eax,%ecx,8)
	rcll $1,4(%eax,%ecx,8)
	decb %dl
	jmp neparan
paran:				#pomeram u desnu stranu ako je paran
	cmpb $0, %dl
	je vrati
	shrl $1,(%eax,%ecx,8)
	rcrl $1,4(%eax,%ecx,8)
	decb %dl
	jmp paran
vrati:
	incl %ecx
	jmp petlja
kraj:
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
