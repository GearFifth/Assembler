#Napisati potprogram koji će postaviti paritet za 15-bitnu vrednost (najviši bit je rezervisan za bit pariteta) (z3):
#int SetParity(unsigned short int* vrednost);
#Povratna vrednost je vrednost postavljenog bita pariteta (0 ili 1)
.section .text
.globl SetParity
SetParity:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	movl 8(%ebp), %ecx		#ecx = adresa
	movw (%ecx), %ax		#eax = 16-bitna vrednost
	movw $0, %bx			#brojac jedinica
	movl $15,%esi			#da bih proveravao samo 15 bitova, a ne 16
petlja:						#broji koliko ima jedinica
	cmpl $0, %esi
	je provera
	testw $1, %ax
	jz dalje
	incw %bx
dalje:
	shrw $1, %ax
	decl %esi
	jmp petlja
provera:			#proveravam da li ima paran ili neparan broj jedinica
	movw (%ecx), %ax
	testw $1, %bx
	jz paran
	orw $0x8000, %ax
	movl $1, %edx
	jmp kraj
paran:
	andw $0x7fff, %ax
	movl $0, %edx
kraj:
	movw %ax, (%ecx)	#ovim menjam originalnu vrednost
	movl %edx, %eax		#ovo je return
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
	
	
