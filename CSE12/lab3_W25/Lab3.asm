
.macro exit #macro to exit program
	li a7, 10
	ecall
	.end_macro	

.macro print_str(%string1) #macro to print any string
	li a7,4 
	la a0, %string1
	ecall
	.end_macro
	
	
.macro read_n(%x)#macro to input integer n into register x
	li a7, 5
	ecall 		
	#a0 now contains user input
	addi %x, a0, 0
	.end_macro
	
.macro print_n(%x)#macro to input integer n into register x
	addi a0,%x, 0
	li a7, 1
	ecall
.end_macro

.macro 	file_open_for_write_append(%str)
	la a0, %str
	li a1, 1
	li a7, 1024
	ecall
.end_macro
	
.macro  initialise_buffer_counter
	#buffer begins at location 0x10040000
	#location 0x10040000 to keep track of which address we store each character byte to 
	#actual buffer to store the characters begins at 0x10040008
	
	#initialize mem[0x10040000] to 0x10040008
	addi sp, sp, -16
	sd t0, 0(sp)
	sd t1, 8(sp)
	
	li t0, 0x10040000
	li t1, 0x10040008
	sd t1, 0(t0)
	
	ld t0, 0(sp)
	ld t1, 8(sp)
	addi sp, sp, 16
	.end_macro
	

.macro write_to_buffer(%char)
	#NOTE:this macro can add ONLY 1 character byte at a time to the file buffer!
	
	addi sp, sp, -16
	sd t0, 0(sp)
	sd t4, 8(sp)
	
	
	li t0, 0x10040000
	ld t4, 0(t0)#t4 is starting address
	#t4 now points to location where we store the current %char byte
	
	#store character to file buffer
	li t0, %char
	sb t0, 0(t4)
	
	#update address location for next character to be stored in file buffer
	li t0, 0x10040000
	addi t4, t4, 1
	sd t4, 0(t0)
	
	ld t0, 0(sp)
	ld t4, 8(sp)
	addi sp, sp, 16
	.end_macro

.macro fileRead(%file_descriptor_register, %file_buffer_address)
#macro reads upto first 10,000 characters from file
	addi a0, %file_descriptor_register, 0
	li a1, %file_buffer_address
	li a2, 10000
	li a7, 63
	ecall
.end_macro 

.macro fileWrite(%file_descriptor_register, %file_buffer_address,%file_buffer_address_pointer)
#macro writes contents of file buffer to file
	addi a0, %file_descriptor_register, 0
	li a1, %file_buffer_address
	li a7, 64
	
	#a2 needs to contains number of bytes sent to file
	li a2, %file_buffer_address_pointer
	ld a2, 0(a2)
	sub a2, a2, a1
	
	ecall
.end_macro 

.macro print_file_contents(%ptr_register)
	li a7, 4
	addi a0, %ptr_register, 0
	ecall
	#entire file content is essentially stored as a string
.end_macro
	


.macro close_file(%file_descriptor_register)
	li a7, 57
	addi a0, %file_descriptor_register, 0
	ecall
.end_macro

.data
	prompt: .asciz  "Enter the height of the pattern (must be greater than 0):"
	invalidMsg: .asciz  "Invalid Entry!"
	newLine: .asciz  "\n"
	star: .asciz "*"
	blankspace: .asciz " "
	outputMsg: .asciz  " display pattern saved to lab3_output.txt "
	filename: .asciz "lab3_output.txt"
	Zero:.asciz"0"
	
.text
	file_open_for_write_append(filename)
	#a0 now contaimns the file descriptor (i.e. ID no.)
	#save to t6 register
	addi t6, a0, 0
	
	initialise_buffer_counter
	
	#for utilsing macro write_to_buffer, here are tips:
	#0x2a is the ASCI code input for star(*)
	#0x24 is the ASCI code input for dollar($)
	#0x30  is the ASCI code input for  the character '0'
	#0x0a  is the ASCI code input for  newLine (/n)

	
	#START WRITING YOUR CODE FROM THIS LINE ONWARDS
	#DO NOT  use the registers a0, a1, a7, t6, sp anywhere in your code.
	
	#................ your code starts here..........................................................#
	
	print_str(prompt)
	
reprompt:
	read_n(t0) 			# total number of rows (constant)
	bgtz, t0, valid_input_received
	print_str(invalidMsg)
	print_str(newLine)
	print_str(prompt)
	j reprompt
valid_input_received:
	li t1, 1 			# current row
	li t2, 1 			# number of stars (increments by 2)
	addi t3, t0, -1 		# number of spaces on either side (decrements by 1)
loop_iteration:
	bgt t1, t0, loop_end
	
	li t4, 1 			# random iterator/index register (reused)	
	loop_inner1_iteration:
		bgt t4, t3, loop_inner1_end
		print_str(blankspace)
		write_to_buffer(0x20)
		addi t4, t4, 1
		j loop_inner1_iteration
	loop_inner1_end:
	
	li t4, 1
	loop_inner2_iteration:
		bgt t4, t2, loop_inner2_end
		print_str(star)
		write_to_buffer(0x2a)
		addi t4, t4, 1
		j loop_inner2_iteration
	loop_inner2_end:
	
	print_str(newLine)
	write_to_buffer(0x0a)
		
	addi t1, t1, 1
	addi t2, t2, 2
	addi t3, t3, -1
	
	j loop_iteration
loop_end:
	


	#................ your code ends here..........................................................#
	
	#END YOUR CODE ABOVE THIS COMMENT
	#Don't change anything below this comment!
Exit:	
	#write null character to end of file
	write_to_buffer(0x00)
	
	#write file buffer to file
	fileWrite(t6, 0x10040008,0x10040000)
	addi t5, a0, 0
	
	print_str(newLine)
	print_str(outputMsg)
	
	exit
	
	
