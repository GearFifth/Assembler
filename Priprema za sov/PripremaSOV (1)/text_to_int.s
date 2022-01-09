#konverzija decimalnog i heksadecimalnog u interni oblik
#convert_text_to_int(*string,*greska)	#u eax-u ce se nalaziti rezultat
.section .text
.global convert_text_to_int
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
