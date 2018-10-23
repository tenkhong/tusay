;
;  03/16/17 14:48
;
	org	0
;
X0000:	ljmp	X002e
;
	ljmp	X0cfc
;
	org	0bh
;
	ljmp	X0a00
;
	org	23h
;
	ljmp	X0cc0
;
	org	2bh
;
	ljmp	X0bc5
;
X002e:	mov	sp,#0b2h
	mov	r0,#0b2h
X0033:	mov	@r0,#0
	djnz	r0,X0033
	mov	dptr,#X0000
	mov	r6,dph
	mov	r7,dpl
	mov	dptr,#X0000
X0041:	lcall	X006c
	jz	X004b
	clr	a
	movx	@dptr,a
	inc	dptr
	sjmp	X0041
;
X004b:	mov	dptr,#X00ca
	lcall	X0075
	mov	dptr,#X00ce
	lcall	X0075
	mov	dptr,#X00d2
	lcall	X0093
	mov	dptr,#X00d8
	lcall	X0093
	mov	psw,#0
	lcall	X0525
	ljmp	X00de
;
X006c:	mov	a,r7
	xrl	a,dpl
	jnz	X0074
	mov	a,r6
	xrl	a,dph
X0074:	ret	
;
X0075:	clr	a
	movc	a,@a+dptr
	mov	r0,a
	mov	a,#1
	movc	a,@a+dptr
	mov	r1,a
	mov	a,#2
	movc	a,@a+dptr
	mov	r6,a
	mov	a,#3
	movc	a,@a+dptr
	mov	dpl,a
	mov	dph,r6
X0087:	mov	a,r0
	xrl	a,r1
	jnz	X008c
	ret	
;
X008c:	clr	a
	movc	a,@a+dptr
	mov	@r0,a
	inc	dptr
	inc	r0
	sjmp	X0087
;
X0093:	clr	a
	movc	a,@a+dptr
	mov	r4,a
	mov	a,#1
	movc	a,@a+dptr
	mov	r5,a
	mov	a,#2
	movc	a,@a+dptr
	mov	r6,a
	mov	a,#3
	movc	a,@a+dptr
	mov	r7,a
	mov	a,#4
	movc	a,@a+dptr
	mov	r0,a
	mov	a,#5
	movc	a,@a+dptr
	mov	dpl,a
	mov	dph,r0
X00ad:	lcall	X006c
	jnz	X00b3
	ret	
;
X00b3:	clr	a
	movc	a,@a+dptr
	inc	dptr
	mov	r0,dph
	mov	r1,dpl
	mov	dph,r4
	mov	dpl,r5
	movx	@dptr,a
	inc	dptr
	mov	r4,dph
	mov	r5,dpl
	mov	dph,r0
	mov	dpl,r1
	sjmp	X00ad
;
X00ca:	jnb	26h.0,X00d2
	add	a,0b3h
	cpl	c
	inc	25h
X00d2:	nop	
;
	org	0d4h
;
	inc	25h
	inc	25h
X00d8:	nop	
;
	org	0dah
;
	inc	25h
	inc	25h
X00de:	sjmp	X00de
;
X00e0:	mov	a,r3
	xch	a,r1
	mov	r3,a
	mov	a,r2
	xch	a,r0
	mov	r2,a
	mov	a,r1
	orl	a,r3
	jnz	X00fa
	mov	a,r0
	push	b
	mov	b,r2
	div	ab
	mov	r0,a
	mov	r2,b
	pop	b
	mov	r1,#0
	mov	r3,#0
	ret	
;
X00fa:	mov	a,r4
	push	acc
	mov	a,r5
	push	acc
	mov	a,r6
	push	acc
	mov	r5,#0
	mov	r6,#0
	mov	r4,#10h
X0109:	clr	c
	mov	a,r0
	rlc	a
	mov	r0,a
	mov	a,r1
	rlc	a
	mov	r1,a
	mov	a,r5
	rlc	a
	mov	r5,a
	mov	a,r6
	rlc	a
	mov	r6,a
	mov	a,r5
	subb	a,r2
	mov	a,r6
	subb	a,r3
	jc	X0121
	mov	r6,a
	mov	a,r5
	subb	a,r2
	mov	r5,a
	inc	r0
X0121:	djnz	r4,X0109
	mov	a,r5
	mov	r2,a
	mov	a,r6
	mov	r3,a
	pop	acc
	mov	r6,a
	pop	acc
	mov	r5,a
	pop	acc
	mov	r4,a
	mov	a,r0
	orl	a,r1
	ret	
;
	mov	a,r0
	mov	r4,a
	mov	a,r1
	mov	r5,a
	mov	a,r2
	mov	r6,a
	mov	a,r3
	mov	r7,a
	sjmp	X0145
;
	mov	a,r4
	mov	r0,a
	mov	a,r5
	mov	r1,a
	mov	a,r6
	mov	r2,a
	mov	a,r7
	mov	r3,a
X0145:	mov	a,r7
	orl	a,r6
	orl	a,r5
	orl	a,r3
	orl	a,r2
	orl	a,r1
	jnz	X015a
	mov	a,r0
	mov	b,r4
	mul	ab
	mov	r4,a
	mov	r5,b
	mov	r6,#0
	mov	r7,#0
	orl	a,r5
	ret	
;
X015a:	push	dpl
	mov	a,r4
	mov	dpl,a
	mov	b,r0
	mul	ab
	push	acc
	mov	a,r0
	xch	a,b
	xch	a,r5
	push	acc
	mul	ab
	add	a,r5
	mov	r5,a
	clr	a
	addc	a,b
	xch	a,r6
	mov	r4,a
	mov	b,dpl
	mov	a,r1
	mul	ab
	add	a,r5
	mov	r5,a
	mov	a,r6
	addc	a,b
	mov	r6,a
	clr	a
	rlc	a
	xch	a,r7
	mov	b,r0
	mul	ab
	add	a,r7
	mov	r7,a
	mov	a,r1
	mov	b,r4
	mul	ab
	add	a,r7
	mov	r7,a
	mov	a,r2
	pop	b
	push	b
	mul	ab
	add	a,r7
	mov	r7,a
	mov	a,r3
	mov	b,dpl
	mul	ab
	add	a,r7
	mov	r7,a
	pop	b
	mov	a,r1
	mul	ab
	add	a,r6
	mov	r6,a
	mov	a,r7
	addc	a,b
	mov	r7,a
	mov	a,r2
	mov	b,dpl
	mul	ab
	add	a,r6
	mov	r6,a
	mov	a,r7
	addc	a,b
	mov	r7,a
	mov	b,r4
	mov	a,r0
	mul	ab
	add	a,r6
	mov	r6,a
	mov	a,r7
	addc	a,b
	mov	r7,a
	pop	acc
	pop	dpl
	mov	r4,a
	orl	a,r6
	orl	a,r5
	orl	a,r7
	ret	
;
X01c2:	mov	a,r7
	xch	a,r3
	mov	r7,a
	mov	a,r6
	xch	a,r2
	mov	r6,a
	mov	a,r5
	xch	a,r1
	mov	r5,a
	mov	a,r4
	xch	a,r0
	mov	r4,a
	ret	
;
	lcall	X01c2
