#unsigned int oct_str_to_inter(char* str, unsigned int* greska);
.section .text
.globl oct_str_to_inter
oct_str_to_inter:
    pushl %ebp
    movl %esp, %ebp
    pushl $8                #baza broja
    pushl $0                #flag za neg
    pushl %esi
    pushl %ebx
    movl 8(%ebp), %esi
    xorl %eax, %eax         #rezultat
    xorl %ebx, %ebx
negative:
    cmpb $'-', (%esi)
    je neg_true
    cmpb $'+',(%esi)
    jne for
    incl %esi
    jmp for
neg_true:
    movl $-1, -8(%ebp)
    incl %esi


for:    
    movb (%esi), %bl
    cmpb $0, (%esi)
    je check
    cmpb $55, %bl
    jg greska
    cmpb $48, %bl
    jl greska
    subb $'0', %bl
    mull -4(%ebp)
    jo greska2
    addl %ebx, %eax
    jo greska2
    incl %esi
    cmpl $0, %eax
    jl checkovf
    jmp for
checkovf:
    cmpl $-1, -8(%ebp)              #fix za overflow koji jo komanda ne moze regitrovati 
    je for                          #-2147483648 se javlja ako je granicni ulaz pozitivan
    jne greska2
check:
    cmpl %esi, 8(%ebp)   #ako nije vrsena iteracija -> string prazan
    je greska
    jmp kraj
greska:
    movl 12(%ebp), %ebx
    movl $1, (%ebx)
    jmp end
greska2:
    movl 12(%ebp), %ebx
    movl $2, (%ebx)
    jmp end
kraj:

    movl 12(%ebp), %ebx
    movl $0, (%ebx)
    cmpl $-1, -8(%ebp)
    jne end
    mull -8(%ebp)
end:
    popl %ebx
    popl %esi
    movl %ebp, %esp
    popl %ebp
    ret
