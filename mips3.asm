.data
arr: .word 4685, 2019, 0, -1, -2, 100, -28, -9, 10
space: .asciiz " "
.text
  la $s0, arr   		#Luu dia chi cua arr vào s0
  li $t0, 0            	#i = 0
  li $s1, 8             	#n = 9
  li $s2, 9             
  add $t2, $zero, $s0  

outer_loop:
  li  $t1, 0       	 #j = 0
  addi $s2, $s2, -1     
  add $t3, $zero, $s0 	

inner_loop:
lw $s3, 0($t3)  
addi $t3, $t3, 4  	
lw $s4, 0($t3)  	
addi $t1, $t1, 1  	
slt $t4, $s3, $s4   
bne $t4, $zero, cond

swap: sw $s3, 0($t3)
sw $s4, -4($t3)
lw $s4, 0($t3)

cond: bne $t1, $s2, inner_loop  	#j != n-i
addi $t0, $t0, 1                	#i++
bne $t0, $s1, outer_loop      	#i != n
li $t0, 0
addi $s1, $s1, 1

print: li $v0, 1
lw $a0, 0($t2)
syscall
li $v0, 4
la $a0, space
syscall
addi $t2, $t2, 4    	
addi $t0, $t0, 1    	
bne $t0, $s1, print 	#i != n