X01d2:	mov	a,r3
	orl	a,r2
	orl	a,r6
	orl	a,r7
	jnz	X01ef
	mov	a,r4
	mov	r2,a
	mov	a,r5
	mov	r3,a
	lcall	X00e0
	mov	b,a
	mov	a,r0
	mov	r4,a
	mov	a,r1
	mov	r5,a
	mov	a,r2
	mov	r0,a
	mov	a,r3
	mov	r1,a
	clr	a
	mov	r2,a
	mov	r3,a
	mov	a,b
	ret	
;
X01ef:	push	dpl
	push	dph
	mov	b,#20h
	mov	dpl,r3
	mov	dph,r0
	clr	a
	mov	r3,a
	xch	a,r7
	push	acc
	clr	a
	xch	a,r2
	xch	a,r6
	push	acc
	clr	a
	xch	a,r1
	xch	a,r5
	push	acc
X0209:	clr	c
	mov	a,r4
	rlc	a
	mov	r4,a
	mov	r0,sp
	mov	a,@r0
	rlc	a
	mov	@r0,a
	dec	r0
	mov	a,@r0
	rlc	a
	mov	@r0,a
	dec	r0
	mov	a,@r0
	rlc	a
	mov	@r0,a
	mov	a,r3
	rlc	a
	mov	r3,a
	mov	a,r1
	rlc	a
	mov	r1,a
	mov	a,r2
	rlc	a
	mov	r2,a
	mov	a,r7
	rlc	a
	mov	r7,a
	mov	a,r3
	subb	a,dph
	mov	a,r1
	subb	a,r5
	mov	a,r2
	subb	a,r6
	mov	a,r7
	subb	a,dpl
	jc	X023e
	mov	r7,a
	mov	a,r3
	subb	a,dph
	mov	r3,a
	mov	a,r1
	subb	a,r5
	mov	r1,a
	mov	a,r2
	subb	a,r6
	mov	r2,a
	inc	r4
X023e:	djnz	b,X0209
	pop	acc
	mov	r5,a
	pop	acc
	mov	r6,a
	mov	a,r3
	mov	r0,a
	pop	acc
	xch	a,r7
	mov	r3,a
	mov	a,r4
	pop	dph
	pop	dpl
X0252:	orl	a,r5
	orl	a,r6
	orl	a,r7
	ret	
;
	lcall	X01c2
X0259:	lcall	X01d2
X025c:	mov	a,r3
	mov	r7,a
	mov	a,r2
	mov	r6,a
	mov	a,r1
	mov	r5,a
	mov	a,r0
	mov	r4,a
	sjmp	X0252
;
	lcall	X01c2
X0269:	mov	a,r3
	rlc	a
	jnc	X027b
	clr	a
	clr	c
	subb	a,r0
	mov	r0,a
	clr	a
	subb	a,r1
	mov	r1,a
	clr	a
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
	setb	c
X027b:	mov	a,r7
	jnb	acc.7,X0287
	cpl	c
	push	psw
	lcall	X02a8
	sjmp	X0289
;
X0287:	push	psw
X0289:	lcall	X01d2
X028c:	pop	b
	jb	b.7,X0292
	ret	
;
X0292:	mov	b,a
	lcall	X02a8
	mov	a,b
	ret	
;
	lcall	X01c2
X029d:	mov	a,r7
	push	acc
	lcall	X0269
	lcall	X025c
	sjmp	X028c
;
X02a8:	clr	a
	clr	c
	subb	a,r4
	mov	r4,a
	clr	a
	subb	a,r5
	mov	r5,a
	clr	a
	subb	a,r6
	mov	r6,a
	clr	a
	subb	a,r7
	mov	r7,a
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X02b9:	mov	a,r4
	cpl	a
	mov	r4,a
	mov	a,r5
	cpl	a
	mov	r5,a
	mov	a,r6
	cpl	a
	mov	r6,a
	mov	a,r7
	cpl	a
	mov	r7,a
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X02c9:	mov	b,r0
	inc	b
	sjmp	X02dd
;
X02cf:	mov	a,r7
	mov	c,acc.7
	rrc	a
	mov	r7,a
	mov	a,r6
	rrc	a
	mov	r6,a
	mov	a,r5
	rrc	a
	mov	r5,a
	mov	a,r4
	rrc	a
	mov	r4,a
X02dd:	djnz	b,X02cf
	mov	a,r7
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X02e5:	mov	b,r0
	inc	b
	sjmp	X02f8
;
X02eb:	clr	c
	mov	a,r7
	rrc	a
	mov	r7,a
	mov	a,r6
	rrc	a
	mov	r6,a
	mov	a,r5
	rrc	a
	mov	r5,a
	mov	a,r4
	rrc	a
	mov	r4,a
X02f8:	djnz	b,X02eb
	mov	a,r7
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X0300:	mov	b,r0
	inc	b
	sjmp	X0313
;
X0306:	clr	c
	mov	a,r4
	rlc	a
	mov	r4,a
	mov	a,r5
	rlc	a
	mov	r5,a
	mov	a,r6
	rlc	a
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
X0313:	djnz	b,X0306
	mov	a,r7
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
	mov	a,r0
	mov	r4,a
	mov	a,r1
	mov	r5,a
	mov	a,r2
	mov	r6,a
	mov	a,r3
	mov	r7,a
	sjmp	X032d
;
	mov	a,r4
	mov	r0,a
	mov	a,r5
	mov	r1,a
	mov	a,r6
	mov	r2,a
	mov	a,r7
	mov	r3,a
X032d:	mov	a,r4
	add	a,r0
	mov	r4,a
	mov	a,r5
	addc	a,r1
	mov	r5,a
	mov	a,r6
	addc	a,r2
	mov	r6,a
	mov	a,r7
	addc	a,r3
	mov	r7,a
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X033d:	clr	c
	mov	a,r4
	subb	a,r0
	mov	r4,a
	mov	a,r5
	subb	a,r1
	mov	r5,a
	mov	a,r6
	subb	a,r2
	mov	r6,a
	mov	a,r7
	subb	a,r3
	mov	r7,a
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X034e:	mov	a,r4
	anl	a,r0
	mov	r4,a
	mov	a,r5
	anl	a,r1
	mov	r5,a
	mov	a,r6
	anl	a,r2
	mov	r6,a
	mov	a,r7
	anl	a,r3
	mov	r7,a
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X035e:	mov	a,r4
	orl	a,r0
	mov	r4,a
	mov	a,r5
	orl	a,r1
	mov	r5,a
	mov	a,r6
	orl	a,r2
	mov	r6,a
	mov	a,r7
	orl	a,r3
	mov	r7,a
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X036e:	mov	a,r4
	xrl	a,r0
	mov	r4,a
	mov	a,r5
	xrl	a,r1
	mov	r5,a
	mov	a,r6
	xrl	a,r2
	mov	r6,a
	mov	a,r7
	xrl	a,r3
	mov	r7,a
	orl	a,r6
	orl	a,r5
	orl	a,r4
	ret	
;
X037e:	mov	b,#21h
	sjmp	X03a4
;
X0383:	mov	b,#31h
	sjmp	X03a4
;
	mov	b,#41h
	sjmp	X03a4
;
	mov	b,#51h
	sjmp	X03a4
