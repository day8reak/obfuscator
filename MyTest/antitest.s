	.text
	.file	"antitest.cpp"
	.section	.text.startup,"ax",@progbits
	.p2align	4, 0x90                         # -- Begin function __cxx_global_var_init
	.type	__cxx_global_var_init,@function
__cxx_global_var_init:                  # @__cxx_global_var_init
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$_ZStL8__ioinit, %edi
	callq	_ZNSt8ios_base4InitC1Ev@PLT
	movq	_ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rdi
	movl	$_ZStL8__ioinit, %esi
	movl	$__dso_handle, %edx
	callq	__cxa_atexit@PLT
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	__cxx_global_var_init, .Lfunc_end0-__cxx_global_var_init
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function _Z8AntiDeepd
.LCPI1_0:
	.quad	0x3f50624dd2f1a9fc              # double 0.001
.LCPI1_1:
	.quad	0x4000000000000000              # double 2
	.text
	.globl	_Z8AntiDeepd
	.p2align	4, 0x90
	.type	_Z8AntiDeepd,@function
_Z8AntiDeepd:                           # @_Z8AntiDeepd
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movsd	%xmm0, -8(%rbp)
	movsd	.LCPI1_0(%rip), %xmm0           # xmm0 = mem[0],zero
	ucomisd	-8(%rbp), %xmm0
	jbe	.LBB1_2
# %bb.1:
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
	jmp	.LBB1_3
.LBB1_2:
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	movsd	.LCPI1_1(%rip), %xmm1           # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	callq	_Z8AntiDeepd
	movsd	%xmm0, -16(%rbp)
.LBB1_3:
	movsd	-16(%rbp), %xmm0                # xmm0 = mem[0],zero
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	_Z8AntiDeepd, .Lfunc_end1-_Z8AntiDeepd
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function _Z8AntiFuncd
.LCPI2_0:
	.quad	0x3ff0000000000000              # double 1
	.text
	.globl	_Z8AntiFuncd
	.p2align	4, 0x90
	.type	_Z8AntiFuncd,@function
_Z8AntiFuncd:                           # @_Z8AntiFuncd
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movsd	%xmm0, -8(%rbp)
	xorps	%xmm0, %xmm0
	ucomisd	-8(%rbp), %xmm0
	jbe	.LBB2_2
# %bb.1:
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	movq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rcx     # imm = 0x8000000000000000
	xorq	%rcx, %rax
	movq	%rax, %xmm0
	movsd	%xmm0, -8(%rbp)
	jmp	.LBB2_5
.LBB2_2:
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB2_4
	jp	.LBB2_4
# %bb.3:
	movsd	.LCPI2_0(%rip), %xmm0           # xmm0 = mem[0],zero
	addsd	-8(%rbp), %xmm0
	movsd	%xmm0, -8(%rbp)
.LBB2_4:
	jmp	.LBB2_5
.LBB2_5:
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	callq	_Z8AntiDeepd
	cvttsd2si	%xmm0, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	_Z8AntiFuncd, .Lfunc_end2-_Z8AntiFuncd
	.cfi_endproc
                                        # -- End function
	.globl	_Z9fibonaccii                   # -- Begin function _Z9fibonaccii
	.p2align	4, 0x90
	.type	_Z9fibonaccii,@function
_Z9fibonaccii:                          # @_Z9fibonaccii
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
	.cfi_offset %rbx, -24
	movl	%edi, -12(%rbp)
	cmpl	$1, -12(%rbp)
	jg	.LBB3_2
# %bb.1:
	movl	-12(%rbp), %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB3_3
.LBB3_2:
	movl	-12(%rbp), %edi
	subl	$1, %edi
	callq	_Z9fibonaccii
	movl	%eax, %ebx
	movl	-12(%rbp), %edi
	subl	$2, %edi
	callq	_Z9fibonaccii
	addl	%eax, %ebx
	movl	%ebx, -16(%rbp)
.LBB3_3:
	movl	-16(%rbp), %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	_Z9fibonaccii, .Lfunc_end3-_Z9fibonaccii
	.cfi_endproc
                                        # -- End function
	.globl	_Z10HaHa_errorv                 # -- Begin function _Z10HaHa_errorv
	.p2align	4, 0x90
	.type	_Z10HaHa_errorv,@function
