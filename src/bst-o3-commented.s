	.text
	.file	"bst.c"
	.globl	make_node
	.align	16, 0x90
	.type	make_node,@function
make_node:
	.cfi_startproc
	pushq	%r15
.Ltmp0:
	.cfi_def_cfa_offset 16
	pushq	%r14
.Ltmp1:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp2:
	.cfi_def_cfa_offset 32
.Ltmp3:
	.cfi_offset %rbx, -32
.Ltmp4:
	.cfi_offset %r14, -24
.Ltmp5:
	.cfi_offset %r15, -16
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movl	$24, %edi
	callq	malloc
	movq	%rbx, (%rax)
	movq	%r15, 8(%rax)
	movq	%r14, 16(%rax)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end0:
	.size	make_node, .Lfunc_end0-make_node
	.cfi_endproc

	.globl	preorder
	.align	16, 0x90
	.type	preorder,@function
preorder:
	.cfi_startproc
	pushq	%r14
.Ltmp6:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp7:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp8:
	.cfi_def_cfa_offset 32
.Ltmp9:
	.cfi_offset %rbx, -24
.Ltmp10:
	.cfi_offset %r14, -16
	movq	%rsi, %r14
	movq	%rdi, %rbx
	jmp	.LBB1_2
	.align	16, 0x90
.LBB1_1:
	movq	%rbx, %rdi
	callq	*%r14
	movq	(%rbx), %rdi
	movq	%r14, %rsi
	callq	preorder
	movq	8(%rbx), %rbx
.LBB1_2:
	testq	%rbx, %rbx
	jne	.LBB1_1
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end1:
	.size	preorder, .Lfunc_end1-preorder
	.cfi_endproc

	.globl	inorder
	.align	16, 0x90
	.type	inorder,@function
inorder:
	.cfi_startproc
	pushq	%r14
.Ltmp11:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp12:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp13:
	.cfi_def_cfa_offset 32
.Ltmp14:
	.cfi_offset %rbx, -24
.Ltmp15:
	.cfi_offset %r14, -16
	movq	%rsi, %r14
	movq	%rdi, %rbx
	jmp	.LBB2_2
	.align	16, 0x90
.LBB2_1:
	movq	(%rbx), %rdi
	movq	%r14, %rsi
	callq	inorder
	movq	%rbx, %rdi
	callq	*%r14
	movq	8(%rbx), %rbx
.LBB2_2:
	testq	%rbx, %rbx
	jne	.LBB2_1
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end2:
	.size	inorder, .Lfunc_end2-inorder
	.cfi_endproc

	.globl	postorder
	.align	16, 0x90
	.type	postorder,@function
postorder:
	.cfi_startproc
	pushq	%r14
.Ltmp16:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp17:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp18:
	.cfi_def_cfa_offset 32
.Ltmp19:
	.cfi_offset %rbx, -24
.Ltmp20:
	.cfi_offset %r14, -16
	movq	%rdi, %rbx
	testq	%rbx, %rbx
	je	.LBB3_1
	movq	(%rbx), %rdi
	movq	%rsi, %r14
	callq	postorder
	movq	8(%rbx), %rdi
	movq	%r14, %rsi
	callq	postorder
	movq	%rbx, %rdi
	movq	%r14, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*%rax
.LBB3_1:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end3:
	.size	postorder, .Lfunc_end3-postorder
	.cfi_endproc

# Function find()
# Finds a given value in the tree and returns its place,
# or the place where it would be added if it is not present.
# The O3 version of the function has its recursive calls unfolded into a loop.
	.globl	find
	.align	16, 0x90
	.type	find,@function
find:
	.cfi_startproc
	jmp	.LBB4_1  # Skips the next label the first time the loop is entered.
	.align	16, 0x90
.LBB4_5:  # At this point %rax has a child of 'root_ptr'.
	movq	%rax, %rdi  # Re-set the argument value to one of its children.
        # This operation removes the need of a recursive function calls.
.LBB4_1:
	movq	(%rdi), %rax  # Copy the 'root_ptr' into a working register (%rax).
        # The first bytes of %rax now point to to the left child.

        # Now compare it to NULL, via a bitwise AND.
        # If the resulting bits are 0s, the Zero Flag is set to 1.
	testq	%rax, %rax  # bitwise AND
	je	.LBB4_6  # Jumps to the next label, if ZF == 1.

        # If 'root_ptr' was not NULL, compare its 'data' to 'x'.
        # 'x' is the argument passed to the function and stored in %rsi.
	cmpq	%rsi, 16(%rax)  # 'root_ptr'->'data' starts at the 16th byte of %rax.
	jg	.LBB4_5  # If 'data' was greater than 'x', go to the start of the loop.
	je	.LBB4_6  # If 'data' was equal to 'x', go to the next label.

        # Otherwise 'data' was smaller than 'x'.
	addq	$8, %rax  # Increase %rax by 8, making it point to the right child.
	jmp	.LBB4_5  # Go to the start of the loop.
.LBB4_6:  # The two instructions here set the return value and exit the function.
	movq	%rdi, %rax  # The return value is always set as 'root_ptr'.
	retq  # Exit the function.
.Lfunc_end4:
	.size	find, .Lfunc_end4-find
	.cfi_endproc
# End of find() function.

	.globl	contains
	.align	16, 0x90
	.type	contains,@function
contains:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.LBB5_7
	xorl	%eax, %eax
	.align	16, 0x90
.LBB5_2:
	cmpq	%rsi, 16(%rdi)
	jg	.LBB5_6
	je	.LBB5_4
	addq	$8, %rdi
.LBB5_6:
	movq	(%rdi), %rdi
	testq	%rdi, %rdi
	jne	.LBB5_2
	jmp	.LBB5_7
.LBB5_4:
	movq	%rdi, %rax
.LBB5_7:
	testq	%rax, %rax
	setne	%al
	movzbl	%al, %eax
	retq
.Lfunc_end5:
	.size	contains, .Lfunc_end5-contains
	.cfi_endproc

	.globl	insert
	.align	16, 0x90
	.type	insert,@function
insert:
	.cfi_startproc
	pushq	%r14
.Ltmp21:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp22:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp23:
	.cfi_def_cfa_offset 32
.Ltmp24:
	.cfi_offset %rbx, -24
.Ltmp25:
	.cfi_offset %r14, -16
	movq	%rsi, %r14
	movq	%rdi, %rbx
	jmp	.LBB6_1
	.align	16, 0x90
.LBB6_5:
	movq	%rax, %rbx
.LBB6_1:
	movq	(%rbx), %rax
	testq	%rax, %rax
	je	.LBB6_6
	cmpq	%r14, 16(%rax)
	jg	.LBB6_5
	je	.LBB6_7
	addq	$8, %rax
	jmp	.LBB6_5
.LBB6_6:
	movl	$24, %edi
	callq	malloc
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rax)
	movq	%r14, 16(%rax)
	movq	%rax, (%rbx)
.LBB6_7:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end6:
	.size	insert, .Lfunc_end6-insert
	.cfi_endproc


	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.section	".note.GNU-stack","",@progbits
