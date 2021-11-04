#nije gotov program, samo sam krenuo da radim pa sam prekinut u toku casa
.section .data
NELEM = 5
niz: .long -5,2,6,-3,9
min: .long 0
max: .long 0

.section .text
.global main

main:
	movl $niz, %esi
	movl (%esi), %ebx #ebx - min
	movl (%esi), %ecx #ecx - max
	#movl $0, %eax

petlja:
	#addl (%esi), %eax
	cmpl (%esi), (%esi)+4
	jl smanji
nastavak:

	addl $4, %esi
	cmpl $niz+NELEM*4, %esi
	jl petlja

smanji:
	movl (%esi)+4, %ebx


kraj:
	movl %eax, suma
	movl $1, %eax
	movl $0, %ebx
	int $0x80


