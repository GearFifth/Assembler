#convert_text_to_int(*string,baza,*greska)	#rezultat je u eax-u
.section .text
.global convert_text_to_int
convert_text_to_int:
	pushl %ebp
	movl %esp, %ebp
 	pushl $0		#flag za neg broj
	pushl %ebx
	pushl %esi
	pushl %edi
incijalizacija:
	movl 8(%ebp), %edi	#edi = trenutni polozaj pokazivaca na string
	movl 12(%ebp), %ebx
	movl 16(%ebp), %esi
	movl $0, (%esi)		#postavljam gresku 0 na pocetku
	xorl %eax, %eax	#eax = rez, postavljam ga na nulu na pocetku
	xorl %edx, %edx
	xorl %ecx, %ecx
provera_znaka:
	movb (%edi), %cl
	cmpb $'-', %cl
	jne plus
	incl -4(%ebp)
	incl %edi
	incl 8(%ebp)
plus:
	cmpb $'+', %cl
	jne petlja
	incl %edi
	incl 8(%ebp)
petlja:
	movb (%edi), %cl
	cmpb $10, %cl
	je provera_overflowa
    cmpb $48, %cl
    jb greska1                #greska u nedozvoljenom karatkeru
    cmpb $58, %cl
    jb cnvrtasdecimal
    cmpb $65, %cl
    jb greska1 
    cmpb $71, %cl
    jb cnvrtasletterup
    cmpb $97, %cl
    jb greska1 
    cmpb $103, %cl
    jb cnvrtasletterlow
    jmp greska1 
cnvrtasdecimal:
	subb $48, %cl		#jer je $48='0'
    cmpl %ebx, %ecx
    jae greska1           #greska u nedozvoljenom karatkeru
    mull %ebx
    jc greska2           #carry greska
    addl %ecx, %eax
    jc greska2
    incl %esi
    jmp for
cnvrtasletterup:
	subb $55, %cl
	cmpl %ebx, %ecx
	jae greska1
	mull %ebx
	jc greska2
	addl %ecx, %eax
	jc greska2
	incl %esi
	jmp for
cnvrtasletterlow:
	subb $87, %cl
	cmpl %ebx, %ecx
	jae greska1
	mull %ebx
	jc greska2
	addl %ecx, %eax
	jc greska2
	incl %esi
	jmp for
provera_overflowa:
	andl %eax, %eax
	js proveri_neg
	cmpl $1, -4(%ebp)
	jne kraj
	negl %eax
	jmp kraj
proveri_neg:
	cmpl $1, -4(%ebp)	#ako flag != 1 --> greska
	jne greska2
	jmp kraj
greska1:
	movl 16(%ebp), %esi
	movl $1, (%esi)
	jmp kraj
greska2:
	movl 16(%ebp), %esi
	movl $2, (%esi)
	jmp kraj
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
