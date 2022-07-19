addi $s1, $0, 1 #khởi tạo giá trị i
addi $s2, $0, 2 #khởi tạo giá trị của j 

start: 
# điều kiện nếu i<j gì thực hiện câu lệnh x=x+1,z=1, ngược lại y=y-1,z=2*z
slt $t0, $s1, $s2 
bne $t0, $0, code
addi $t2, $t2, -1
add $t3, $t3, $t3
j endif
code:  addi $t2, $t2, 1
       addi $t3, $0, 1
endif: