#---------------------------------------------------------------------------------------------#

#.include "newNode.asm"

insertSorted:
# Function to insert a new node into the given linkedlist in ascending order
# Inputs: a1 = value of the node key
#	a0 = address of head of linked list; so if a0=0x10040000 points to empty list, then mem[0x10040000]=0
# Outputs: a0 = pointer to the final node in current sorted linked list

	# preserve ra
	addi sp, sp, -8
	sd ra, 0(sp)

	add t0, zero, a0 # t0 is now pointer to head
	jal newNode # a0 is now a pointer to newnode
	
	lw t1, 0(t0) # t0 points to head; t1=the value of head (a pointer to first node, or null)
	bnez t1, list_has_items
	# if head==NULL, set head to our new node and return early
	sw a0, 0(t0)
	j return
	
	list_has_items:
	lw t1, 0(t0) # t1=pointer to first node (so we can set newnode.next to the first node)
	lw t2, 0(t1) # t2=first node's key value
	blt t2, a1, iterate
	# if first node's key is >= a1, set head (t0) to newnode (a0) and set newnode.next to first node
	sw a0, 0(t0) # set head to newnode
	sw t1, 4(a0) # set newnode.next to first node
	j return
	
	iterate:
	addi t0, t1, 0 # t0 points to first node
	
	# AT THIS POINT: We are officially past head. The only thing that can be modified now is the first and later nodes.
	# NOTE: a0 = pointer to newnode, a1: our newnode's key value, t0: main pointer to current node
	# GIVEN: 0(t0) MUST BE LESS THAN a1.
	lw t1, 4(t0) # t1=pointer to next node
	beqz t1, append
	lw t2, 0(t1) # t2=key value of next node
	bgt t2, a1, insert
	j iterate
	
	append:
	sw a0, 4(t0)
	j walk_remaining
	insert:
	sw a0, 4(t0)
	sw t1, 4(a0)
	j walk_remaining
	
	walk_remaining:
	beqz a0, return
	lw a0, 4(a0)
	j walk_remaining
	
	return:
	# restore stack
	ld ra, 0(sp)
	addi sp, sp, 8
	ret
	
# 	lw t6, 0(t0) # t6 is now pointer to linked list's node0.key
# 	lw a2, 0(t6) # a2 is now the value of node0.key
# 	bgt t6, a2, insert # if node0.key > a1, set head (t0) to our newnode (a0) and set our newnode.next to t6
# 
# 	# iterate list until either we're sorted or have reached the end, then insert
# 	iteration:
# 	lw t1, 4(t0) # t1 is node.next
# 	beqz t1, insert # if node.next == NULL, insert immediately after: sw a1, 4(t0)
# 	lw t2, 0(t0) # t2 is node.key
# 
# 	bgt t2, a1, insert # if node.key > a1, insert in between
# 	lw t0, 0(t2) # set t0 to point to next node
# 
# 	lw t0 4(t0) # set node pointer to next node
# 	j iteration
# 
# 	set_new_node_next:
# 
# 
# 	insert:
# 	sw a0
