#autor: Imenko Prezimić INDEX ra1234-2018
#convert_text_to_int(*string,*greska)
.section .data
prompt1: .ascii "Unseite logicki izraz: \0"
prompt1_len = . - prompt1
prompt2: .ascii "Rezultat: \0"
prompt2_len = . - prompt2
err1: .ascii "Greska kod operanda.\n\0"
err1_len = . - err1
err2: .ascii "Greska kod operacije.\n\0"
err2_len = . - err2
newline: .ascii "\n\0"
newline_len = . - newline
string: .fill 101,1,42
string_len = . - string
substring: .fill 8,1,42
rezultat: .long 0
greska: .long 0
operand1: .long 0
operand2: .long 0
operacija: .fill 8,1,42
brojac: .long 1
rezultat_string: .fill 8,1,42
duzina: .long 0
is_end: .long 0
.section .text
.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	leal prompt1, %ecx
	movl $prompt1_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	leal string, %ecx
	movl $string_len, %edx
	int $0x80

	movl $string, %esi
	movl $substring, %edi
seperate:
	cmpb $1, is_end
	je provera_kraj
	cmpb $' ', (%esi)
	je preseci
	cmpb $10, (%esi)
	je pred_preseci
	movb (%esi), %bl
	movb %bl, (%edi)
	incl %esi
	incl %edi
	jmp seperate
pred_preseci:
	incl is_end
preseci:
	incl %esi
	movb $0, (%edi)
	movl brojac, %ecx
	testl $1, %ecx
	jz operacija_lbl
	cmpl $1, brojac
	je konvertuj_operand1
	jmp konvertuj_operand2

operacija_lbl:
	incl brojac
	movl $substring, %edi
	movl $operacija, %eax
petljica:
	movb (%edi), %cl
	movb %cl, (%eax)
	incl %edi
	cmpb $0, (%edi)
	je dalje
	jmp petljica
dalje:
	movl $substring, %edi
	jmp seperate
konvertuj_operand1:
	pushl $greska
	pushl $substring
	call convert_text_to_int
	addl $8, %esp
	cmpl $1, greska
	je print_err1
	movl $substring, %edi
	incl brojac
	movl %eax, operand1
	cmpl $256, %eax
	jae print_err1
	jmp seperate
konvertuj_operand2:
	pushl $greska
	pushl $substring
	call convert_text_to_int
	addl $8, %esp
	cmpl $1, greska
	je print_err1
	movl $substring, %edi
	movl %eax, operand2
	cmpl $256, %eax
	jae print_err1
	cmpl $3, brojac
	je racunaj1
	jmp racunaj2
racunaj1:
	incl brojac
	movl $operacija, %edx
	cmpb $'^', (%edx)
	je doxor1
	cmpb $'>', (%edx)
	je rotateright1
	cmpb $'<', (%edx)
	je rotateleft1
	jmp print_err2
doxor1:
	movb operand1, %al
	movb operand2, %bl
	xorb %al, %bl
	movb %bl, rezultat
	jmp seperate
rotateright1:
	movb operand1, %al
	movb operand2, %cl
	rorb %cl, %al
	movb %al, rezultat
	jmp seperate
rotateleft1:
	movb operand1, %al
	movb operand2, %cl
	rolb %cl, %al
	movb %al, rezultat
	jmp seperate
racunaj2:
	incl brojac
	movl $operacija, %edx
	cmpb $'^', (%edx)
	je doxor2
	cmpb $'>', (%edx)
	je rotateright2
	cmpb $'<', (%edx)
	je rotateleft2
	jmp print_err2
doxor2:
	movb rezultat, %al
	movb operand2, %bl
	xorb %al, %bl
	movb %bl, rezultat
	jmp seperate
rotateright2:
	movb rezultat, %al
	movb operand2, %cl
	rorb %cl, %al
	movb %al, rezultat
	jmp seperate
rotateleft2:
	movb rezultat, %al
	movb operand2, %cl
	rolb %cl, %al
	movb %al, rezultat
	jmp seperate
print_err1:
	movl $4, %eax
	movl $1, %ebx
	leal err1, %ecx
	movl $err1_len, %edx
	int $0x80
	jmp kraj_greska