;
	mov	b,#61h
	sjmp	X03a4
;
	mov	b,#71h
	sjmp	X03a4
;
	mov	b,#81h
	sjmp	X03a4
;
	mov	b,#91h
X03a4:	mov	a,r3
	push	acc
	mov	a,r2
	push	acc
	mov	a,r1
	push	acc
	mov	a,r0
	push	acc
	mov	a,r5
	mov	r1,a
	mov	a,r6
	mov	r2,a
	mov	a,r7
	mov	r3,a
	mov	a,@r0
	mov	r7,a
	inc	r0
	mov	a,@r0
	mov	r6,a
	inc	r0
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	xch	a,r4
	xch	a,r0
	jnb	b.3,X03d5
	xch	a,r4
	push	acc
	xch	a,r4
	xch	a,r5
	push	acc
	xch	a,r5
	xch	a,r6
	push	acc
	xch	a,r6
	xch	a,r7
	push	acc
	xch	a,r7
X03d5:	push	acc
	ljmp	X03e5
;
X03da:	mov	a,r0
	dec	a
	jz	X03df
	inc	a
X03df:	mov	r1,a
	mov	r2,a
	mov	r3,a
	ljmp	X032d
;
X03e5:	push	b
	mov	a,b
	swap	a
	anl	a,#0fh
	mov	b,#5
	mul	ab
	mov	dptr,#X03f4
	jmp	@a+dptr
;
X03f4:	lcall	X032d
	sjmp	X0442
;
	lcall	X033d
	sjmp	X0442
;
	lcall	X0145
	sjmp	X0442
;
	lcall	X0269
	sjmp	X0442
;
	lcall	X01d2
	sjmp	X0442
;
	lcall	X029d
	sjmp	X0442
;
	lcall	X0259
	sjmp	X0442
;
	lcall	X02c9
	sjmp	X0442
;
	lcall	X02e5
	sjmp	X0442
;
	lcall	X0300
	sjmp	X0442
;
	lcall	X034e
	sjmp	X0442
;
	lcall	X035e
	sjmp	X0442
;
	lcall	X036e
	sjmp	X0442
;
	lcall	X03da
	sjmp	X0442
;
	lcall	X02a8
	sjmp	X0442
;
	lcall	X02b9
X0442:	pop	b
	mov	r3,a
	jnb	b.0,X0458
	pop	acc
	mov	r0,a
	mov	a,r4
	mov	@r0,a
	dec	r0
	mov	a,r5
	mov	@r0,a
	dec	r0
	mov	a,r6
	mov	@r0,a
	dec	r0
	mov	a,r7
	mov	@r0,a
	sjmp	X0486
;
X0458:	jnb	b.2,X0478
	pop	dph
	pop	dpl
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	mov	a,dpl
	add	a,#0fdh
	mov	dpl,a
	mov	a,dph
	addc	a,#0ffh
	mov	dph,a
	sjmp	X0486
;
X0478:	pop	acc
	mov	r0,a
	mov	a,r4
	movx	@r0,a
	dec	r0
	mov	a,r5
	movx	@r0,a
	dec	r0
	mov	a,r6
	movx	@r0,a
	dec	r0
	mov	a,r7
	movx	@r0,a
X0486:	jnb	b.3,X0495
	pop	acc
	mov	r7,a
	pop	acc
	mov	r6,a
	pop	acc
	mov	r5,a
	pop	acc
	mov	r4,a
X0495:	pop	acc
	mov	r0,a
	pop	acc
	mov	r1,a
	pop	acc
	mov	r2,a
	pop	acc
	xch	a,r3
	ret	
;
X04a2:	pop	dph
	pop	dpl
	mov	b,a
	clr	c
	clr	a
	movc	a,@a+dptr
	inc	dptr
	xch	a,b
	subb	a,b
	push	acc
	clr	c
	pop	b
	clr	a
	movc	a,@a+dptr
	inc	dptr
	subb	a,b
	jc	X04ce
	inc	dptr
	inc	dptr
	clr	c
	mov	a,b
	rlc	a
	jnc	X04c6
	inc	dph
X04c6:	add	a,dpl
	mov	dpl,a
	jnc	X04ce
	inc	dph
X04ce:	mov	a,#1
	movc	a,@a+dptr
	push	acc
	clr	a
	movc	a,@a+dptr
	push	acc
	ret	
;
X04d8:	pop	dph
	pop	dpl
	mov	b,a
X04de:	clr	a
	movc	a,@a+dptr
	jnz	X04eb
	mov	a,#1
	movc	a,@a+dptr
	jnz	X04eb
	inc	dptr
	inc	dptr
	sjmp	X04f7
;
X04eb:	mov	a,#2
	movc	a,@a+dptr
	xrl	a,b
	jz	X04f7
	inc	dptr
	inc	dptr
	inc	dptr
	sjmp	X04de
;
X04f7:	mov	a,#1
	movc	a,@a+dptr
	push	acc
	clr	a
	movc	a,@a+dptr
	push	acc
	ret	
;
X0501:	mov	a,r7
	mov	@r0,a
	inc	r0
	mov	a,r6
	mov	@r0,a
	inc	r0
	mov	a,r5
	mov	@r0,a
	inc	r0
	mov	a,r4
	mov	@r0,a
	ret	
;
X050d:	mov	a,@r0
	mov	r7,a
	inc	r0
	mov	a,@r0
	mov	r6,a
	inc	r0
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	mov	r4,a
	ret	
;
X0519:	mov	a,@r0
	mov	r3,a
	inc	r0
	mov	a,@r0
	mov	r2,a
	inc	r0
	mov	a,@r0
	mov	r1,a
	inc	r0
	mov	a,@r0
	mov	r0,a
	ret	
;
X0525:	mov	r0,#0a2h
	mov	@r0,#6
X0529:	mov	r0,#0a2h
	mov	a,@r0
	lcall	X04d8
	inc	67h
	ajmp	X0005
;
	orl	c,20h.2
	inc	7dh
	rr	a
	inc	tcon
	inc	a
	inc	48h
	inc	@r0
	inc	93h
	inc	@r1
	inc	5ch
	inc	r1
	nop	
;
	org	546h
;
	inc	48h
	lcall	X0d4a
	mov	r0,#0a3h
	mov	a,@r0
	jz	X0556
	mov	r0,#0a2h
	mov	@r0,#7
	sjmp	X055a
;
X0556:	mov	r0,#0a2h
	mov	@r0,#9
X055a:	sjmp	X05b1
;
	lcall	X08d8
	mov	r0,#0a2h
	mov	@r0,#1
	clr	p1.6
	sjmp	X05b1
;
	mov	r4,#1
	lcall	X05ba
	mov	r0,#0a2h
	mov	@r0,#2
	sjmp	X05b1
;
	mov	r4,#2
	lcall	X05ba
	mov	r0,#0a2h
	mov	@r0,#3
	sjmp	X05b1
;
	mov	r4,#3
	lcall	X05ba
	mov	r0,#0a2h
	mov	@r0,#4
	sjmp	X05b1
;
	mov	r4,#4
	lcall	X05ba
	mov	r0,#0a2h
	mov	@r0,#1
	sjmp	X05b1
;
	mov	r4,#1
	lcall	X1046
	mov	r0,#0a3h
	mov	a,@r0
	mov	r4,a
	lcall	X1072
	mov	r0,#0a3h
	mov	a,@r0
	cjne	a,#7,X05ab
	mov	r0,#0a2h
	mov	@r0,#9
	sjmp	X05af
;
X05ab:	mov	r0,#0a2h
	mov	@r0,#6
X05af:	sjmp	X05b1
;
X05b1:	jnb	20h.2,X05b7
	lcall	X09b2
X05b7:	ljmp	X0529
;
X05ba:	mov	r0,#3ah
	mov	a,r4
	mov	@r0,a
	mov	a,r4
	add	a,#63h
	mov	r0,a
	mov	a,@r0
	lcall	X04a2
	ajmp	X0005
;
	inc	0d6h
	inc	s1sta
	inc	@r0
	inc	r2
	inc	@r0
	orl	a,#7
	addc	a,@r0
	inc	@r1
	mov	rb0r7,r7
	setb	c
	ljmp	X07fb
;
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#0
	lcall	X080c
	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#77h
	mov	r0,a
	mov	@r0,#0
	inc	r0
	mov	@r0,#0
	mov	r0,#3ah
	mov	a,@r0
	add	a,#8bh
	mov	r0,a
	mov	@r0,#0
	mov	r0,#3ah
	mov	a,@r0
	add	a,#90h
	mov	r0,a
	mov	@r0,#0
	mov	r0,#3ah
	mov	a,@r0
	add	a,#95h
	mov	r0,a
	mov	@r0,#0
	ljmp	X07fb
;
	mov	r0,#5ch
	mov	a,@r0
	add	a,#0f1h
	mov	r4,a
	dec	r0
	mov	a,@r0
	addc	a,#0ffh
	mov	r5,a
	mov	a,r4
	mov	b,#0ah
	mul	ab
	mov	r4,a
	mov	a,b
	xch	a,r5
	mov	b,#0ah
	mul	ab
	add	a,r5
	mov	r5,a
	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	a,r5
	mov	@r0,a
	inc	r0
	mov	a,r4
	mov	@r0,a
	mov	r0,#3ah
	mov	a,@r0
	add	a,#86h
	mov	r0,a
	mov	@r0,#96h
	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#3
	ljmp	X07fb
;
	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	orl	a,r5
	jnz	X0656
	ljmp	X071e
;
X0656:	mov	r0,#3ah
	mov	a,@r0
	add	a,#86h
	mov	r0,a
	mov	a,@r0
	jnz	X0662
	ljmp	X0714
;
X0662:	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	mov	r4,a
	mov	r0,#5dh
	mov	a,@r0
	mov	r7,a
	inc	r0
	mov	a,@r0
	mov	r6,a
	mov	b,#0ah
	mul	ab
	mov	r6,a
	mov	a,b
	xch	a,r7
	mov	b,#0ah
	mul	ab
	add	a,r7
	mov	r7,a
	mov	a,r4
	clr	c
	subb	a,r6
	mov	a,r5
	subb	a,r7
	jnc	X06b3
	mov	r0,#3ah
	mov	a,@r0
	add	a,#81h
	mov	r0,a
	mov	@r0,#1
	mov	r0,#3ah
	mov	a,@r0
	add	a,#8bh
	mov	r0,a
	mov	@r0,#1
	mov	r0,#3ah
	mov	a,@r0
	add	a,#90h
	mov	r0,a
	mov	a,@r0
	jnz	X06b1
	mov	r0,#3ah
	mov	a,@r0
	add	a,#90h
	mov	r0,a
	mov	@r0,#1
	mov	r4,#1
	lcall	X1046
X06b1:	sjmp	X0712
;
X06b3:	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	mov	r4,a
	mov	r0,#5dh
	mov	a,@r0
	mov	r7,a
	inc	r0
	mov	a,@r0
	add	a,acc
	xch	a,r7
	rlc	a
	xch	a,r7
	mov	r6,a
	mov	b,#0ah
	mul	ab
	mov	r6,a
	mov	a,b
	xch	a,r7
	mov	b,#0ah
	mul	ab
	add	a,r7
	mov	r7,a
	mov	a,r4
	clr	c
	subb	a,r6
	mov	a,r5
	subb	a,r7
	jnc	X0709
	mov	r0,#3ah
	mov	a,@r0
	add	a,#81h
	mov	r0,a
	mov	@r0,#0
	mov	r0,#3ah
	mov	a,@r0
	add	a,#8bh
	mov	r0,a
	mov	@r0,#1
	mov	r0,#3ah
	mov	a,@r0
	add	a,#95h
	mov	r0,a
	mov	a,@r0
	jnz	X0707
	mov	r0,#3ah
	mov	a,@r0
	add	a,#95h
	mov	r0,a
	mov	@r0,#1
	mov	r4,#2
	lcall	X1046
X0707:	sjmp	X0712
;
X0709:	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#1
	lcall	X080c
X0712:	sjmp	X071c
;
X0714:	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#1
X071c:	sjmp	X0733
;
X071e:	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	@r0,#0
	inc	r0
	mov	@r0,#96h
	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#4
X0733:	ljmp	X07fb
;
	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	orl	a,r5
	jz	X0778
	mov	r0,#3ah
	mov	a,@r0
	add	a,#86h
	mov	r0,a
	mov	a,@r0
	jz	X076e
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#3
	lcall	X080c
	mov	r0,#3ah
	mov	a,@r0
	add	a,#8bh
	mov	r0,a
	mov	@r0,#0
	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#77h
	mov	r0,a
	mov	@r0,#0
	inc	r0
	mov	@r0,#1
	sjmp	X0776
;
X076e:	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#1
X0776:	sjmp	X078d
;
X0778:	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	@r0,#0
	inc	r0
	mov	@r0,#96h
	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#5
X078d:	sjmp	X07fb
;
	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	orl	a,r5
	jz	X07c9
	mov	r0,#3ah
	mov	a,@r0
	add	a,#86h
	mov	r0,a
	mov	a,@r0
	jz	X07bf
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#3
	lcall	X080c
	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#77h
	mov	r0,a
	mov	@r0,#0
	inc	r0
	mov	@r0,#1
	sjmp	X07c7
;
X07bf:	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#1
X07c7:	sjmp	X07d1
;
X07c9:	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#6
X07d1:	sjmp	X07fb
;
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#2
	lcall	X080c
	mov	r0,#3ah
	mov	a,@r0
	add	a,acc
	add	a,#77h
	mov	r0,a
	mov	@r0,#0
	inc	r0
	mov	@r0,#0
	mov	r0,#3ah
	mov	a,@r0
	add	a,#90h
	mov	r0,a
	mov	@r0,#0
	mov	r0,#3ah
	mov	a,@r0
	add	a,#95h
	mov	r0,a
	mov	@r0,#0
	sjmp	X07fb
;
X07fb:	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	a,@r0
	mov	r4,a
	mov	r0,#3ah
	mov	a,@r0
	add	a,#68h
	mov	r0,a
	mov	a,r4
	mov	@r0,a
	ret	
