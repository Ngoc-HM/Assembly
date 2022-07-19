.data
string: 	.space 50
Mes1:	.asciiz "Nhap vao xau: " 
Mes2: 	.asciiz " Do dai la: " 	
.text
main:
get_string: 
li $v0, 54
la $a0, Mes1	#dia chi cua chuoi hien thi thong bao 
la $s1, string	#dia chi cua bo dem dau vao
la $a2, 100	#so ki tu toi da 

syscall
get_length:
la $a0, string	#a0 = dia chi cua string[0]
#add $v1, $0, $0	#v1 = 0
add $t0, $0, $0	#t0 = 0 bien chay 
check_char:
add $t1, $a0, $t0	#dia chi cua string[i]la t1
lb $t3, 0($t1)		#lay gia tri cua string[i]
beq $t2, $zero, end_of_str # is null char?
 addi $t0, $t0, 1 # $t0 = $t0 + 1 -> i = i + 1
 j check_char
end_of_str:
end_of_get_length:
print_length: # TODO