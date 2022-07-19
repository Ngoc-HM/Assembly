.text
addi $s1, $0, 20200440
addi $s2, $0, 2127283209
start:
li $t0,0 #Thiết lập trạng thái mặc định 
addu $s3,$s1,$s2 # s3 = s1 + s2
xor $t1,$s1,$s2 #kiểm tra xem $s1 và $s2 có cùng dấu với nhau hay không 
bltz $t1,EXIT # nếu không thì nhảy tới exit 
slt $t2,$s3,$s1
bltz $s1,NEGATIVE #nếu như s1 mà <0 thì nhảy tới NEGATIVE 
beq $t2,$zero,EXIT #nếu như t2 mà = 0 thì sẽ nhảy tới exit 
 #nếu s3 mà lớn hơn s1 thì kết quả ko bị tràn 
 #nhảy tới OVERFLOW 
j OVERFLOW

NEGATIVE:
bne $t2,$zero,EXIT # $s1 và $s2 cùng là số âm 
 # nếu s3<s1 thì kết quả sẽ không bị tràn 
 
OVERFLOW:
li $t0,1 #kết quả là tràn 

EXIT: