	.text
	.file	"bst.c"

# Function make_node()
# Creates and returns a bst_node with given children and value.
	.globl	make_node
	.align	16, 0x90
	.type	make_node,@function
make_node:
	.cfi_startproc
	pushq	%rbp  # Callee save push - saves the old frame pointer.
.Ltmp0:
	.cfi_def_cfa_offset 16
.Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Put the function call on the stack - sets up a new frame pointer.
.Ltmp2:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp  # Allocate space for the new stack frame.
	movl	$24, %eax  # The argument to pass to malloc.
	movl	%eax, %ecx  # Save it in %ecx.
    
        # The following three lines save the passed arguments relative to the base pointer register.
	movq	%rdi, -8(%rbp)  # Saves the value of argument 'l'.
	movq	%rsi, -16(%rbp)  # Saves the value of argument 'r'.
	movq	%rdx, -24(%rbp)  # Saves the value of argument 'data'.
	movq	%rcx, %rdi  # Argument for the function call below. Notice that %rcx contains %ecx from a few lines above.
	callq	malloc  # Calls malloc to allocate memory for the node.
	movq	%rax, -32(%rbp)  # Saves the result from malloc. By convention malloc puts it in %rax.
    
        # The following three groups of three lines each save the values of the arguments in the fields of the node.
        # Notice that the relative base pointers match the ones from above.
	movq	-8(%rbp), %rax  # Takes 'l'
	movq	-32(%rbp), %rcx  # Takes 'n->l'
	movq	%rax, (%rcx)  # Assigns 'l' to 'n->l'
	movq	-16(%rbp), %rax  # Takes 'r'
	movq	-32(%rbp), %rcx  # Takes 'n->r'
	movq	%rax, 8(%rcx)  # Assigns 'r' to 'n->r'
	movq	-24(%rbp), %rax  # Takes 'data'
	movq	-32(%rbp), %rcx  # Takes 'n->data'
	movq	%rax, 16(%rcx)  # Assigns 'data' to 'n->data'
    
	movq	-32(%rbp), %rax  # Prepare the value (the created node) to be returned - by convention in %rax.
	addq	$32, %rsp  # Restore space, deleting the stack frame.
	popq	%rbp  # Callee save pop - restores the old frame pointer.
	retq
.Lfunc_end0:
	.size	make_node, .Lfunc_end0-make_node
	.cfi_endproc
# End of function make_node()

# Function preorder()
# A preorder traversal, starting at a given node 'root' and applying a given function 'visit' on each node in the tree.
	.globl	preorder
	.align	16, 0x90
	.type	preorder,@function
preorder:
	.cfi_startproc
	pushq	%rbp  # Callee save push - saves the old frame pointer.
.Ltmp3:
	.cfi_def_cfa_offset 16
.Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Put the function call on the stack - sets up a new frame pointer.
.Ltmp5:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp  # Allocate space for the new stack frame.
	# The following two lines save the passed arguments relative to the base pointer register.
        movq	%rdi, -8(%rbp)  # Saves the value of argument 'root'.
	movq	%rsi, -16(%rbp)  # Saves the value of argument '*visit'.
	cmpq	$0, -8(%rbp)  # Checks whether the the 'root' is null.
	je	.LBB1_2  # Jumps over the next instructions if the above is true.
    
        # Calls the 'visit' function on the 'root' node.
	movq	-16(%rbp), %rax  # Takes the previously saved 'visit' function.
	movq	-8(%rbp), %rdi  # Prepares the argument for the function call below.
	callq	*%rax
    
        # The following four lines prepare the arguments for and call the 'preorder' function with the left node and the 'visit' function.
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi  # The left child of the root.
	movq	-16(%rbp), %rsi  # The 'visit' function.
        callq	preorder
    
        # The following four lines prepare the arguments for and call the 'preorder' function with the right node and the 'visit' function.
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdi  # The right child of the root.
	movq	-16(%rbp), %rsi  # The 'visit' function.
	callq	preorder
.LBB1_2:
	addq	$16, %rsp  # Restore the space, deleting the stack frame.
	popq	%rbp  # Callee save pop - restores the old frame pointer.
	retq
.Lfunc_end1:
	.size	preorder, .Lfunc_end1-preorder
	.cfi_endproc
# End of function preorder()

# Function inorder()
# An inorder traversal, starting at a given node 'root' and applying a given function 'visit' on each node in the tree.
	.globl	inorder
	.align	16, 0x90
	.type	inorder,@function
inorder:
	.cfi_startproc
	pushq	%rbp  # Callee save push - saves the old frame pointer.
.Ltmp6:
	.cfi_def_cfa_offset 16
.Ltmp7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Put the function call on the stack - sets up a new frame pointer.
.Ltmp8:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp  # Allocate space for the new stack frame.
	movq	%rdi, -8(%rbp)  # Saves the value of argument 'root'.
	movq	%rsi, -16(%rbp)  # Saves the value of argument '*visit'.
	cmpq	$0, -8(%rbp)  # Checks whether the the 'root' is null.
	je	.LBB2_2  # Jumps over the next instructions if the above is true.
    
	# The following four lines prepare the arguments for and call the 'inorder' function with the left node and the 'visit' function.
        movq	-8(%rbp), %rax
	movq	(%rax), %rdi  # The left child of the root.
	movq	-16(%rbp), %rsi  # The 'visit' function.
	callq	inorder
	
        # Calls the 'visit' function on the 'root' node.
        movq	-16(%rbp), %rax  # Takes the 'visit' function.
	movq	-8(%rbp), %rdi  # Prepares the argument for the function call below.
	callq	*%rax
	
        # The following four lines prepare the arguments for and call the 'inorder' function with the right node and the 'visit' function.
        movq	-8(%rbp), %rax
	movq	8(%rax), %rdi  # The right child of the root.
	movq	-16(%rbp), %rsi  # The 'visit' function.
	callq	inorder
.LBB2_2:
	addq	$16, %rsp  # Restore the space, deleting the stack frame.
	popq	%rbp  # Callee save pop - restores the old frame pointer.
	retq
.Lfunc_end2:
	.size	inorder, .Lfunc_end2-inorder
	.cfi_endproc
# End of function inorder()

# Function postorder()
# A postorder traversal, starting at a given node 'root' and applying a given function 'visit' on each node in the tree.
	.globl	postorder
	.align	16, 0x90
	.type	postorder,@function
postorder:
	.cfi_startproc
	pushq	%rbp  # Callee save push - saves the old frame pointer.
.Ltmp9:
	.cfi_def_cfa_offset 16
.Ltmp10:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Put the function call on the stack - sets up a new frame pointer.
.Ltmp11:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp  # Allocate space for the new stack frame.
	movq	%rdi, -8(%rbp)  # Saves the value of argument 'root'.
	movq	%rsi, -16(%rbp)  # Saves the value of argument '*visit'.
	cmpq	$0, -8(%rbp)  # Checks whether the the 'root' is null.
	je	.LBB3_2  # Jumps over the next instructions if the above is true.
    
        # The following four lines prepare the arguments for and call the 'postorder' function with the left node and the 'visit' function.
        movq	-8(%rbp), %rax
	movq	(%rax), %rdi  # The left child of the root.
	movq	-16(%rbp), %rsi  # The 'visit' function.
	callq	postorder
	
        # The following four lines prepare the arguments for and call the 'postorder' function with the right node and the 'visit' function.
        movq	-8(%rbp), %rax
	movq	8(%rax), %rdi  # The right child of the root.
	movq	-16(%rbp), %rsi  # The 'visit' function.
	callq	postorder
    
        # Calls the 'visit' function on the 'root' node.
	movq	-16(%rbp), %rax  # Takes the 'visit' function.
	movq	-8(%rbp), %rdi  # Prepares the argument for the function call below.
	callq	*%rax
.LBB3_2:
	addq	$16, %rsp  # Restore the space, deleting the stack frame.
	popq	%rbp  # Callee save pop - restores the old frame pointer.
	retq
