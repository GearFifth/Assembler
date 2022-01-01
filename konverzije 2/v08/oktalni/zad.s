#unsigned int oct_str_to_inter(char* str, unsigned int* greska);
.section .text
.globl oct_str_to_inter
oct_str_to_inter:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	pushl %ebx
	pushl %esi
	pushl %edi
pocetak:
	movl 8(%ebp), %esi
	movl $0, -4(%ebp) #Greska
	xorl %eax, %eax	#rez = 0
	xorl %ebx, %ebx
	movl $8, %ecx	#baza
petlja:
	movb (%esi), %bl	#stavljam trenutni karakter u bl
	andb %bl, %bl
	jz kraj_dec		#skacem na proveru da li je kraj
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
kraj_dec:
	cmpl 8(%ebp), %esi		#ako su jednako to znaci da se pokazivac esi nije ni pomerio 
	jne kraj 				#i da je na prvom mestu \0 sto je greska
greska:
	incl -4(%ebp)	#povecavam gresku
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
