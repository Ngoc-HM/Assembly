.text 
addi $s1, $0, 12
addi $s2, $0, 23
label: 
slt $t1, $s2, $s1 
beq $t1, $0, code 
j next
code: 
j label
next:
