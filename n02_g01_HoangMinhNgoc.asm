# Truong Cong Nghe Thong Tin & Truyen Thong - Dai Hoc Bach Khoa Ha Noi
# Bo mon Ky thuat may tinh
# IT3280 - Thuc hanh kien truc may tinh
# Hoang Minh Ngoc 20200440 - Ma lop 131001
# vẽ hình trên Bitmap
# Di chuyen qua bong tren man hinh Bitmap cua Mars 
# Su dung cac phim a, s, d, w de di chuyen 
# Kich thuoc man hinh bitmap 512 * 512
# Kich thuoc o vuong don vi 1 * 1
# Base_Address 0x10010000

# Bo khoi dong mac dinh
.eqv KEY_CODE 0xFFFF0004       # ASCII code to show, 1 byte 
.eqv KEY_READY 0xFFFF0000      # =1 if has a new keycode ?                                  
		               		   # Auto clear after lw 
.eqv DISPLAY_CODE 0xFFFF000C   # ASCII code to show, 1 byte 
.eqv DISPLAY_READY 0xFFFF0008  # =1 if the display has already to do                                  
			                   # Auto clear after sw 

.text	
	li $k0, KEY_CODE 	# chua ki tu nhap vao     
	li $k1, KEY_READY	# kiem tra da nhap phim nao chua  
	li $s2, DISPLAY_CODE	# hien thi ky tu  
	li $s1, DISPLAY_READY	# kiem tra xem man hinh da san sang hien thi chua
	
	addi	$s7, $0, 512			#luu do rong man hinh vao s7
	#circle:
	addi	$a0, $0, 256		#x = 256
	addi	$a1, $0, 256		#y = 256	
	addi	$a2, $0, 20		#r = 20
	addi 	$s0, $0, 0x00FFFF00     # mau vang
	jal 	DrawCircle	
	nop
moving:					# nhan ki tu tu ban phim va di chuyen 
	# so sanh trong ma ASCII
	beq $t0,97,left         # 97 = 'a'
	beq $t0,100,right		# 100 = 'd'
	beq $t0,115,down   		# 115 = 's'
	beq $t0,119,up			# 119 = 'w'
	j Input

	left:				# di chuyen sang trai
		addi $s0,$0,0x00000000  # gia tri mau bang 0, mau den, xoa diem
		jal DrawCircle		# xoa hinh tron vi tri cu, bang cach tô đen
		addi $a0,$a0,-1		# hoanh do tam hinh tron moi giam di 1
		add $a1,$a1, $0		# tung do tam giu nguyen	
		addi $s0,$0,0x00FFFF00 	# mau vang
		jal DrawCircle		# ve hinh tron vi tri moi
		jal Pause		
		bltu $a0,20,reboundRight # nảy sang bên phải  
		j Input
	right: 				# di chuyển sang phải 
		addi $s0,$0,0x00000000	# 
		jal DrawCircle		# xoá hình tròn cũ
		addi $a0,$a0,1		# hoành độ tăng 1
		add $a1,$a1, $0		# tung độ giữ nguyên
		addi $s0,$0,0x00FFFF00
		jal DrawCircle		# vẽ hình tròn mới
		jal Pause
		bgtu $a0,492,reboundLeft # đập thành thì nảy sang trái
		j Input
	up: 				# di chuyển lên trên 
		addi $s0,$0,0x00000000	
		jal DrawCircle		# xoá hình tròn cũ
		addi $a1,$a1,-1		# tung độ giảm 1
		add $a0,$a0,$0		# hoành độ giữ nguyên
		addi $s0,$0,0x00FFFF00	
		jal DrawCircle		# vẽ hình tròn mới
		jal Pause
		bltu $a1,20,reboundDown	# đập thành thì nảy xuống dưới
		j Input
	down: 
		addi $s0,$0,0x00000000
		jal DrawCircle	# xoá hình tròn cũ
		addi $a1,$a1,1	# tung độ tăng 1
		add $a0,$a0,$0  # hoành độ giữ nguyên 
		addi $s0,$0,0x00FFFF00
		jal DrawCircle 	# ve hình tròn mới
		jal Pause
		bgtu $a1,492,reboundUp	#đập thành thì nảy lên trên 
		j Input
	reboundLeft:
		li $t3 97	
		sw $t3,0($k0)	 # thay đổi giá trị ở địa chỉ KEY_CODE để nhảy đến left
		j Input
	reboundRight:
		li $t3 100
		sw $t3,0($k0)	# thay đổi giá trị ở địa chỉ KEY_CODE để nhảy đến right
		j Input
	reboundDown:
		li $t3 115
		sw $t3,0($k0)    # thay đổi giá trị ở địa chỉ KEY_CODE để nhảy đến down
		j Input
	reboundUp:
		li $t3 119
		sw $t3,0($k0)	# thay đổi giá trị ở địa chỉ KEY_CODE để nhảy đến up
		j Input
Input:
	ReadKey: lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
	j moving
	
Pause:
	# delay ve
	addiu $sp,$sp,-4
	sw $a0, ($sp)
	#la $a0, 5	 #system_sleep 
	#li $v0, 32	 #syscall value for sleep
	#syscall

	lw $a0,($sp)
	addiu $sp,$sp,4
	jr $ra
