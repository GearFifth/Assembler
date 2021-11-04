#sortiranje niza znakova po abecedi
# Ilija Beslin sv71/2021 03.11.2021

.section .data
string: .ascii "lkgahqwuoiyrqourt\0"
brojac: .byte 0
.section .text
.global main
main:
	movl $string, %eax
	movl $string, %ecx
	incl %ecx		
petlja1:			#prva petlja
	cmpb $0, (%eax)
	je kraj
	jmp petlja2
petlja2:			#podpetlja koja ide po svim karakterima
	cmpb $0, (%ecx)
	je povecaj
	movb (%ecx), %bl
	cmpb (%eax), %bl
	jb manje
	incl %ecx
	jmp petlja2
manje:				#soljice
	movb (%eax), %dl
	movb %dl, (%ecx)
	movb %bl, (%eax)
	incl %ecx
	jmp petlja2
povecaj:			#prelazi na sledeci karakter u nizu
	incl %eax
	movl %eax, %ecx
	incl %ecx
	jmp petlja1
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
