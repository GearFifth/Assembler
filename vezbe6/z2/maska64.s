.section .text
.globl maska64
maska64:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %ecx #ecx = n
	movl 12(%ebp), %edx #edx = v
provera_greske:
	cmpl $63, %ecx
	ja greska
	cmpl $1, %edx
	ja greska
	je jedan
nula:
	movl $0xfffffffe, %eax
	movl $0xffffffff, %edx
	jmp petlja
jedan:
	movl $1, %eax
	movl $0, %edx
	jmp petlja
petlja:
	cmpl $0, %ecx
	je kraj
	shll $1, %eax		#nizih 32 bita pomeram u levo za 1 i bit najvece vaznosti se smesta u carry
	rcll $1, %edx		#visih 32 bita rotiram u desno tako da se na prvo mesto smesta prethodni carry,a bit najvece vaznosti se smesta u
 						#trenutan carry
	rcrl $1, %eax		#nizih 32 bita rotiram u desno i brisem nepotrebnu 0 koja je dodata u prvom koraku, a ono sto se nalazi u carryju
 						#smestan na bit najvece vaznosti kako bi ga prebacio iz visih 32 u nizih
	roll $1, %eax		#nizih 32 bita rotiram u levo za 1 kako bih bit najvece vaznosti stavio na pocetak
	decl %ecx
	jmp petlja
greska:
	movl $0, %eax
	movl $0, %edx
kraj:
	movl %ebp, %esp
	popl %ebp
	ret
