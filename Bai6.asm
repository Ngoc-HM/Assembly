.data
array: .word -5,4,2,9,10,-11
space: 	.asciiz " "
Out: .asciiz "Cap phan tu lien ke co tich lon nhat la: "
.text
start:	
	addi 	$t0, $0, 6	# so phan tu cua mang
 	la 	$t2 ,array	# lay dia chi cua mang vao t2
 	
 	lw 	$s1 ,0($t2)	# lay gia tri A[0] nap vao s1
 	lw 	$s2 ,4($t2)	# lay gia tri A[1] nap vao s2
 	mul 	$t3, $s1, $s2	# A[0]*A[1}
 	addi 	$t2, $t2, 4	# t?ng i (A[i]=A[1])
 	move 	$s4, $s1	# luu gia tri cua 2 so nguyen p1
 	move 	$s5, $s2	# luu gia tri cua 2 so nguyen p2
 	li 	$t1, 1		# luu lai t1 bang 1 
 	sub 	$t0, $t0, 1	# giam so phan tu cua mang, mang so sanh
	beq 	$t1, $t0 ,print	# neu mang co 2 phan tu thi nhay toi print
compare:
# thuc hien nhu tren them so sanh de loc ra phan tu MAX
 	lw 	$s1 ,0($t2)	# lay gia tri cua  A[i]
 	lw 	$s2 ,4($t2)	# lay gia tri cua A[i+1]
 	mul 	$t4 ,$s1 ,$s2	# tinh A[i]*A[i+1]
 	addi 	$t2 ,$t2, 4	# tang dia chi len 4 de lay gia tri cua phan tu tiep theo
 	
 	addi 	$t1 ,$t1 ,1	# tang bien dem len 1 don vi
 	
 	slt 	$s3 , $t3 , $t4		# N?u t3 < t4 thì s3 = 1 else s3 = 0  
 	beq 	$t1 , $t0, print	# n?u nh? t0 mà b?ng t1 thì nh?y t?i print(t1 là v? trí ph?n t? hi?n t?i
 					# t0 là s? l??ng ph?n t? ) 
 	beq 	$s3 , 0, compare	# n?u tích m?i l?n h?n tích c? thì th?c hi?n nh?y t?i compare
 	move 	$s4 ,$s1		# n?u nh? tích m?i l?n h?n tích c? thì th?c hi?n hoán ??i MAX 
 	move 	$s5 ,$s2
 	move 	$t3 ,$t4
 	# chay toi compare
 	j 	compare
 
print:
#----- in ra man hinh -----#
 	la 	$t3 , Out
	li 	$v0, 4
	addi 	$a0, $t3, 0
	syscall
 	
 	li 	$v0, 1
	addi 	$a0, $s4, 0
	syscall
	
	la 	$t3 , space
	
	li 	$v0, 4
	addi 	$a0, $t3, 0
	syscall
	
	li 	$v0, 1
	addi 	$a0, $s5, 0
	syscall
	
	
	li 	$v0, 4
	addi 	$a0, $t3, 0
	syscall

 	li 	$v0, 10      	# ket thuc chuong trinh
    	syscall
 
		
 	
 
 
 
