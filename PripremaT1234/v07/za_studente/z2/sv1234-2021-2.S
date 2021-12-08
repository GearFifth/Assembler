#autor: Imenko Prezimić INDEX ra1234-2015
#int encode(char* izvorni, char* ciljni, char* enkodovati);
.section .text
.globl encode
encode:
	pushl %ebp
	movl %esp, %ebp
	pushl $0	#brojac = 0
	pushl %ebx		
	pushl %esi
	pushl %edi
 	movl 8(%ebp), %ecx
	movl 12(%ebp), %edi
	movl 16(%ebp), %eax
	movl $0, %esi		#esi = indeksni registar za enkodovani
petlja1:			#iterira po enkodovanom stringu
	cmpb $0, (%eax, %esi, 1)
	je kraj
	movl $0, %ebx		#ebx = indeksni registar za izvorni i ciljni
petlja2:
	cmpb $0, (%ecx, %ebx, 1)
	je vrati
	movb (%ecx, %ebx, 1), %dl		#dl = karakter koji trazim
	cmpb %dl, (%eax, %esi, 1)
	jne nastavi
	movb (%edi,%ebx,1), %dl			#dl postavljam na karakter koji treba da ubacim
	movb %dl, (%eax, %esi, 1)
	incl -4(%ebp)		#poveca brojac za 1 ukoliko je izvrsena zamena
	jmp vrati
nastavi:
	incl %ebx
	jmp petlja2
vrati:
	incl %esi
	jmp petlja1
kraj:
	popl %edi
	popl %esi
	popl %ebx
	popl %eax	#smestam vrednost brojaca u eax
	movl %ebp, %esp
	popl %ebp
	ret
