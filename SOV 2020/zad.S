# autor: Imenko Prezimić INDEX ra1234-2017
.section .data
izraz_maks_d = 101
rezultat_str: .fill izraz_maks_d    # ovde smestiti stringovnu reprezentaciju rezultata
# NE MENJATI TEKST PORUKA!
rezultat_str_len: .long 0
poruka_ulaz: .ascii "Unesite izraz: \0"
poruka_ulaz_len = . - poruka_ulaz
poruka_rez: .ascii "Rezultat je: \0"
poruka_rez_len = . - poruka_rez
poruka_greska1: .ascii "Unet je prazan izraz!\n\0"
poruka_greska1_len = . - poruka_greska1
poruka_greska2: .ascii "U nekoj od ulaznih vrednosti postoji cifra koja ne pripada brojnoj osnovi!\n\0"
poruka_greska2_len = . - poruka_greska2
poruka_greska3: .ascii "Doslo je do prekoracenja prilikom konverzije nekog od operanada!\n\0"
poruka_greska3_len = . - poruka_greska3
poruka_greska4: .ascii "Doslo je do prekoracenja prilikom sabiranja!\n\0"
poruka_greska4_len = . - poruka_greska4
str_unos: .fill 101,1,42
str_unos_len = . - str_unos
substring: .fill 100,1,42
niz_operanada: .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
broj_operanada: .long 0
broj_operacija: .long 0
end: .long 0
greska: .long 0
rezultat: .long 0
.section .text
.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	leal poruka_ulaz, %ecx
	movl $poruka_ulaz_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	leal str_unos, %ecx
	movl $str_unos_len, %edx
	int $0x80

	movl $str_unos, %esi
	movl $substring, %edi
	cmpb $10, (%esi)
	je print_greska1
seperate:
	cmpl $1, end
	je racunaj_pre
	movb (%esi), %al
	cmpb $10, %al
	je preseci_pre
	cmpb $' ', %al
	je preseci
	movb %al, (%edi)
	incl %esi
	incl %edi
	jmp seperate
preseci_pre:
	movl $1, end
preseci:
	incl %esi
	movl $0, (%edi)
	movl $substring, %edi
	cmpb $'+', (%edi)
	je plus
	jmp konvertuj_operand
plus:
	incl broj_operacija
	jmp seperate
konvertuj_operand:		#text_to_int(*string,*greska), rezultat u eax-u
	pushl $greska
	pushl $substring
	call text_to_int
	addl $8, %esp
	cmpl $2, greska
	je print_greska2
	cmpl $3, greska
	je print_greska3
	movl broj_operanada, %edx		#edx = indeksni registar
	movl %eax, niz_operanada(,%edx,4)
	incl broj_operanada
	jmp seperate
racunaj_pre:
	#movl broj_operacija, %eax
	#addl $1, %eax
	#cmpl %eax, broj_operanada
	#jne print_greska4
	xorl %edx, %edx
racunaj:
	cmpl %edx, broj_operanada
	je ispis
	movl niz_operanada(,%edx,4), %eax
	addl %eax, rezultat
	jc print_greska4
	incl %edx
	jmp racunaj
print_greska1:
	movl $4, %eax
	movl $1, %ebx
	leal poruka_greska1, %ecx
	movl $poruka_greska1_len, %edx
	int $0x80
	movl $1, greska
	jmp kraj
print_greska2:
	movl $4, %eax
	movl $1, %ebx
	leal poruka_greska2, %ecx
	movl $poruka_greska2_len, %edx
	int $0x80
	movl $2, greska
	jmp kraj
print_greska3:
	movl $4, %eax
	movl $1, %ebx
	leal poruka_greska3, %ecx
	movl $poruka_greska3_len, %edx
	int $0x80
	movl $3, greska
	jmp kraj
print_greska4:
	movl $4, %eax
	movl $1, %ebx
	leal poruka_greska4, %ecx
	movl $poruka_greska4_len, %edx
	int $0x80
	movl $4, greska
	jmp kraj
ispis:
	movl $4, %eax
	movl $1, %ebx
	leal poruka_rez, %ecx
	movl $poruka_rez_len, %edx
	int $0x80

	#int_to_text(broj,*rez)	#duzina je u eax-u
	pushl $rezultat_str
	pushl rezultat
	call int_to_text
	addl $8, %esp
	movl %eax, rezultat_str_len

	movl $4, %eax
	movl $1, %ebx
	leal rezultat_str, %ecx
	movl rezultat_str_len, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl greska, %ebx
	int $0x80

.globl text_to_int
text_to_int:
	pushl %ebp
	movl %esp, %ebp
	pushl $10
	pushl %ebx
	pushl %esi
	pushl %edi
inc1:
	movl 8(%ebp), %esi
	movl 12(%ebp), %edi
	movl $0, (%edi)
	xorl %eax, %eax
provera1:
	xorl %ebx, %ebx
	movb (%esi), %bl
	cmpb $0, %bl
	je kraj1
	cmpb $'0', %bl
	jb greska2
	cmpb $'9', %bl
	ja greska2
petlja1:
	subb $48, %bl
	mull -4(%ebp)
	jc greska3
	addl %ebx, %eax
	jc greska3
	incl %esi
	jmp provera1
greska2:
	movl $2, (%edi)
	jmp kraj1
greska3:
	movl $3, (%edi)
	jmp kraj1
kraj1:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret

.globl int_to_text
int_to_text:
	pushl %ebp
	movl %esp, %ebp
	pushl $10
	pushl %ebx
	pushl %esi
	pushl %edi
inc2:
	movl 8(%ebp), %eax
	movl 12(%ebp), %esi
	xorl %edi, %edi	#edi = duzina stringa
petlja2:
	xorl %edx, %edx
	divl -4(%ebp)
	addb $48, %dl
	movb %dl, (%esi)
	incl %edi
	incl %esi
	cmpl $0, %eax
	je obrni_pre
	jmp petlja2
obrni_pre:
	movb $0, (%esi)
	decl %esi
	movl 12(%ebp), %ecx
obrni:
	cmpl %ecx, %esi
	jbe kraj2
	movb (%esi), %ah
	movb (%ecx), %al
	movb %ah, (%ecx)
	movb %al, (%esi)
	incl %ecx
	decl %esi
	jmp obrni
kraj2:
	movl %edi, %eax
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
