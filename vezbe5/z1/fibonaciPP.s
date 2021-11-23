.section .text
.globl fibonaci
fibonaci:
	pushl %ebp			
	movl %esp, %ebp
	pushl %esi			#dodam registar %esi preko pushl, kasnije ga izbacim sa popl
	movl 8(%ebp), %eax		#u registru eax se smesta vrednost n
	movl 12(%ebp), %esi		#u registru ecx se smesta adresa rez (ovo je u stvari pokazivac)
	movl $1, %ecx
	movl $0, %ebx
	movl $1, %edx			#ovde se nalazi rezultat
uporedi:
	cmpl $1, %eax			#smanjujem brojac do 1
	je kraj
	addl %ebx, %edx
	jc greska
	movl %ecx, %ebx
	movl %edx, %ecx
	subl $1, %eax
	jmp uporedi
greska:
	movl %edx, (%esi)
	movl $1, %eax
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret
kraj:
	movl %edx, (%esi)
	popl %esi
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret

	
