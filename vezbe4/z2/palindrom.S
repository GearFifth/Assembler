#ne radi govno
.section .data
poruka: .ascii "Unesite string:\0"
poruka_len = . - poruka
nijep:  .ascii "String nije palindrom.\n\0"
nijep_len = . - nijep
jestep: .ascii "String je palindrom.\n\0"
jestep_len = . - jestep
unos:   .fill 50,1,42
brojac: .byte 0
temp: .byte 2
.section .text
.global main
main:
	movl $4, %eax
	movl $1, %ebx
	leal poruka, %ecx
	movl $poruka_len, %edx
	int $0x80
upis:
	movl $3, %eax
	movl $0, %ebx
	leal unos, %ecx
	movl $50, %edx
	int $0x80
	movl %eax, %ebx		#duzina unetog stringa
brojac_razmaka:			#broji koliko ima spaceova u stringu
	leal unos, %eax
	cmpl $0, %edi
	je par_nep			
	decl %edi
	cmpb $' ', (%eax)
	incl %eax
	jne brojac_razmaka	
	incb brojac
	jmp brojac_razmaka
par_nep:				#proverava da li je broj znakova paran ili neparan
	subl brojac, %ebx
	decl %ebx			#oduzimam enter karakter
	movw %bx, %ax
	divb temp
	cmpb $0, %ah
	movb %al, brojac	#brojacu se dodeljuje rezultat deljenja i on postaje brojac za parne
	je par
	jmp nepar
par:
nepar:
	leal unos, %eax
	movl %eax, %ecx
	addl %ebx, %ecx
	subl $1, %ecx		#moguc kvar
provera:
	cmpb $' ', (%eax)
	je preskoci
	cmpb $' ', (%ecx)
	je preskoci2
	movb (%eax), %bl
	cmpl %eax,%ecx
	je jeste
	cmpb %bl, (%ecx)
	jne nije
	incl %eax
	decl %ecx
	jmp provera
preskoci:
	incl %eax
	jmp provera
preskoci2:
	incl %ecx
	jmp provera
jeste:
	movl $4, %eax
	movl $1, %ebx
	leal jestep, %ecx
	movl $jestep_len, %edx
	int $0x80
	jmp kraj
nije:
	movl $4, %eax
	movl $1, %ebx
	leal nijep, %ecx
	movl $nijep_len, %edx
	int $0x80
	jmp kraj
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80