DrawCircle: 		
	# Dung thuat toan Bresenham de ve duong tron
	# Toa do tam duong tron can ve la (cx, cy)
	# Toa do diem can to mau la (cx +- x, cy +- y)
	# $a0 = cx va hoanh do pixel can to mau
	# $a2 = tung do pixel can to mau
	# s0 = colour mau vang
	# Khoi tao x = r = 20, y = 0
	# Cach tinh cac cap (x, y) tiep theo:
	# p = 3 - 2*r
	# neu p < 0 thi  p = p + 4y + 6 va (x, y) = (x, y+1)
	# neu p > 0 thi p = p + 4(y-x) +10 va (x, y) = (x-1, y+1)
	# neu y > x thi ta ve xong hinh tron, thoat khoi khối lệnh
	
	addiu	$sp, $sp, -32
	sw 	$ra, 28($sp)
	sw	$a0, 24($sp)
	sw	$a1, 20($sp)
	sw	$a2, 16($sp)
	sw	$s4, 12($sp)
	sw	$s3, 8($sp)
	sw	$s2, 4($sp)
	sw	$s0, ($sp)
	
	#code goes here
	sll     $t4, $a2, 1
	li	$t3, 3 
	sub	$s2, $t3, $t4			# p = 3 - 2r
	add	$s3, $0, $a2			#x = r = 20
	add	$s4, $0, $0			#y = 0 
	
	DrawCircleLoop:
	bgt 	$s4, $s3, exitDrawCircle #neu y > x thi ta ve xong hinh tron, thoat khoi vong lap
	nop
	
	#ve 4 diem doi xung nhau qua truc hoanh va truc tung, roi hoan doi x, y cho nhau de ve tiep 4 diem doi xung qua phan giac
	jal	plot8points
	nop
	# Tinh toan (x, y) tiep theo, roi ve cac diem moi
	sll	$t3, $s4, 2  			# $t3 = 4y
	add     $s2, $s2, $t3
	addi	$s2, $s2, 6			# p = p + 4y +6 
	addi	$s4, $s4, 1			# y = y + 1
	
	blt	$s2, 0, DrawCircleLoop		#if error >= 0, start loop again
	nop
	
	sll	$t4, $s3, 2
	sub	$s2, $s2, $t4
	addi	$s2, $s2, 4
	addi	$s3, $s3, -1
	
	j	DrawCircleLoop
	nop	
	
	exitDrawCircle:
	
	lw	$s0, ($sp)
	lw	$s2, 4($sp)
	lw	$s3, 8($sp)
	lw	$s4, 12($sp)
	lw	$a2, 16($sp)
	lw	$a1, 20($sp)
	lw	$a0, 24($sp)
	lw	$ra, 28($sp)
	
	addiu	$sp, $sp, 32
	
	jr 	$ra
	nop
	
plot8points:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	jal	plot4points
	nop
	
	beq 	$s4, $s3, skipSecondplot
	nop
	
	# doi gia tri x va y cho nhau de ve 4 diem doi xung qua duong phan giac
	add	$t2, $0, $s4			# t = y
	add	$s4, $0, $s3			# y = x
	add	$s3, $0, $t2			# x = t
	
	jal	plot4points
	nop
	
	# doi gia tri x va y về như cũ
	add	$t2, $0, $s4			# t = y
	add	$s4, $0, $s3			# y = x 
	add	$s3, $0, $t2			# x = t
		
	skipSecondplot:
		
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	
	jr	$ra
	nop
	
plot4points:
	
	addiu	$sp, $sp -4
	sw	$ra, ($sp)
	
	#$a0 = a0 + s3, $a2 = a1 + s4
	add	$t0, $0, $a0			# $t0 luu cx
	add	$t1, $0, $a1			# $t1 luu cy
	
	add	$a0, $t0, $s3			# hoanh do diem can to mau: cx + x
	add	$a2, $t1, $s4			# tung do diem can to mau: cy + y
	
	jal	SetPixel		         	# (cx + x, cy + y)
	nop
	
	sub	$a0, $t0, $s3			#cx - x
	#add	$a2, $t1, $s4			#cy + y
	
	beq	$s3, $0, skipXnotequal0 	#if s3 (x) equals 0, skip
	nop
	
	jal 	SetPixel				# (cx - x, cy +y)
	nop
	
	skipXnotequal0:	
	sub	$a2, $t1, $s4			#cy - y (a0 already equals cx - x)
	jal 	SetPixel		          	# (cx - x, cy - y)
	nop
	
	add	$a0, $t0, $s3
	
	beq	$s4, $0, skipYnotequal0 
	nop
	
	jal	SetPixel				#(cx + x, cy - y)
	nop
	
	skipYnotequal0:
	
	add	$a0, $0, $t0			
	add	$a2, $0, $t1			
	
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	
	jr	$ra
	nop
SetPixel:
	#a0 x
	#a1 y
	#s0 colour
	addiu	$sp, $sp, -20			# Save return address on stack
	sw	$ra, 16($sp)
	sw	$s1, 12($sp)
	sw	$s0, 8($sp)			# Save original values of a0, s0, a2
	sw	$a0, 4($sp)
	sw	$a2, ($sp)

	lui	$s1, 0x1001			# Dia chi bat dau bo nho man hinh
	sll	$a0, $a0, 2 			 
	add	$s1, $s1, $a0			
	mul  	$a2, $a2, $s7			
	mul	$a2, $a2, 4			
	add	$s1, $s1, $a2			# Dia chi pixel can to mau

	sw	$s0, ($s1)			# Luu gia tri màu vao dia chi pixel
	
	lw	$a2, ($sp)			#retrieve original values and return address
	lw	$a0, 4($sp)
	lw	$s0, 8($sp)
	lw	$s1, 12($sp)
	lw	$ra, 16($sp)
	addiu	$sp, $sp, 20	
	
	jr	$ra
	nop
	
