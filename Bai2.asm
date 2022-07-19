
.data 
	theSum:		.asciiz  "The sum of "
	andWord: 	.asciiz " and " 
	is: 		.asciiz " is " 
.text
	addi 	$s0, $0, 2020	#khai bao bien s0
	addi 	$s1, $0, 440 	#khai bao bien s1
	add 	$t0, $s0, $s1	#Tinh tong s0, s1 
	
	li 	$v0, 4 		#lenh in ra chuoi 
	la 	$a0, theSum	#in ra tong 
	syscall
	
	li 	$v0, 1		#in ra so
	la 	$a0, 0($s0)	#in ra s0
	syscall
	
	li 	$v0, 4		#in chuoi
	la 	$a0, andWord 	#in ra andWord
	syscall
	
	add 	$v0, $0, 1	#in so nguyen
	la 	$a0, 0($s1)	#dua chia chi vao a0
	syscall 
	
	li 	$v0, 4		#in chuoi
	la 	$a0, andWord 	#in ra is
	syscall 
	
	li 	$v0, 1		#in so
	la 	$a0, 0($t0) 	#in ra so
	syscall
