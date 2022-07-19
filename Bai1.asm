.data 
test: .asciiz "Hoang Minh Ngoc 20200440"
.text
li $v0, 4 
la $a0, test
syscall