;
X080c:	mov	r0,#5fh
	mov	a,@r0
	mov	r0,#36h
	mov	@r0,a
	mov	r0,#39h
	mov	a,r5
	mov	@r0,a
	mov	a,r5
	anl	a,#3
	mov	r0,#37h
	mov	@r0,a
	mov	r0,#38h
	mov	a,r4
	mov	@r0,a
	mov	a,r4
	cjne	a,#1,X0839
	sjmp	X0828
;
X0826:	sjmp	X0887
;
X0828:	mov	r0,#36h
	xch	a,@r0
	anl	a,#0fch
	mov	@r0,a
	mov	r0,#36h
	mov	a,@r0
	mov	r1,#37h
	orl	a,@r1
	mov	r1,#36h
	mov	@r1,a
	sjmp	X0887
;
X0839:	cjne	a,#2,X0853
	mov	r0,#36h
	mov	a,@r0
	mov	r7,a
	mov	a,r7
	anl	a,#0f3h
	mov	r4,a
	mov	r0,#37h
	mov	a,@r0
	add	a,acc
	add	a,acc
	orl	a,r4
	mov	r4,a
	mov	r0,#36h
	mov	a,r4
	mov	@r0,a
	sjmp	X0887
;
X0853:	cjne	a,#3,X086e
	mov	r0,#36h
	mov	a,@r0
	mov	r7,a
	mov	a,r7
	anl	a,#3fh
	mov	r4,a
	mov	r0,#37h
	mov	a,@r0
	swap	a
	rl	a
	rl	a
	anl	a,#0c0h
	orl	a,r4
	mov	r4,a
	mov	r0,#36h
	mov	a,r4
	mov	@r0,a
	sjmp	X0887
;
X086e:	cjne	a,#4,X0826
	mov	r0,#36h
	mov	a,@r0
	mov	r7,a
	mov	a,r7
	anl	a,#0cfh
	mov	r4,a
	mov	r0,#37h
	mov	a,@r0
	swap	a
	anl	a,#0f0h
	orl	a,r4
	mov	r4,a
	mov	r0,#36h
	mov	a,r4
	mov	@r0,a
	sjmp	X0887
;
X0887:	mov	r0,#36h
	mov	a,@r0
	mov	r0,#5fh
	mov	@r0,a
	ret	
;
X088e:	mov	r0,#33h
	mov	a,r4
	mov	@r0,a
	mov	a,r4
	cjne	a,#1,X08a9
	sjmp	X089e
;
X0898:	mov	r0,#32h
	mov	@r0,#0
	sjmp	X08d3
;
X089e:	mov	c,t1
	cpl	c
	clr	a
	mov	acc.0,c
	mov	r0,#32h
	mov	@r0,a
	sjmp	X08d3
;
X08a9:	cjne	a,#2,X08b7
	mov	c,p1.0
	cpl	c
	clr	a
	mov	acc.0,c
	mov	r0,#32h
	mov	@r0,a
	sjmp	X08d3
;
X08b7:	cjne	a,#3,X08c5
	mov	c,p1.1
	cpl	c
	clr	a
	mov	acc.0,c
	mov	r0,#32h
	mov	@r0,a
	sjmp	X08d3
;
X08c5:	cjne	a,#4,X0898
	mov	c,p1.3
	cpl	c
	clr	a
	mov	acc.0,c
	mov	r0,#32h
	mov	@r0,a
	sjmp	X08d3
;
X08d3:	mov	r0,#32h
	mov	a,@r0
	mov	r4,a
	ret	
;
X08d8:	mov	r0,#3ah
	mov	@r0,#1
X08dc:	mov	r0,#3ah
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X08f2
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#0
	lcall	X080c
	mov	r0,#3ah
	inc	@r0
	sjmp	X08dc
;
X08f2:	mov	r4,#1
	lcall	X0d01
	mov	r0,#3ah
	mov	@r0,#1
X08fb:	mov	r0,#3ah
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X0914
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#1
	lcall	X080c
	lcall	X09a2
	mov	r0,#3ah
	inc	@r0
	sjmp	X08fb
;
X0914:	mov	r0,#3ah
	mov	@r0,#1
X0918:	mov	r0,#3ah
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X0931
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#3
	lcall	X080c
	lcall	X09a2
	mov	r0,#3ah
	inc	@r0
	sjmp	X0918
;
X0931:	mov	r0,#3ah
	mov	@r0,#1
X0935:	mov	r0,#3ah
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X094e
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#2
	lcall	X080c
	lcall	X09a2
	mov	r0,#3ah
	inc	@r0
	sjmp	X0935
;
X094e:	mov	r0,#3ah
	mov	@r0,#1
X0952:	mov	r0,#3ah
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X0968
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#0
	lcall	X080c
	mov	r0,#3ah
	inc	@r0
	sjmp	X0952
;
X0968:	mov	r4,#2
	lcall	X1046
	mov	r0,#3ah
	mov	@r0,#1
X0971:	mov	r0,#3ah
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X09a1
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	lcall	X088e
	cjne	r4,#0,X099c
	mov	r0,#3ah
	mov	a,@r0
	add	a,#86h
	mov	r0,a
	mov	@r0,#0
	mov	r0,#3ah
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#1
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#0
	lcall	X080c
X099c:	mov	r0,#3ah
	inc	@r0
	sjmp	X0971
;
X09a1:	ret	
;
X09a2:	mov	r4,#0fah
	lcall	X0d19
	mov	r4,#0fah
	lcall	X0d19
	mov	r4,#0fah
	lcall	X0d19
	ret	
;
X09b2:	setb	p1.6
	setb	21h.1
X09b6:	mov	r0,#3ah
	mov	@r0,#1
X09ba:	mov	r0,#3ah
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X09d0
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#0
	lcall	X080c
	mov	r0,#3ah
	inc	@r0
	sjmp	X09ba
;
X09d0:	mov	r4,#0fah
	lcall	X0d19
	mov	r4,#0fah
	lcall	X0d19
	mov	r0,#3ah
	mov	@r0,#1
X09de:	mov	r0,#3ah
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X09f4
	mov	r0,#3ah
	mov	a,@r0
	mov	r4,a
	mov	r5,#2
	lcall	X080c
	mov	r0,#3ah
	inc	@r0
	sjmp	X09de
;
X09f4:	mov	r4,#0fah
	lcall	X0d19
	mov	r4,#0fah
	lcall	X0d19
	sjmp	X09b6
;
X0a00:	push	acc
	push	b
	push	dpl
	push	dph
	push	psw
	mov	a,r0
	push	acc
	mov	a,r1
	push	acc
	mov	a,r2
	push	acc
	mov	a,r3
	push	acc
	mov	a,r4
	push	acc
	mov	a,r5
	push	acc
	mov	a,r6
	push	acc
	mov	a,r7
	push	acc
	mov	r0,#9ah
	mov	a,@r0
	dec	a
	xch	a,@r0
	jz	X0a4c
	pop	acc
	mov	r7,a
	pop	acc
	mov	r6,a
	pop	acc
	mov	r5,a
	pop	acc
	mov	r4,a
	pop	acc
	mov	r3,a
	pop	acc
	mov	r2,a
	pop	acc
	mov	r1,a
	pop	acc
	mov	r0,a
	pop	psw
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti	
;
X0a4c:	mov	r0,#9ah
	mov	@r0,#2
	mov	r0,#9fh
	inc	@r0
	mov	r0,#0a0h
	dec	@r0
	cjne	@r0,#0,X0a5b
	sjmp	X0a5e
