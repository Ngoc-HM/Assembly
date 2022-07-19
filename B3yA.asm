.text
addi $s1, $0, -440
start:
# đề bài đặt ra yêu cầu lưu s0 = abs(s1)
# yêu cầu đặt ra ta sẽ xét xem s0 nó lớn hơn hay nhỏ hơn 0 
# nếu <0 ta dùng lệnh sub đổi dấu, còn nếu >0 ta thực hiện phép gán luôn

slt $s2, $s1, $0 
bne $s2, $0, code 
j code2
code:
sub $s1,$0 ,$s1
code2:
 
add $s0, $s1, $0