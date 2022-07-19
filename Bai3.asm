.data 
x:	.space 1000 	#khai bao chuoi x rong 
y:	.asciiz "Hoang Minh Ngoc"	#khai bao chuoi y
.text 
la	$a0, x	#nap du lieu cho a0
la	$a1, y	#nhap du lieu cho a1
strcpy: add	$s0, $0, $0	#khai bao s0 = 0 

L1:	add $t1, $s0, $a1	#bien  t1 = dia chi cua y[i]
lb	$t3, 0($t1)	#luu gia tri vao mang x

add 	$t0, $s0, $a0	#bien chay t0  la dia chi cua x[i]
sb	$t3, 0($t0)	#luu gia tri vao mang x

beq	$t3, $0, eos
nop
addi	$s0, $s0, 1
j 	L1

nop
eos:	li $v0, 4	#lenh in chuoi ki tu
la	$a0, x	#nap chuoi vao a
syscall 	
