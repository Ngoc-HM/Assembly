.text
addi $s6, $0, 20200440
addi $s7, $0, 2127283214
start:
li $t0,0 #Thiết lập trạng thái mặc định 
addu $s3,$s1,$s2 # s3 = s1 + s2
slt $s1, $s6, $0 	# so sánh a và 0 
slt $s2, $s7, $0	# so sánh b và 0
beq $s1, $s2, next
li $t0, 1 
j end

next: 
add $s5, $s6, $s7 # s5 = a+b 
slt $s3, $s5, $0 
bne $s3, $s1, end1
li $t0, 0
j end
end1: 
li $t0, 1 
end: