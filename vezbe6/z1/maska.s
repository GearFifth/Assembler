.section .text
.globl maska
maska:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %ecx #ecx = n
	movl 12(%ebp), %edx #edx = v
provera_greske:
	cmpl $31, %ecx
	ja greska
	cmpl $1, %edx
	ja greska
	je jedan
nula:
	movl $0xfffffffe, %eax
	roll %cl, %eax		#rotirace za toliko mesta koliko se nalazi u registru cl, MORA DA PISE CL a ne ECX
	jmp kraj
jedan:
	movl $1, %eax
	roll %cl, %eax
	jmp kraj
greska:
	movl $0, %eax
kraj:
	movl %ebp, %esp
	popl %ebp
	ret