print_err2:
	movl $4, %eax
	movl $1, %ebx
	leal err2, %ecx
	movl $err2_len, %edx
	int $0x80
	jmp kraj_greska
kraj_greska:
	movl $1, %eax
	movl $1, %ebx
	int $0x80
provera_kraj:
	decl brojac
	movl brojac, %ecx
	testl $1, %ecx
	jz print_err1
ispis:	#convert_int_to_text(broj,*rez) eax = duzina
	movl $4, %eax
	movl $1, %ebx
	leal prompt2, %ecx
	movl $prompt2_len, %edx
	int $0x80	

	pushl $rezultat_string
	pushl rezultat
	call convert_int_to_text
	addl $8, %esp
	movl %eax, duzina
	
	movl $4, %eax
	movl $1, %ebx
	leal rezultat_string, %ecx
	movl duzina, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
.global convert_text_to_int	#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
convert_text_to_int:
	pushl %ebp
	movl %esp, %ebp
	pushl $10
	pushl $16
	pushl %ebx
	pushl %esi
	pushl %edi
inc1:
	movl 8(%ebp), %esi
	movl 12(%ebp), %edi	#greska
	movl $0, (%edi)
	xorl %eax, %eax	#rezultat
provera1:
	cmpb $'0', (%esi)
	je checkhex1
cnvrtdec1:
	xorl %edx, %edx
	xorl %ebx, %ebx
	cmpb $0, (%esi)
	je kraj1
	movb (%esi), %bl
	cmpb $48, %bl
	jb greska1
	cmpb $57, %bl
	ja greska1
	subb $48, %bl
	mull -4(%ebp)
	jc greska1
	addl %ebx, %eax
	jc greska1
	incl %esi
	jmp cnvrtdec1
checkhex1:
	cmpb $'x', 1(%esi)
	je check_caps_hex1_pred
	cmpb $'X', 1(%esi)
	jne greska1
check_caps_hex1_pred:
	addl $2, %esi
check_caps_hex1:
	xorl %edx, %edx
	xorl %ebx, %ebx
	cmpb $0, (%esi)
	je kraj1 
	movb (%esi), %bl
	cmpb $48, %bl
	jb greska1
	cmpb $57, %bl
	jbe hexdec
	cmpb $65, %bl
	jb greska1
	cmpb $70, %bl
	jbe hexup
	cmpb $'a', %bl
	jb greska1
	cmpb $'f', %bl
	jbe hexlow
	jmp greska1
hexdec:
	subb $48, %bl
	mull -8(%ebp)
	jc greska1
	addl %ebx, %eax
	jc greska1
	incl %esi
	jmp check_caps_hex1
hexup:
	subb $55, %bl
	mull -8(%ebp)
	jc greska1
	addl %ebx, %eax
	jc greska1
	incl %esi
	jmp check_caps_hex1
hexlow:
	subb $87, %bl
	mull -8(%ebp)
	jc greska1
	addl %ebx, %eax
	jc greska1
	incl %esi
	jmp check_caps_hex1
greska1:
	incl (%edi)
kraj1:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
.globl convert_int_to_text		#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
convert_int_to_text:
	pushl %ebp
	movl %esp, %ebp
	pushl $8	#baza
	pushl $0	#duzina
	pushl %ebx
	pushl %esi
	pushl %edi
inc2:
	movl 8(%ebp), %eax
	movl 12(%ebp), %esi
petlja2:
	xorl %edx, %edx
	divl -4(%ebp)
	addb $48, %dl
	movb %dl, (%esi)
	incl %esi
	incl -8(%ebp)
	cmpl $0, %eax
	je obrni_pre
	jmp petlja2
obrni_pre:
	movb $0, (%esi)
	movl 12(%ebp), %ecx
	decl %esi
obrni:
	cmpl %ecx, %esi
	jbe kraj2
	movb (%ecx), %bl
	movb (%esi), %bh
	movb %bh, (%ecx)
	movb %bl, (%esi)
	incl %ecx
	decl %esi
	jmp obrni
kraj2:
	movl -8(%ebp), %eax
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
