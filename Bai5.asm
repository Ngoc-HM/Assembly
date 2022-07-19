
.data 
A: .word 1,2,3,4,5,6,10,20,25,36,187

.text
addi $s1, $0, -1 #khởi tạo giá trị i 
addi $s3, $0, 8 #khởi tạo giá trị của n
addi $s4, $0, 1 #bước nhảy 
addi $s5, $0, 0 #SUM
la $s2, A 
 
loop: add $s1, $s1, $s4 #i=i+step
add $t1, $s1, $s1 #t1=2*s1
add $t1, $t1, $t1 #t1=4*s1
add $t1, $t1, $s2 #nhận địa chỉ của A[i]
lw $t0,0($t1) #nhận giá trị của A[i]
add $s5, $s5, $t0 # sum = sum + A[i]

slt $t6, $s3, $s1 # nếu i<=n thì t6=1 ngược lại =0
beq $t6, 0, loop # nếu s1=1 thì chạy tới loop
