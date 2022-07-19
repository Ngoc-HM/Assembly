.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text

	add $t1, $zero, $zero		# Khởi tạo biến đếm nhận giá trị đầu vào = 0
 li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh

loop:					#Vòng lặp tô bảng màu trắng
	li $t0, WHITE
	sw $t0, ($k0)
	nop 
	addi $k0, $k0, 4			# Tăng địa chỉ của bảng pixel
	addi $t1, $t1, 4			# Biến kiểm tra 
	bne $t1, 256, loop		# Kiểm tra nếu biến kiểm tra nếu khác 256 tức chưa tô hết bảng thì còn lặp lại
	b print				# Nhảy tới nhãn print
print:	
	li $k0, MONITOR_SCREEN
	li $t0, RED
	sw $t0, 44($k0)
	nop
	li $t0, RED
	sw $t0, 56($k0)
	nop
	li $t0, RED
	sw $t0, 76($k0)
	nop
	li $t0, RED
	sw $t0, 80($k0)
	nop
	li $t0, RED
	sw $t0, 88($k0)
	nop
	li $t0, RED
	sw $t0, 108($k0)
	nop
	li $t0, RED
	sw $t0, 116($k0)
	nop
	li $t0, RED
	sw $t0, 120($k0)
	nop
	li $t0, RED
	sw $t0, 140($k0)
	nop
	li $t0, RED
	sw $t0, 152($k0)
	nop