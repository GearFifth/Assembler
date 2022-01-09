#text_to_int(*string,*greska), rezultat u eax-u
.section .text
.globl text_to_int
text_to_int:
	pushl %ebp
	movl %esp, %ebp
	pushl $10
	pushl %ebx
	pushl %esi
	pushl %edi
inc1:
	movl 8(%ebp), %esi
	movl 12(%ebp), %edi
	movl $0, (%edi)
	xorl %eax, %eax
provera1:
	xorl %ebx, %ebx
	movb (%esi), %bl
	cmpb $0, %bl
	je kraj1
	cmpb $'0', %bl
	jb greska2
	cmpb $'9', %bl
	ja greska2
petlja1:
	subb $48, %bl
	mull -4(%ebp)
	jc greska3
	addl %ebx, %eax
	jc greska3
	incl %esi
	jmp provera1
greska2:
	movl $2, (%edi)
	jmp kraj1
greska3:
	movl $3, (%edi)
	jmp kraj1
kraj1:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
