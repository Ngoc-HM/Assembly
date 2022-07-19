.data
M: .space 101 # ki?m tra t?i ?a 100 kí t?
H: .asciiz "\0"
thongbao: .asciiz "Nhap chuoi can kiem tra: "
false: .asciiz "False"
true: .asciiz "True"
.text
	li $v0, 4
	la $a0, thongbao
	syscall
	
 	li $v0, 8
	la $a0, M
 	li $a1, 100
 	syscall 
 	
 	addi $s4, $0, 0 # l?u s4 = 0
 	
 # tính xem trong m?ng có bao nhiêu ph?n t?  
 	la $s7, M		#??a ch? c?a chu?i d??c l?u vào s7
 	add $s1, $0, $0 	
 	la $s6, H
 	lb $t3, 0($s6)
 	
check: 
	add $s1, $s1, 1		# t?ng ??a ch? c?a s? ph?n t?  
	add $t0, $0, $s7	# t0 là ??a ch? c?a M(0)
	add $s3, $t0, $s1	# s3 là ??a ch? c?a M[i]
	lb  $t2, 0($s3)		# load kí t? vào t2 
	beq $t2, $t3, next	# so sánh v?i kí tu ket thuc cau
	add $s4, $s4, 1		# T?ng s? ph?n t?  
	j check
next:
	sub $s5, $s4, 1
	add $s1, $0, $0	
next1:
#ti?p theo ta mang ?i so sánh ph?n t? t? ??u tr? ?i và ph?n t? cu?i quay l?i
	add $s2, $s1, $s7 	#l?y ph?n t? th? M[i]
	lb  $t1, 0($s2)		#n?p kí t? th? M[i] vào t1
	add $s1, $s1, 1		#t?ng i lên 1 ??n v? 
	la  $s6, M		#n?p ??a ch? c?a M[0]
	add $s6, $s6, $s5	#??a ch? c?a M[n-i-1]
	lb  $t2, 0($s6)		#n?p kí t? th? M[n-i-1] vào t2 
	sub $s5, $s5, 1		#gi?m giá tr? 
	bne $t1, $t2, end_false 
	beq $s1, $s4, end_true
	j next1
	
end_false:
	li $v0, 4
	la $a0, false 
	syscall
	j end
	
end_true:
	li $v0, 4
	la $a0, true 
	syscall
	j end 
end: 
		
	






	
 
