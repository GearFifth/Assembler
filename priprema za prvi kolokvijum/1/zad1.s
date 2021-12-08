#zadatak
#Napisati asemblerski program koji od korisnika trazi da unese string od maksimalno 20
#karaktera i menja uneti string tako da:
#Menja pozicije dva susedna karaktera ukoliko uneti string ima paran broj karaktera, a ukoliko ima neparan, karakter na poslednjem mestu se "prepisuje"
.section .data
poruka1: .ascii "Unesite tekst: \0"
poruka1_len = . - poruka1
poruka2: .ascii "Promenjen string je: \0"
poruka2_len = . - poruka2
unos: .fill 50,1,42
.section .text
.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	leal poruka1, %ecx
	movl $poruka1_len,%edx
	int $0x80
korisnik:
	movl $3, %eax
	movl $0, %ebx
	leal unos, %ecx
	movl $50,%edx
	int $0x80		#Unutar eax-a se nalazi duzina unetog stringa
	movl %eax, %esi
	leal unos, %edi		#edi = adresa odakle pocinje unos
uporedi:
	decl %eax		#preskacem /n karakter
	testl $1, %eax		#proveravam da li je paran ili neparan broj karaktera
	jnz neparan
paran:
	cmpl $0, %eax
	je ispis
	movb -1(%edi,%eax,1), %bl		#soljice
	movb -2(%edi, %eax,1), %cl
	movb %bl, -2(%edi, %eax,1)
	movb %cl, -1(%edi,%eax,1)
	subl $2, %eax
	jmp paran
neparan:
	decl %eax
petlja:
	cmpl $0, %eax
	jl ispis
	movb -1(%edi,%eax,1), %bl		#soljice
	movb -2(%edi, %eax,1), %cl
	movb %bl, -2(%edi, %eax,1)
	movb %cl, -1(%edi,%eax,1)
	subl $2, %eax
	jmp petlja
ispis:
	movl $4, %eax
	movl $1, %ebx
	leal poruka2, %ecx
	movl $poruka2_len,%edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	leal unos, %ecx
	movl %esi,%edx
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	int $0x80