.Lfunc_end3:
	.size	postorder, .Lfunc_end3-postorder
	.cfi_endproc
# End of function postorder()

# Function find()
# Finds a given value in the tree and returns its place, or the place where it would be added if it is not present.
	.globl	find  # Defines 'find' as a global object.
	.align	16, 0x90  # line alignment
	.type	find,@function  # Defines the type of find as a function.
find:
	.cfi_startproc
	pushq	%rbp  # Callee save push - saves the old frame pointer.
.Ltmp12:
	.cfi_def_cfa_offset 16
.Ltmp13:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Put the function call on the stack - sets up a new frame pointer.
.Ltmp14:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp  # Allocate space for the new stack frame.
	movq	%rdi, -16(%rbp)  # Saves the value of the argument 'root_ptr'.
	movq	%rsi, -24(%rbp)  # Saves the value of the argument 'x'.
	#APP
	nop  # Does nothing (NO Operation) - generated by the example in-line assembly.

	#NO_APP
        # The following checks if the 'root_ptr' is NULL and jumps over a couple of lines if not.
	movq	-16(%rbp), %rsi  # Takes the 'root_ptr'.
	cmpq	$0, (%rsi)  # Compares it to 0 (NULL).
	jne	.LBB4_2  # If 'root_ptr' was not NULL, jumps to label .LBB4_2.
    
        # If 'root_ptr' was NULL, then set the value to be returned. The jump goes to the last lines of the function.
	movq	-16(%rbp), %rax  # The value is the current 'root_ptr'
	movq	%rax, -8(%rbp)
	jmp	.LBB4_7
.LBB4_2:
        # The next few lines take the value in the root defined by 'root_ptr'->'data' and compare it to the value of 'x'.
	movq	-16(%rbp), %rax  # The value is the current 'root_ptr'
	movq	(%rax), %rax  # Opens the contents of the object.
	movq	16(%rax), %rax  # Takes the value at 16(%rax) ('root_ptr'->'data') and stores it in %rax.
	movq	%rax, -32(%rbp)  # At this point -32(%rbp) ('d') has the value of 'root_ptr'->'data'.
    
	movq	-24(%rbp), %rax  # Takes the value of 'x'.
	cmpq	-32(%rbp), %rax  # Compares 'x' and 'd' ('root_ptr'->'data').
	jge	.LBB4_4  # If 'x' is greater or equals to 'd', jumps to label .LBB4_4.

	# If 'x' was less than 'd' ('root_ptr'->'data'), call the 'find' function with the left child.
	movq	-16(%rbp), %rax  # Takes the whole 'root_ptr'.
	movq	(%rax), %rdi  # Takes the first 8 bytes from %rax ('root_ptr'->'l') and sets the first argument.
	movq	-24(%rbp), %rsi  # Set the second argument as 'x'.
	callq	find
	movq	%rax, -8(%rbp)  # Prepare to return the value returned by the function call.
	jmp	.LBB4_7
.LBB4_4:	
	# The next two lines compare the value of 'x' to 'd' (defined above).
	movq	-24(%rbp), %rax  # Takes the value of 'x'.
	cmpq	-32(%rbp), %rax  # Compares 'x' and 'd' ('root_ptr'->'data').
	jne	.LBB4_6  # If 'x' is not equal to 'd', jumps to label .LBB4_6.

	# If they are, we have found the value we are looking for. Prepare to return the 'root_ptr'. The jump goes to the last lines of the function.
	movq	-16(%rbp), %rax  # The value is the current 'root_ptr'
	movq	%rax, -8(%rbp)
	jmp	.LBB4_7
.LBB4_6:
	# Since the previous comparassions have failed, than 'x' must be graeter than 'd'. So we need to go to the right child.
	movq	-16(%rbp), %rax  # Takes the whole 'root_ptr'.
	movq	(%rax), %rax  # Opens the contents of the object.
	addq	$8, %rax  # Moves 8 bytes over the contents of 'root_ptr' (reaching 'r').
	movq	-24(%rbp), %rsi  # And now the second argument to the function is 'x'.
	movq	%rax, %rdi  # Set the first argument as 'root_ptr'->'r'.
	callq	find
	movq	%rax, -8(%rbp)  # Prepare to return the value returned by the function call.
