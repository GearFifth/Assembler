#int oct_str_to_inter(char* str, unsigned int* greska);
.section .text
.globl oct_str_to_inter
oct_str_to_inter:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	pushl %ebx
	pushl %esi
	pushl %edi
pocetak:
	movl 8(%ebp), %esi
	movl $0, -4(%ebp) #Greska
	xorl %eax, %eax	#rez = 0
	xorl %ebx, %ebx
	movl $8, %ecx	#baza
	movl $0, -8(%ebp)	#indikator negativnog broja
provera_neg_broja:
	movb (%esi), %bl
	cmpl $'-', %ebx
	jne provera_plus
	incl -8(%ebp)
	incl %esi
	incl 8(%ebp)
	jmp petlja
provera_plus:
	cmpl $'+', %ebx
	jne petlja
	incl %esi
	incl 8(%ebp)
petlja:
	movb (%esi), %bl	#stavljam trenutni karakter u bl
	andb %bl, %bl
	jz if_neg		#skacem na proveru da li je kraj
	subb $'0', %bl	#ovo radim da bi dobio cifru
	js greska		#ako je broj negativan to znaci da taj karakter nije broj
	cmpl %ecx, %ebx
	jae greska		#ako je broj veci od zadate baze to je greska
	mull %ecx
	jc greska		#moram i ovde proveriti
	addl %ebx, %eax	
	jc greska		#ako se pojavi carry to znaci da je izasao iz 32 bita
	incl %esi 	#sledeci znak
	jmp petlja
greska:
	incl -4(%ebp)	#povecavam gresku
	jmp kraj
if_neg:
	cmpl 8(%ebp), %esi
	je greska
	andl %eax, %eax
	js check_overflow 		#ako je neoznačeni broj veći od 0x7fffffff
	jmp pred_kraj
check_overflow:
	cmpl $1, -8(%ebp)		#proveravam da li je indikator negativnog broja postasvljen na 1
	je kraj	
	jmp greska
pred_kraj:
	cmpl $0, -8(%ebp)			#ako je indikator negativnog broja 1 onda negiram ceo broj
	je kraj
	negl %eax
kraj:
	movl 12(%ebp), %ebx
	movl -4(%ebp), %edx
	movl %edx, (%ebx)
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
