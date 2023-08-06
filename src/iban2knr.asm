	.data
	.globl iban2knr
	.text
	li $t4 4
iban2knr:
loop:
lb $t2 4($a0)
sb $t2 ($a1)
addiu $t4 $t4 1
addiu $a0 $a0 1
addiu $a1 $a1 1
beq $t4 12 check
b loop

check:
lb $t3 ($a0)
sb $t3 ($a2)
addiu $a0 $a0 1
addiu $a2 $a2 1
addiu $t4 $t4 1 
beq $t4 22 end
b check
end:
jr $ra
	  
	
	
	   

	
	  
	      

 

# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)

	
	







 
	          


 



	
	