.LBB4_7:  # This label contains the return statement of the function. Previous parts of the function put a value to be returned in -8(%rbp).
	movq	-8(%rbp), %rax  # Prepare the value (the found node position) to be returned - by convention in %rax.
	addq	$32, %rsp  # Restore the space, deleting the stack frame.
	popq	%rbp  # Callee save pop - restores the old frame pointer.
	retq  # Returns from the function call.
.Lfunc_end4:
	.size	find, .Lfunc_end4-find  # Defines the size of the 'find' function as the difference between two labels.
	.cfi_endproc
# End of function find()

# Function contains()
# Accepts a value and calls 'find()' with it.
# Then determines if the result is a node or an empty place.
	.globl	contains
	.align	16, 0x90
	.type	contains,@function
contains:
	.cfi_startproc
	pushq	%rbp  # Callee save push - saves the old frame poitner.
.Ltmp15:
	.cfi_def_cfa_offset 16
.Ltmp16:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Put the function call on the stack - sets up a new frame pointer.
.Ltmp17:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp  # Allocate space for the new stack frame.
        # The next couple of lines load the arguments passed to the function.
	leaq	-8(%rbp), %rax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)

        # These instructions set the arguments and call the 'find' function.
	movq	-16(%rbp), %rsi
	movq	%rax, %rdi
	callq	find
	movq	%rax, -24(%rbp) # Save the value returned by the 'find' function.

        # The next few lines compare the result to NULL and save it as a boolean which is then returned.
	movq	-24(%rbp), %rax
	cmpq	$0, (%rax)
	setne	%cl
	andb	$1, %cl
	movzbl	%cl, %eax
	addq	$32, %rsp  # Restore the space, deleting the stack frame.
	popq	%rbp  # Callee save pop - restores the old frame pointer.
	retq
.Lfunc_end5:
	.size	contains, .Lfunc_end5-contains
	.cfi_endproc
# End of function contains()

# Function insert()
# Inserts a given value in the tree.
# Searches for the value in the tree (with 'find()') and if it is not there, it adds it to the returned position.
	.globl	insert
	.align	16, 0x90
	.type	insert,@function
insert:
	.cfi_startproc
	pushq	%rbp  # Callee save push - saves the old frame pointer.
.Ltmp18:
	.cfi_def_cfa_offset 16
.Ltmp19:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Put the function call on the stack - sets up a new frame pointer.
.Ltmp20:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp  # Allocate space for the new stack frame.
    
        # The next few lines take the arguments passed to the 'insert' function and call the 'find' function with them.
	movq	%rdi, -8(%rbp)  # Takes 'root_ptr'
	movq	%rsi, -16(%rbp)  # Takes 'x'
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	find
        # Saves the value returned by the 'find()' call and compares it to NULL.
	movq	%rax, -24(%rbp)  # Now -24(%rbp) contains a node.
	movq	-24(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB6_2  # If it is no NULL, the program skips all the way to the end of the function.
    
        # Otherwise, create a new node.
	xorl	%eax, %eax  # sets the register to 0
	movl	%eax, %ecx  # now this register is essentially NULL
    
        # Set arguments and call function 'make_node' wiht (NULL, NULL, 'x')
	movq	-16(%rbp), %rdx  # 'x'
	movq	%rcx, %rdi  # NULL
	movq	%rcx, %rsi  # NULL
	callq	make_node
    
        # These two lines save the node returned by 'make_node()' in the NULL node returned by 'find()'.
	movq	-24(%rbp), %rcx
	movq	%rax, (%rcx)
.LBB6_2:
	addq	$32, %rsp  # Restore the space, deleting the stack frame.
	popq	%rbp  # Callee save pop - restores the old frame pointer.
	retq
.Lfunc_end6:
	.size	insert, .Lfunc_end6-insert
	.cfi_endproc
# End of function insert()

	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.section	".note.GNU-stack","",@progbits
