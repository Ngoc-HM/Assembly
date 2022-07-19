addi $s1, $0, 1 #khởi tạo giá trị i
addi $s2, $0, 2 #khởi tạo giá trị của j 
add $s6, $s1, $s2 #tạo ra biến trung gian thứ nhất 

addi $s3, $0, 3 #khởi tạo giá trị m
addi $s4, $0, 4 #khởi tạo giá trị của n 
add $s5, $s3, $s4 #tạo ra biến trung gian thứ hai

start: 
# điều kiện nếu i+j<=m+n  thực hiện câu lệnh x=x+1,z=1, ngược lại y=y-1,z=2*z
slt $t0, $5, $s6 
beq $t0, $0, code
addi $t2, $t2, -1
add $t3, $t3, $t3
j endif
code:  addi $t2, $t2, 1
       addi $t3, $0, 1
endif:
