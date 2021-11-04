.section .data
string: .ascii "  abcd  \0"

.section .text
.global main
main:
	movl $string, %eax
	movl $0, %ebx #brojac spaceova na startu
kraj_s:				#nalazenje kraja stringa
	cmpb $0, (%eax)
	je razmaci
	incl %eax
	jmp kraj_s
razmaci:			#izbacivanje razmaka sa kraja
	cmpb $' ', -1(%eax)
	jne izbaci
	decl %eax
	jmp razmaci
izbaci:
	movb $0, (%eax)
	movl $string, %eax		#resetuje eax
broji_start:			#broji koliko ima spaceova na startu
	cmpb $' ', (%eax)
	jne brisi
	incl %ebx
	incl %eax
	jmp broji_start
brisi:				#pomera string u levo toliko mesta koliko je brojac
	cmpl $0, (%eax)
	je fiksiraj
	movb (%eax), %cl	#ovo ne smem da koristim  -->  movl (%eax), (%ecx)
	movl %eax, %edx		#edx mi je pomocni registar
	subl %ebx, %edx		#pomeram edx u levo za toliko mesta koliko ima razmaka
	movb %cl, (%edx) 
	incl %eax
	jmp brisi
fiksiraj:				#Pomera i nulu sa kraja
	incl %edx
	movb $0, (%edx)
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
