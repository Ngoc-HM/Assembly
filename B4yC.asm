addi $s1, $0, 1 #khởi tạo giá trị i
addi $s2, $0, 2 #khởi tạo giá trị của j 
add $s6, $s1, $s2 #tạo ra biến trung gian 
start: 
# điều kiện nếu i+j<=0  thực hiện câu lệnh x=x+1,z=1, ngược lại y=y-1,z=2*z
slt $t0, $0, $s6 
beq $t0, $0, code
addi $t2, $t2, -1
add $t3, $t3, $t3
j endif
code:  addi $t2, $t2, 1
       addi $t3, $0, 1
endif:
