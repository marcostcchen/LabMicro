	.file	"crivo.c"
	.global	__floatsidf
	.global	__fixdfsi
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\000"
	.align	2
.LC1:
	.ascii	"%d \303\251 primo!n\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 4000016
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #3997696
	sub	sp, sp, #2320
	sub	r3, fp, #3997696
	sub	r3, r3, #20
	sub	r3, r3, #2304
	sub	r3, r3, #12
	ldr	r0, .L12
	mov	r1, r3
	bl	scanf
	mvn	r5, #3997696
	sub	r5, r5, #2304
	sub	r5, r5, #15
	mvn	r3, #3997696
	sub	r3, r3, #2304
	sub	r3, r3, #11
	sub	r1, fp, #20
	ldr	r0, [r1, r3]
	bl	__floatsidf
	mov	r4, r1
	mov	r3, r0
	mov	r1, r4
	mov	r0, r3
	bl	sqrt
	mov	r4, r1
	mov	r3, r0
	mov	r1, r4
	mov	r0, r3
	bl	__fixdfsi
	mov	r3, r0
	sub	r2, fp, #20
	str	r3, [r2, r5]
	mov	r3, #2
	str	r3, [fp, #-24]
.L2:
	mvn	r3, #3997696
	sub	r3, r3, #2304
	sub	r3, r3, #11
	ldr	r2, [fp, #-24]
	sub	r1, fp, #20
	ldr	r3, [r1, r3]
	cmp	r2, r3
	bgt	.L3
	mvn	r2, #3997696
	sub	r2, r2, #2304
	sub	r2, r2, #7
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #2
	sub	r1, fp, #20
	add	r3, r3, r1
	add	r2, r3, r2
	ldr	r3, [fp, #-24]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
	b	.L2
.L3:
	mov	r3, #2
	str	r3, [fp, #-24]
.L5:
	mvn	r3, #3997696
	sub	r3, r3, #2304
	sub	r3, r3, #15
	ldr	r2, [fp, #-24]
	sub	r1, fp, #20
	ldr	r3, [r1, r3]
	cmp	r2, r3
	bgt	.L6
	mvn	r2, #3997696
	sub	r2, r2, #2304
	sub	r2, r2, #7
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #2
	sub	r1, fp, #20
	add	r3, r3, r1
	add	r3, r3, r2
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bne	.L7
	ldr	r0, .L12+4
	ldr	r1, [fp, #-24]
	bl	printf
	ldr	r3, [fp, #-24]
	ldr	r2, [fp, #-24]
	add	r3, r3, r2
	str	r3, [fp, #-28]
.L9:
	mvn	r3, #3997696
	sub	r3, r3, #2304
	sub	r3, r3, #11
	ldr	r2, [fp, #-28]
	sub	r1, fp, #20
	ldr	r3, [r1, r3]
	cmp	r2, r3
	bgt	.L7
	mvn	r2, #3997696
	sub	r2, r2, #2304
	sub	r2, r2, #7
	ldr	r3, [fp, #-28]
	mov	r3, r3, asl #2
	sub	r1, fp, #20
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	str	r3, [fp, #-28]
	b	.L9
.L7:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
	b	.L5
.L6:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L13:
	.align	2
.L12:
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (GNU) 3.4.3"
