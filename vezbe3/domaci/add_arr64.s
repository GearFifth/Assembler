#Operacija sabiranja dva niza c[i] = a[i] + b[i], dvostruka preciznost
# Ilija Beslin sv71/2021 03.11.2021.
.section .data
Nelem: .long 4
niz1: .quad 25,40,8589,61245
niz2: .quad 64,7456,875314,33217
rez: .quad 0,0,0,0
.section .text
.global main
main:
	movl $0, %ebx
petlja:
	cmpl $0, Nelem
	je kraj
	movl niz1(,%ebx,4), %eax		#niza 4 bajta prvog niza stavljam u eax
	addl niz2(,%ebx,4), %eax		#niza 4 bajta drugog niza normalno sabiram sa eax
	movl %eax, rez(,%ebx,4)			#rezultat smestam u niz sa rezultatima
	incl %ebx
	movl niz1(,%ebx,4), %eax		#visa 4 bajta prvog niza smestam u eax
	adcl niz2(,%ebx,4), %eax		#visa 4 bajta drugog niza sabiram sa prenosom sa eax
	movl %eax, rez(,%ebx,4)	
	incl %ebx
	decl Nelem
	jmp petlja
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
