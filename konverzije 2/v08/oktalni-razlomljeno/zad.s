#unsigned int oct_str_float_to_inter(char* str, unsigned int* greska);
.section .text
.global oct_str_float_to_inter
oct_str_float_to_inter:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp	#promenljiva
	pushl %ebx
	pushl %esi
	pushl %edi
incijalizacija:
	
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