_Z10HaHa_errorv:                        # @_Z10HaHa_errorv
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	$0, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$10, (%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	_Z10HaHa_errorv, .Lfunc_end4-_Z10HaHa_errorv
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function main
.LCPI5_0:
	.quad	0x4048000000000000              # double 48
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	$0, -20(%rbp)
.LBB5_1:                                # =>This Inner Loop Header: Depth=1
	movq	_ZSt4cout@GOTPCREL(%rip), %rdi
	movabsq	$.L.str, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	_ZSt3cin@GOTPCREL(%rip), %rdi
	leaq	-8(%rbp), %rsi
	callq	_ZNSirsERd@PLT
	movq	_ZSt3cin@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	_ZSt3cin@GOTPCREL(%rip), %rdi
	addq	-24(%rax), %rdi
	callq	_ZNKSt9basic_iosIcSt11char_traitsIcEE4failEv@PLT
	testb	$1, %al
	jne	.LBB5_4
# %bb.2:                                #   in Loop: Header=BB5_1 Depth=1
	xorps	%xmm0, %xmm0
	ucomisd	-8(%rbp), %xmm0
	jae	.LBB5_4
# %bb.3:                                #   in Loop: Header=BB5_1 Depth=1
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	cvttsd2si	-8(%rbp), %eax
	cvtsi2sd	%eax, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB5_4
	jp	.LBB5_4
	jmp	.LBB5_5
.LBB5_4:                                #   in Loop: Header=BB5_1 Depth=1
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	callq	_Z8AntiFuncd
	cvtsi2sd	%eax, %xmm0
	addsd	-8(%rbp), %xmm0
	movsd	%xmm0, -8(%rbp)
	movq	_ZSt4cout@GOTPCREL(%rip), %rdi
	movabsq	$.L.str.1, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	_ZSt3cin@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	_ZSt3cin@GOTPCREL(%rip), %rdi
	addq	-24(%rax), %rdi
	xorl	%esi, %esi
	callq	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT
	callq	_ZNSt14numeric_limitsIlE3maxEv
	movq	_ZSt3cin@GOTPCREL(%rip), %rdi
	movq	%rax, %rsi
	movl	$10, %edx
	callq	_ZNSi6ignoreEli@PLT
	jmp	.LBB5_9
.LBB5_5:                                #   in Loop: Header=BB5_1 Depth=1
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	movsd	.LCPI5_0(%rip), %xmm1           # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jb	.LBB5_7
# %bb.6:                                #   in Loop: Header=BB5_1 Depth=1
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	callq	_Z8AntiFuncd
	cvtsi2sd	%eax, %xmm0
	addsd	-8(%rbp), %xmm0
	movsd	%xmm0, -8(%rbp)
	movq	_ZSt4cout@GOTPCREL(%rip), %rdi
	movabsq	$.L.str.2, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	_ZSt3cin@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	_ZSt3cin@GOTPCREL(%rip), %rdi
	addq	-24(%rax), %rdi
	xorl	%esi, %esi
	callq	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT
	callq	_ZNSt14numeric_limitsIlE3maxEv
	movq	_ZSt3cin@GOTPCREL(%rip), %rdi
	movq	%rax, %rsi
	movl	$10, %edx
	callq	_ZNSi6ignoreEli@PLT
	jmp	.LBB5_8
.LBB5_7:
	cvttsd2si	-8(%rbp), %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB5_12
.LBB5_8:                                #   in Loop: Header=BB5_1 Depth=1
	jmp	.LBB5_9
.LBB5_9:                                #   in Loop: Header=BB5_1 Depth=1
	jmp	.LBB5_10
.LBB5_10:                               #   in Loop: Header=BB5_1 Depth=1
	movb	$1, %al
	testb	$1, %al
	jne	.LBB5_1
	jmp	.LBB5_11
.LBB5_11:                               # %.loopexit
	jmp	.LBB5_12
.LBB5_12:
	cmpl	$15, -16(%rbp)
	jne	.LBB5_14
# %bb.13:
	callq	_Z10HaHa_errorv
.LBB5_14:
	movq	_ZSt4cout@GOTPCREL(%rip), %rdi
	movabsq	$.L.str.3, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movl	$0, -12(%rbp)
.LBB5_15:                               # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB5_18
# %bb.16:                               #   in Loop: Header=BB5_15 Depth=1
	movl	-12(%rbp), %edi
	callq	_Z9fibonaccii
	movq	_ZSt4cout@GOTPCREL(%rip), %rdi
	movl	%eax, %esi
	callq	_ZNSolsEi@PLT
	movabsq	$.L.str.4, %rsi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
# %bb.17:                               #   in Loop: Header=BB5_15 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB5_15
.LBB5_18:
	movq	_ZSt4cout@GOTPCREL(%rip), %rdi
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rsi
	callq	_ZNSolsEPFRSoS_E@PLT
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	main, .Lfunc_end5-main
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt14numeric_limitsIlE3maxEv,"axG",@progbits,_ZNSt14numeric_limitsIlE3maxEv,comdat
	.weak	_ZNSt14numeric_limitsIlE3maxEv  # -- Begin function _ZNSt14numeric_limitsIlE3maxEv
	.p2align	4, 0x90
	.type	_ZNSt14numeric_limitsIlE3maxEv,@function
_ZNSt14numeric_limitsIlE3maxEv:         # @_ZNSt14numeric_limitsIlE3maxEv
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movabsq	$9223372036854775807, %rax      # imm = 0x7FFFFFFFFFFFFFFF
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	_ZNSt14numeric_limitsIlE3maxEv, .Lfunc_end6-_ZNSt14numeric_limitsIlE3maxEv
	.cfi_endproc
                                        # -- End function
	.section	.text.startup,"ax",@progbits
	.p2align	4, 0x90                         # -- Begin function _GLOBAL__sub_I_antitest.cpp
	.type	_GLOBAL__sub_I_antitest.cpp,@function
_GLOBAL__sub_I_antitest.cpp:            # @_GLOBAL__sub_I_antitest.cpp
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	callq	__cxx_global_var_init
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	_GLOBAL__sub_I_antitest.cpp, .Lfunc_end7-_GLOBAL__sub_I_antitest.cpp
	.cfi_endproc
                                        # -- End function
	.type	_ZStL8__ioinit,@object          # @_ZStL8__ioinit
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.hidden	__dso_handle
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Enter the number of fibonacci numbers: "
	.size	.L.str, 40

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"Invalid input. Please enter a positive integer.\n"
	.size	.L.str.1, 49

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"Sorry, it exceeds the range of int.\n"
	.size	.L.str.2, 37

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"Fibonacci Series:\n"
	.size	.L.str.3, 19

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	" "
	.size	.L.str.4, 2

	.section	.init_array,"aw",@init_array
	.p2align	3
	.quad	_GLOBAL__sub_I_antitest.cpp
	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
