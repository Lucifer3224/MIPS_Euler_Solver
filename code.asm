.data
.text
main:	lw $s1,0($a1) #loading address of y0
	lw $s2,4($a1) #loading address of h
	lw $s3,8($a1) #loading address of n
	lb $s1,0($s1) #loading value of y0
	lb $s2,0($s2) #loading value of h
	lb $s3,0($s3) #loading value of n
	addi $s1,$s1,-48 #converting y0 from char to int
	addi $s2,$s2,-48 #converting h from char to int
	addi $s3,$s3,-48 #converting n from char to int
	jal euler_fn 
	lui $t0,4097  #storing the final value of y in memory in adress 0x10010000
	sw $v0,0($t0)  # storing the final value of y in memory in the adress stored in t0
	j Exit
	
euler_fn:addi $sp,$sp,-4 #preserve the address stored in ra 
	 sw $ra,0($sp)
	 addi $s0,$zero,0 #storing x in s0 and initialize it to 0
	 addi $s6,$zero,1  #storing 1 at register s4 to use it in comparison
	 addi $s3,$s3,1
for2:	 slt $t1,$s6,$s3  #if s3(value of n+1) = s6 t1 will equal to 1
	 beq $t1,$zero,L3 #when n = s6 we will have final value of y at t4 and it will jump to L1
	 add $a0,$s0,$zero  #storing the value of x in a0 to pass it to square function
	 jal square #get the x^2 value
	 add $t3,$v0,$zero #storing the return value (x^2) in register t3
	 #calculating 92x^2
	 sll $t4,$t3,6  #t4 = 64x^2
	 sll $t5,$t3,4  #t5 = 16x^2
	 add $t4,$t4,$t5 #t4 = 80x^2
	 sll $t5,$t3,2  #t5 = 4x^2
	 add $t4,$t4,$t5 #t4 = 84x^2
	 sll $t5,$t3,3  #t5 = 8x^2
	 add $t4,$t4,$t5 #t4 = 92x^2
	 #calculating 51x
	 sll $t6,$s0,5  #t6 = 32x
	 sll $t5,$s0,4  #t5 = 16x
	 add $t6,$t6,$t5 #t6 = 48x
	 sll $t5,$s0,1  #t5 = 2x
	 add $t6,$t6,$t5 #t6 = 50x
	 add $t6,$t6,$s0 #t6 = 51x
	 sub $t4,$t4,$t6 #t4 = 92x^2 - 51x
	 add $a0,$s1,$zero  #storing the value of y in a0 to pass it to cube function
	 jal cube #get the y^3 value
	 add $t3,$v0,$zero #storing the return value (y^3) in register t3
	 #calculating 47y^3
	 sll $t6,$t3,5  #t6 = 32y^3
	 sll $t5,$t3,3  #t5 = 8y^3
	 add $t6,$t6,$t5 #t6 = 40y^3
	 sll $t5,$t3,2  #t5 = 4y^3
	 add $t6,$t6,$t5 #t6 = 44y^3
	 sll $t5,$t3,1  #t5 = 2y^3
	 add $t6,$t6,$t5 #t6 = 46y^3
	 add $t6,$t6,$t3 #t6 = 47y^3
	 sub $t4,$t4,$t6 #t4 = 92x^2 - 51x -47y^3
	 jal square #get the y^2 value
	 add $t3,$v0,$zero #storing the return value (y^2) in register t3
	 #calculating 18y^2
	 sll $t6,$t3,4  #t6 = 16y^2
	 sll $t5,$t3,1  #t5 = 2y^2
	 add $t6,$t6,$t5 #t6 = 18y^2
	 sub $t4,$t4,$t6 #t4 = 92x^2 - 51x - 47y^3 - 18y^2
	 #calculating 50y
	 sll $t6,$s1,5  #t6 = 32y
	 sll $t5,$s1,4  #t5 = 16y
	 add $t6,$t6,$t5 #t6 = 48y
	 sll $t5,$s1,1  #t5 = 2y
	 add $t6,$t6,$t5 #t6 = 50y
	 add $t4,$t4,$t6 #t4 = 92x^2 - 51x - 47y^3 - 18y^2 + 50y
	 addi $t4,$t4,61 #t4 = 92x^2 - 51x - 47y^3 - 18y^2 + 50y + 61
	 #calculating h*(t4 value)
	 addi $s5,$zero,0  #initializing s5 to 0
	 addi $s5,$zero,1  #storing 1 at register s5 to use it in comparison
	 addi $t0,$zero,0  #initialize t0 to 0
for3: 	 slt $t1,$s2,$s5  #if h < s5 t1 will equal to 1
	 bne $t1,$zero,L4 #when h < s5 we will have h*value of t4 and it will jump to L1
	 add $t0,$t0,$t4  #adding t4 value to itself h times
	 addi $s5,$s5, 1  #increasing s5 value
	 j for3
L4:	 add $s1,$s1,$t0  #y = y + h*(t4 value)
	 add $s0,$s0,$s2  #x = x + h
	 addi $s6,$s6,1
	 j for2
L3:	 lw $ra,0($sp)
	 addi $sp,$sp,4
	 add $v0,$s1,$zero
	 jr $ra
	
	
	
square: addi $sp,$sp,-4 #preserve the address stored in ra and preserve a0
	sw $ra,0($sp)
	jal sign_check
	addi $s4,$zero,1  #storing 1 at register s4 to use it in comparison
	addi $t0,$zero,0  #initialize t0 to 0
for: 	slt $t1,$a0,$s4  #if a0 (parameter we want its squared value is stored in it) < s4 t1 will equal to 1
	bne $t1,$zero,L1 #when a0 < s4 we will have parameter^2 and it will jump to L1
	add $t0,$t0,$a0  #adding parameter to itself till its squared value
	addi $s4,$s4, 1  #increasing s4
	j for 
L1:	lw $ra,0($sp)
	addi $sp,$sp,4
	add $v0,$zero,$t0  #stores the result at v0 to return it
	jr $ra
	
	
	
cube:	addi $sp,$sp,-4 #preserve the address stored in ra and preserve a0
	sw $ra,0($sp)
	jal square  
	add $t2,$v0,$zero #storing y^2 in t2
	addi $s4,$zero,0  #initialize s4 to 0
	addi $s4,$zero,1  #storing 1 at register s4 to use it in comparison
	addi $t0,$zero,0  #initialize t0 to 0
for1: 	slt $t1,$a0,$s4   #if a0 (parameter we want its cubed value is stored in it) < s4 t1 will equal to 1
	bne $t1,$zero,L2  #when a0 < s4 we will have parameter^2 and it will jump to L2
	add $t0,$t0,$t2   #adding squared value to itself till its cubed value
	addi $s4,$s4, 1   #increasing s4
	j for1 
L2:	lw $ra,0($sp)
	addi $sp,$sp,4
	add $v0,$zero,$t0  #stores the result at v0 to return it
	jr $ra	
		
	
	    
sign_check:  add $t7,$zero,$zero
	     slt $t7,$a0,$zero 
	     bne $t7,$zero,negative_sign
	     jr $ra
negative_sign: sub $a0,$zero,$a0
	       jr $ra	     



Exit:	  	  	  
