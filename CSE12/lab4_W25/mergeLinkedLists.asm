#---------------------------------------------------------------------------------------------#
mergeLinkedLists:
#Function to merge the 2 sorted lists together and the resultant list is also sorted
#Inputs: a0 = address of head of 1st linked list; so if a0=0x10040000 points to empty list, then mem[0x10040000]=0
#	a1 = = address of head of 2nd linked list;
#Output: the first linked contains the combined elements of 1st and second lists sorted
	addi sp, sp, -8
	sd ra, 0(sp)
	
	lw t0, 0(a1) # t0=address pointed to by head (can be null)
	merge_iteration:
	beqz t0, merge_return
	
	# preserve a1, a0, t0
	addi sp, sp, -12
	sw a0, 0(sp) # a0=pointer to head1
	sw a1, 4(sp) # a1=pointer to head2
	sw t0, 8(sp) # t0=pointer to current node
	
	lw a1, 0(t0) # a1=key value of node
	# we can leave a0 as is because insertSorted wants the same thing
	jal insertSorted
	
	# restore a1, a0 (we can ignore the return value of insertSorted)
	lw a0, 0(sp)
	lw a1, 4(sp)
	lw t0, 8(sp)
	addi sp, sp, 12
	
	lw t0, 4(t0) # t0 points to next node
	j merge_iteration
	
	
	merge_return:
	ld ra, 0(sp)
	addi sp, sp, 8
	ret
