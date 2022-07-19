.text
addi $s0, $0, 0x20200440

start:
srl $s1,$s0,16
# thực hiện lệnh dịch sang bên phải, các bit sẽ được lưu tại s1 

andi $s3, $s0, 0xffffff00 
# xóa tất cả các bit khác f thành 0, các bit cùng f thì giữ nguyên 

xori $s4,$s3, 0x00000011
#chuyển LSB thành 11 

andi $s0 , $s0, 0x00000000
#xóa s0  về bằng 0 