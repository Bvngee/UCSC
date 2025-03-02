#---------------------------------------------------------------------------------------------#
print_list:
# Function to traverse the linked list and print the values
# Inputs: a1 = head of the linked list

iteration:
	lw t0, 0(a1) # key
	lw t1, 4(a1) # next
	print_int(t0)
	li t2, 0x20
	print_str(comma_space)
	beqz t1, finished
	add a1, zero, t1
	j iteration

finished:
	print_str(newline)
	ret
