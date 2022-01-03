#convert_int_to_text(broj,baza,*rez)	#duzina je u eax-u
.section .text
.global convert_int_to_text
convert_int_to_text:
	pushl %ebp
	movl %esp, %ebp
 	pushl $0	#greska
	pushl %ebx
	pushl %esi
	pushl %edi
inicijalizacija:
	movl 8(%ebp), %eax	#broj
	movl 12(%ebp), %ebx 	#baza
	movl 16(%ebp), %esi
	xorl %edi, %edi	#edi = brojac duzine
provera_znaka:
	andl %eax, %eax
	jns petlja
	negl %eax
	movb $'-', (%esi)
	incl %esi
	incl 16(%ebp)
petlja:
	xorl %edx, %edx
	divl %ebx
	cmpl $10,%edx	#proveravam da li je ostatak manji od 10 ili je slovo
	jb cnvrt_dec
	addl $55, %edx
	movb %dl, (%esi)
	incl %esi
	incl %edi
	andl %eax, %eax
	jz dalje
	jmp petlja
cnvrt_dec:
	addl $48, %edx
	movb %dl, (%esi)
	incl %esi
	incl %edi
	andl %eax, %eax
	jz dalje
	jmp petlja	
dalje:
	movb $0, (%esi)		#stavljam znak za kraj stringa na kraju
	decl %esi
	movl 16(%ebp), %ecx
obrni:
	cmpl %ecx, %esi
	jle kraj
	movb (%ecx), %al
	movb (%esi), %ah
	movb %ah, (%ecx)
	movb %al, (%esi)
	incl %ecx
	decl %esi
	jmp obrni
kraj:
	movl %edi, %eax	#vracam duzinu
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
