.section .text
.globl fibonaci
fibonaci:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax		#Stavljam n u eax - n predstavlja koji broj fibonacijevog niza trazimo
	movl 12(%ebp), %edx		#Ovde se nalazi adresa na kojoj se nalazi greska(pokazivac greske)
	cmpl $3, %eax
	jb jedan

	decl %eax
	pushl %edx
	pushl %eax
	call fibonaci
	addl $8, %esp
	pushl %eax			#n-1 sacuva na vrh steka

	movl 8(%ebp), %eax
	subl $2, %eax
	pushl %edx
	pushl %eax
	call fibonaci
	addl $8, %esp
	popl %ecx			#Skidan vrednost sa vrha steka i smestan u ecx = n-1
	addl %ecx, %eax
	jc greska
	jmp kraj
jedan:
	movl $1, %eax			#Ako se trazi prvi ili drugi element rezultat je 1
kraj:
	movl $0, (%edx)			#ovo signalizira da nema greske
	movl %ebp, %esp
	popl %ebp
	ret
greska:
	movl $1, (%edx)
	movl %ebp, %esp
	popl %ebp
	ret

	