;
X0a5b:	ljmp	X0b25
;
X0a5e:	mov	r0,#0a0h
	mov	@r0,#0ah
	mov	r0,#9ch
	inc	@r0
	mov	a,@r0
	dec	r0
	jnz	X0a6a
	inc	@r0
X0a6a:	mov	r0,#5fh
	mov	a,@r0
	mov	r0,#60h
	orl	a,@r0
	mov	dptr,#X0000
	movx	@dptr,a
	jb	21h.1,X0a9f
	mov	r0,#62h
	mov	a,@r0
	jz	X0a9b
	jb	20h.3,X0a9f
	mov	r0,#79h
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jnz	X0a9f
	mov	r0,#7bh
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jnz	X0a9f
	mov	r0,#7dh
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jnz	X0a9f
	mov	r0,#7fh
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jnz	X0a9f
X0a9b:	mov	a,#0
	sjmp	X0aa1
;
X0a9f:	mov	a,#1
X0aa1:	mov	c,acc.0
	mov	t0,c
	jb	20h.6,X0ace
	mov	r0,#79h
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jnz	X0ac8
	mov	r0,#7bh
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jnz	X0ac8
	mov	r0,#7dh
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jnz	X0ac8
	mov	r0,#7fh
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jnz	X0ac8
	mov	a,#0
	sjmp	X0aca
;
X0ac8:	mov	a,#1
X0aca:	mov	c,acc.0
	mov	p2.0,c
X0ace:	mov	a,p1
	mov	r5,#0
	mov	r4,a
	mov	a,r4
	cpl	a
	mov	r4,a
	mov	a,r5
	cpl	a
	mov	r5,a
	mov	a,r4
	mov	r4,#4
X0adc:	xch	a,r5
	mov	c,acc.7
	rrc	a
	xch	a,r5
	rrc	a
	djnz	r4,X0adc
	anl	a,#7
	mov	r0,#0a3h
	mov	@r0,a
	mov	r0,#0a5h
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	mov	r4,a
	mov	r0,#0a6h
	mov	a,@r0
	dec	@r0
	dec	r0
	jnz	X0af8
	dec	@r0
X0af8:	mov	a,r4
	orl	a,r5
	jnz	X0afe
	setb	20h.4
X0afe:	jb	int1,X0b05
	setb	20h.2
	setb	p1.6
X0b05:	jnb	21h.0,X0b14
	jnb	20h.7,X0b14
	clr	20h.7
	clr	21h.0
	mov	r0,#0aah
	mov	a,@r0
	mov	sbuf,a
X0b14:	mov	r0,#9dh
	dec	@r0
	cjne	@r0,#0,X0b1e
	mov	r0,#9dh
	mov	@r0,#64h
X0b1e:	mov	r0,#9dh
	mov	a,@r0
	mov	r4,a
	lcall	X0b48
X0b25:	pop	acc
	mov	r7,a
	pop	acc
	mov	r6,a
	pop	acc
	mov	r5,a
	pop	acc
	mov	r4,a
	pop	acc
	mov	r3,a
	pop	acc
	mov	r2,a
	pop	acc
	mov	r1,a
	pop	acc
	mov	r0,a
	pop	psw
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti	
;
X0b48:	mov	r0,#5fh
	mov	a,@r0
	mov	r0,#60h
	mov	@r0,a
	mov	r0,#30h
	mov	@r0,#1
	mov	r0,#31h
	mov	a,r4
	mov	@r0,a
X0b56:	mov	r0,#30h
	mov	a,@r0
	clr	c
	subb	a,#5
	jc	X0b61
	ljmp	X0bc4
;
X0b61:	mov	r0,#30h
	mov	a,@r0
	add	a,#8bh
	mov	r0,a
	mov	a,@r0
	jz	X0bbf
	mov	r0,#30h
	mov	a,@r0
	add	a,#81h
	mov	r0,a
	mov	a,@r0
	jnz	X0b7b
	mov	r0,#31h
	mov	a,@r0
	clr	c
	subb	a,#14h
	jc	X0b8c
X0b7b:	mov	r0,#30h
	mov	a,@r0
	add	a,#81h
	mov	r0,a
	mov	a,@r0
	jz	X0bbf
	mov	r0,#31h
	mov	a,@r0
	clr	c
	subb	a,#50h
	jnc	X0bbf
X0b8c:	mov	r0,#30h
	mov	a,@r0
	cjne	a,#1,X0b9e
	sjmp	X0b96
;
X0b94:	sjmp	X0bbf
;
X0b96:	mov	r0,#60h
	xch	a,@r0
	orl	a,#3
	mov	@r0,a
	sjmp	X0bbf
;
X0b9e:	cjne	a,#2,X0ba9
	mov	r0,#60h
	xch	a,@r0
	orl	a,#0ch
	mov	@r0,a
	sjmp	X0bbf
;
X0ba9:	cjne	a,#3,X0bb4
	mov	r0,#60h
	xch	a,@r0
	orl	a,#0c0h
	mov	@r0,a
	sjmp	X0bbf
;
X0bb4:	cjne	a,#4,X0b94
	mov	r0,#60h
	xch	a,@r0
	orl	a,#30h
	mov	@r0,a
	sjmp	X0bbf
;
X0bbf:	mov	r0,#30h
	inc	@r0
	sjmp	X0b56
;
X0bc4:	ret	
;
X0bc5:	push	acc
	push	b
	push	dpl
	push	dph
	push	psw
	mov	a,r0
	push	acc
	mov	a,r1
	push	acc
	mov	a,r2
	push	acc
	mov	a,r3
	push	acc
	mov	a,r4
	push	acc
	mov	a,r5
	push	acc
	mov	a,r6
	push	acc
	mov	a,r7
	push	acc
	clr	tf2
	mov	r0,#0a1h
	dec	@r0
	cjne	@r0,#0,X0c00
	mov	r0,#9eh
	inc	@r0
	mov	r0,#0a1h
	mov	@r0,#0ah
	cpl	p1.2
	clr	a
	mov	c,p1.7
	mov	acc.0,c
	mov	r0,#62h
	mov	@r0,a
X0c00:	jnb	20h.2,X0c06
	ljmp	X0c9d
;
X0c06:	mov	r0,#34h
	mov	@r0,#1
X0c0a:	mov	r0,#34h
	mov	a,@r0
	clr	c
	subb	a,#5
	jc	X0c15
	ljmp	X0c9d
;
X0c15:	mov	r0,#34h
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	orl	a,r5
	jz	X0c36
	mov	r0,#34h
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r4,a
	xch	a,r4
	xch	a,r0
	xch	a,r4
	inc	r0
	mov	a,@r0
	dec	@r0
	dec	r0
	jnz	X0c36
	dec	@r0
X0c36:	mov	r0,#34h
	mov	a,@r0
	mov	r4,a
	lcall	X088e
	mov	a,r4
	jz	X0c5c
	mov	r0,#34h
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	a,@r0
	dec	a
	jnz	X0c52
	mov	r0,#34h
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#2
X0c52:	mov	r0,#34h
	mov	a,@r0
	add	a,#86h
	mov	r0,a
	mov	@r0,#96h
	sjmp	X0c97
;
X0c5c:	mov	r0,#34h
	mov	a,@r0
	add	a,#86h
	mov	r0,a
	mov	a,@r0
	jz	X0c8f
	mov	r0,#34h
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	a,@r0
	xrl	a,#6
	jz	X0c8f
	mov	r0,#34h
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	a,@r0
	xrl	a,#4
	jz	X0c8f
	mov	r0,#34h
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	a,@r0
	xrl	a,#5
	jz	X0c8f
	mov	r0,#34h
	mov	a,@r0
	add	a,#86h
	mov	r0,a
	dec	@r0
	sjmp	X0c97
;
X0c8f:	mov	r0,#34h
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#1
X0c97:	mov	r0,#34h
	inc	@r0
	ljmp	X0c0a
;
X0c9d:	pop	acc
	mov	r7,a
	pop	acc
	mov	r6,a
	pop	acc
	mov	r5,a
	pop	acc
	mov	r4,a
	pop	acc
	mov	r3,a
	pop	acc
	mov	r2,a
	pop	acc
	mov	r1,a
	pop	acc
	mov	r0,a
	pop	psw
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti	
;
X0cc0:	push	acc
	push	psw
	mov	a,r0
	push	acc
	mov	a,r4
	push	acc
	jnb	ti,X0cd1
	clr	ti
	setb	20h.7
X0cd1:	jnb	ri,X0cf1
	clr	ri
	mov	r0,#61h
	mov	@r0,sbuf
	mov	r0,#61h
	mov	a,@r0
	mov	r0,#0a8h
	mov	r4,a
	mov	a,@r0
	inc	@r0
	add	a,#0abh
	mov	r0,a
	mov	a,r4
	mov	@r0,a
	mov	r0,#0a8h
	mov	a,@r0
	cjne	a,#8,X0cf1
	mov	r0,#0a8h
	mov	@r0,#0
X0cf1:	pop	acc
	mov	r4,a
	pop	acc
	mov	r0,a
	pop	psw
	pop	acc
	reti	
;
X0cfc:	clr	ea
X0cfe:	sjmp	X0cfe
;
	reti	
;
X0d01:	clr	ea
	mov	r0,#9eh
	mov	@r0,#0
	setb	ea
	mov	r0,#36h
	mov	a,r4
	mov	@r0,a
X0d0d:	mov	r0,#9eh
	mov	a,@r0
	setb	c
	mov	r0,#36h
	subb	a,@r0
	jnc	X0d18
	sjmp	X0d0d
;
X0d18:	ret	
;
X0d19:	clr	ea
	mov	r0,#9fh
	mov	@r0,#0
	setb	ea
	mov	r0,#36h
	mov	a,r4
	mov	@r0,a
X0d25:	mov	r0,#9fh
	mov	a,@r0
	clr	c
	mov	r0,#36h
	subb	a,@r0
	jnc	X0d30
	sjmp	X0d25
;
X0d30:	ret	
;
X0d31:	clr	ea
	mov	r0,#3ch
	mov	a,r4
	mov	@r0,a
	mov	a,r4
	mov	b,#64h
	mul	ab
	mov	r5,b
	mov	r0,#0a5h
	xch	a,r5
	mov	@r0,a
	xch	a,r5
	inc	r0
	mov	@r0,a
	clr	20h.4
	setb	ea
	ret	
;
X0d4a:	clr	ea
	setb	p1.6
	clr	p2.0
	mov	r0,#0a4h
	mov	@r0,#32h
	setb	20h.1
	clr	t0
	clr	20h.3
	clr	21h.1
	mov	r0,#62h
	mov	@r0,#1
	mov	r0,#0a0h
	mov	@r0,#0ah
	mov	r0,#0a1h
	mov	@r0,#0ah
	mov	r0,#37h
	mov	@r0,#1
X0d6c:	mov	r0,#37h
	mov	a,@r0
	clr	c
	subb	a,#5
	jnc	X0dbb
	mov	r0,#37h
	mov	a,@r0
	add	a,#63h
	mov	r0,a
	mov	@r0,#2
	mov	r0,#37h
	mov	a,@r0
	add	a,acc
	add	a,#6dh
	mov	r0,a
	mov	@r0,#0
	inc	r0
	mov	@r0,#0
	mov	r0,#37h
	mov	a,@r0
	add	a,acc
	add	a,#77h
	mov	r0,a
	mov	@r0,#0
	inc	r0
	mov	@r0,#0
	mov	r0,#37h
	mov	a,@r0
	add	a,#8bh
	mov	r0,a
	mov	@r0,#0
	mov	r0,#37h
	mov	a,@r0
	add	a,#90h
	mov	r0,a
	mov	@r0,#0
	mov	r0,#37h
	mov	a,@r0
	add	a,#95h
	mov	r0,a
	mov	@r0,#0
	mov	r0,#37h
	mov	a,@r0
	add	a,#81h
	mov	r0,a
	mov	@r0,#0
	mov	r0,#37h
	inc	@r0
	sjmp	X0d6c
;
X0dbb:	mov	r0,#5fh
	mov	@r0,#0
	mov	r0,#60h
	mov	@r0,#0ffh
	mov	r0,#5fh
	mov	a,@r0
	mov	dptr,#X0000
	movx	@dptr,a
	clr	20h.2
	clr	20h.5
	clr	21h.0
	setb	20h.7
	clr	20h.6
	clr	20h.4
	mov	r0,#5bh
	mov	a,#7
	mov	@r0,a
	inc	r0
	inc	a
	mov	@r0,a
	mov	r0,#5dh
	clr	a
	mov	@r0,a
	inc	r0
	mov	@r0,#3ch
	mov	th1,#0f8h
	mov	th0,#9ah
	mov	rcap2h,#88h
	mov	rcap2l,#0
	mov	scon,#52h
	mov	tmod,#22h
	mov	tcon,#50h
	mov	t2con,#4
	mov	ip,#12h
	mov	ie,#0b2h
	mov	r4,#0
	lcall	X0e12
	setb	ea
	mov	r4,#0fah
	lcall	X0d19
	clr	20h.1
	ret	
;
X0e12:	clr	ea
	mov	r0,#0a8h
	mov	@r0,#0
	mov	r0,#0a7h
	mov	@r0,#0
	mov	r0,#0a9h
	mov	@r0,#0
	setb	ea
	mov	r0,#36h
	mov	a,r4
	mov	@r0,a
	ret	
;
X0e27:	mov	r0,#3eh
	mov	a,r5
	mov	@r0,a
	mov	r0,#3dh
	mov	a,r4
	mov	@r0,a
	mov	r4,#0ah
	lcall	X0d31
X0e34:	jnb	21h.0,X0e3d
	jnb	20h.4,X0e3b
	ret	
;
X0e3b:	sjmp	X0e34
;
X0e3d:	clr	ea
	mov	r0,#3dh
	mov	a,@r0
	mov	r0,#0aah
	mov	@r0,a
	setb	21h.0
	setb	ea
	ret	
