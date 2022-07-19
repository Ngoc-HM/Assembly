#bài toán sử dụng nhân với 1 số lũy thừa nhỏ của 2 
#vậy ta cần phân tích bài toán 
#vậy số đó đã cho không còn nguyên vẹn
.text 
	li $s1,5 #giá trị cần tính lũy thừa 2  
	li $s2,1 #giá trị khởi chạy, bước nhảy 
	add $s3, $s1, $0 #lưu giá trị s3 = s1 
loop: 
	add $s1, $s1, $s3 # thực hiện mỗi vòng lặp 
	addi $s2, $s2, 1  #mỗi vòng lặp thực hiện tăng biến đếm 
	bne $s2, $s3, loop 
	j next 
next:
	