.section .data

niz1: .word 2,35000,5,22,13,41,85,67,43,3
niz2: .word 45,6,36000,9,23,67,2,78,12,56
n = 10
niz3: .fill n,1,0

.section .text
.globl main
main:
	pushl $niz3
	pushl $niz2
	pushl $niz1
	pushl $n
	call SaberiMnozi
	addl $16, %esp

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