;
	mov	r0,#35h
	mov	@r0,#0
	mov	r0,#0a8h
	mov	a,@r0
	jz	X0e6f
	clr	ea
	mov	r0,#0a7h
	mov	a,@r0
	inc	@r0
	add	a,#0abh
	mov	r0,a
	mov	a,@r0
	mov	r0,#35h
	mov	@r0,a
	mov	r0,#0a7h
	mov	a,@r0
	cjne	a,#8,X0e6a
	mov	r0,#0a7h
	mov	@r0,#0
X0e6a:	mov	r0,#0a8h
	dec	@r0
	setb	ea
X0e6f:	mov	r0,#35h
	mov	a,@r0
	mov	r4,a
	ret	
;
	mov	r0,#41h
	mov	a,r4
	mov	@r0,a
	mov	r0,#41h
	mov	a,@r0
	mov	r0,#40h
	mov	@r0,a
	clr	20h.0
	mov	a,r4
	mov	b,#64h
	div	ab
	mov	r0,#42h
	xch	a,r5
	mov	@r0,a
	xch	a,r5
	mov	r0,#3fh
	mov	@r0,a
	jz	X0eab
	mov	r0,#42h
	mov	a,@r0
	mov	r5,a
	mov	r0,#3fh
	mov	a,@r0
	add	a,#30h
	mov	r4,a
	lcall	X0e27
	mov	r0,#3fh
	mov	a,@r0
	mov	b,#64h
	mul	ab
	cpl	a
	inc	a
	mov	r0,#40h
	add	a,@r0
	mov	@r0,a
	setb	20h.0
X0eab:	mov	r0,#40h
	mov	a,@r0
	mov	b,#0ah
	div	ab
	jnz	X0eb7
	jnb	20h.0,X0ec8
X0eb7:	mov	r0,#42h
	mov	a,@r0
	mov	r5,a
	mov	r0,#40h
	mov	a,@r0
	mov	b,#0ah
	div	ab
	add	a,#30h
	mov	r4,a
	lcall	X0e27
X0ec8:	mov	r0,#42h
	mov	a,@r0
	mov	r5,a
	mov	r0,#40h
	mov	a,@r0
	mov	b,#0ah
	div	ab
	mov	a,b
	add	a,#30h
	mov	r4,a
	lcall	X0e27
	ret	
;
	mov	r0,#5ah
	mov	a,r6
	mov	@r0,a
	mov	r0,#58h
	mov	a,r5
	mov	@r0,a
	inc	r0
	mov	a,r4
	mov	@r0,a
	mov	r0,#57h
	mov	a,r6
	mov	@r0,a
	mov	r0,#56h
	mov	@r0,#1
	mov	r0,#55h
	mov	@r0,#5
	mov	r6,#0
	mov	r7,#0
	lcall	X0efb
	ret	
;
X0efb:	mov	r0,#4ch
	clr	a
	mov	@r0,a
	inc	r0
	mov	@r0,a
	inc	r0
	mov	@r0,a
	inc	r0
	inc	a
	mov	@r0,a
	mov	r0,#50h
	mov	@r0,#1
	mov	r0,#55h
	mov	a,@r0
	mov	r0,#4bh
	mov	@r0,a
	mov	r0,#4ah
	mov	@r0,#1
	mov	r0,#51h
	lcall	X0501
X0f19:	mov	r0,#4ah
	mov	a,@r0
	clr	c
	mov	r0,#55h
	subb	a,@r0
	jnc	X0f34
	mov	r0,#4ch
	mov	r4,#0ah
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0
	lcall	X037e
	mov	r0,#4ah
	inc	@r0
	sjmp	X0f19
;
X0f34:	mov	r0,#4ah
	mov	@r0,#0
X0f38:	mov	r0,#4ah
	mov	a,@r0
	clr	c
	mov	r0,#4bh
	subb	a,@r0
	jc	X0f44
	ljmp	X0fce
;
X0f44:	mov	r0,#51h
	lcall	X050d
	mov	r0,#4ch
	lcall	X0519
	lcall	X0269
	clr	a
	mov	r1,a
	mov	r2,a
	mov	r3,a
	mov	r0,#0ah
	lcall	X029d
	mov	a,r4
	add	a,#30h
	mov	r0,#49h
	mov	@r0,a
	mov	r0,#50h
	mov	a,@r0
	jz	X0fac
	mov	r0,#49h
	mov	a,@r0
	cjne	a,#30h,X0fac
	mov	r0,#4bh
	mov	a,@r0
	mov	r5,#0
	add	a,#0ffh
	mov	r4,a
	mov	a,r5
	addc	a,#0ffh
	mov	r5,a
	mov	r0,#4ah
	mov	a,@r0
	mov	r7,#0
	mov	r6,a
	mov	a,r4
	xrl	a,r6
	jnz	X0f85
	mov	a,r5
	xrl	a,r7
	jz	X0fac
X0f85:	mov	r0,#56h
	mov	a,@r0
	jnz	X0f97
	sjmp	X0f8c
;
X0f8c:	mov	r0,#57h
	mov	a,@r0
	mov	r5,a
	mov	r4,#30h
	lcall	X0e27
	sjmp	X0faa
;
X0f97:	cjne	a,#2,X0f9c
	sjmp	X0faa
;
X0f9c:	cjne	a,#1,X0f8c
	mov	r0,#57h
	mov	a,@r0
	mov	r5,a
	mov	r4,#20h
	lcall	X0e27
	sjmp	X0faa
;
X0faa:	sjmp	X0fbb
;
X0fac:	mov	r0,#57h
	mov	a,@r0
	mov	r5,a
	mov	r0,#49h
	mov	a,@r0
	mov	r4,a
	lcall	X0e27
	mov	r0,#50h
	mov	@r0,#0
X0fbb:	mov	r0,#4ch
	mov	r4,#0ah
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0
	lcall	X0383
	mov	r0,#4ah
	inc	@r0
	ljmp	X0f38
;
X0fce:	ret	
;
	mov	r0,#45h
	mov	@r0,#0ch
	mov	r0,#44h
	mov	@r0,#0
	mov	r0,#48h
	mov	a,r6
	mov	@r0,a
	mov	r0,#46h
	mov	a,r5
	mov	@r0,a
	inc	r0
	mov	a,r4
	mov	@r0,a
	mov	r0,#44h
	mov	a,@r0
	clr	c
	subb	a,#4
	jnc	X1045
	mov	r0,#45h
	mov	a,@r0
	jnz	X0ff9
	mov	r0,#47h
	mov	a,@r0
	anl	a,#0fh
	mov	r0,#43h
	mov	@r0,a
	sjmp	X1014
;
X0ff9:	mov	r0,#46h
	mov	a,@r0
	mov	r5,a
	inc	r0
	mov	a,@r0
	mov	r0,#0ffh
	mov	r7,a
;
	org	1014h
;
X1014:	mov	r7,a
;
	org	1045h
;
X1045:	mov	r7,a
X1046:	mov	r7,a
;
	org	1072h
;
X1072:	mov	r7,a
;
;	Register/Memory Equates
;
rb0r7	equ	7
;
;	Miscellaneous equates
;
;  These are addresses referenced in the code but
;  which are in the middle of a multibyte instruction
;  or are addresses outside the initialized space
;
X0005	equ	5
X00ce	equ	0ceh
;
	end
;

