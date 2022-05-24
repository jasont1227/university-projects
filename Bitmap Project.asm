# Jason Ta
# jdt210003
# CS 2340
# Bitmap Project
# 
# It's literally just chess
# 
# The only registers that have a dedicated use throughout the program are
# $s5: holds the selected piece
# $s6: stores the cursor's x
# $s7: stores the cursor's y
# All other registers are used on a temporary basis, serving to store function inputs from a registers for use within functions,
# to store function outputs from v registers, and various computations
# Additionally, $s5 to $s7 aren't used directly by other functions; I pass their values into a registers beforehand
# Many registers are used by multiple functions, so I store t registers 
# onto the stack before calling another function that modifies t registers,
# and I store s registers within functions that modify s registers so 
# that the calling function still has the same values in those s registers.

# Also, there are a lot of repeated comments because I copy pasted a lot of code instead of making functions for them (I got lazy),
# so there are going to be a few comments that don't necessary line up with what's happening (didn't bother to change them as I got lazy).

# Functions have their purpose and designated input and output registers stated above their declaration

# Also whitespace and tabbing are all over the place, sorry

# Colors
.eqv	DARK_BROWN	0x00805300
.eqv	LIGHT_BROWN	0x00c78100
.eqv	BLACK		0x00000000
.eqv	WHITE		0x00ffffff
.eqv	DARK_RED	0x00690000
.eqv	LIGHT_RED	0x00c60000
.eqv	YELLOW		0x00ffff00
.eqv	GRAY		0x00696969

.eqv	WIDTH		128
.eqv	HEIGHT		128
.eqv	SQUARE_SIZE	16		# Remember to make this WIDTH / 8

.data
gp_pushback:	.space	32768		# Static data actually starts halfway into $gp on my canvas, 
					# so I have to pad this many bytes so it doesn't affect the canvas
pieces:		.space	256		# Array to hold the chess pieces


# $s6: cursor square x
# $s7: cursor square y
# $s5: selected piece
.text
main:
	jal	Draw_board
	
	# 06 = pawn
	# 01 = king
	# 02 = queen
	# 03 = rook
	# 04 = bishop
	# 05 = knight

	# 00 = white side
	# 01 = black side
	
	la	$s0, pieces
	
	li	$t0, 0x00000301			# Black pieces
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000501
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000401
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000101
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000201
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000401
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000501
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000301
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000601
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000601
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000601
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000601
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000601
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000601
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000601
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000601
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	addi	$s0, $s0, 128
	li	$t0, 0x00000600			# White pieces
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000600
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000600
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000600
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000600
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000600
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000600
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000600
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000300
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000500
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000400
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000100
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000200
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000400
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000500
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	li	$t0, 0x00000300
	sw	$t0, ($s0)
	addi	$s0, $s0, 4
	
	# 06 = pawn
	# 01 = king
	# 02 = queen
	# 03 = rook
	# 04 = bishop
	# 05 = knight
	
	jal	Draw_pieces
	
	
	
	li	$s6, 0		# Cursor x
	li	$s7, 3		# Cursor y
	
	draw_cursor:
		move	$a0, $s6
		move	$a1, $s7
		li	$a2, LIGHT_RED
		jal	Draw_cursor
	
	
	# Check keyboard input
	check_for_input:
		lw	$t0, 0xffff0000
		beq	$t0, $0, check_for_input
		
		lw	$t0, 0xffff0004
		beq	$t0, 32, select		# space
		beq	$t0, 119, up		# w
		beq	$t0, 115, down		# s
		beq	$t0, 97, left		# a
		beq	$t0, 100, right		# d
	
		j	check_for_input
	
		up:
		move	$a0, $s6		# Clear the previous cursor
		move	$a1, $s7
		jal	Clear_cursor
		addi	$s7, $s7, -1		# Move x
		move	$a0, $s7		# If x < 0 or > 7, make it 0 or 7
		li	$a1, 0
		li	$a2, 7
		jal	Restrict_bounds
		move	$s7, $v0
		j	draw_cursor		# Draw new cursor
		
		down:
		move	$a0, $s6
		move	$a1, $s7
		jal	Clear_cursor
		addi	$s7, $s7, 1
		move	$a0, $s7
		li	$a1, 0
		li	$a2, 7
		jal	Restrict_bounds
		move	$s7, $v0
		j	draw_cursor
		
		left:
		move	$a0, $s6
		move	$a1, $s7
		jal	Clear_cursor
		addi	$s6, $s6, -1
		move	$a0, $s6
		li	$a1, 0
		li	$a2, 7
		jal	Restrict_bounds
		move	$s6, $v0
		j	draw_cursor
		
		right:
		move	$a0, $s6
		move	$a1, $s7
		jal	Clear_cursor
		addi	$s6, $s6, 1
		move	$a0, $s6
		li	$a1, 0
		li	$a2, 7
		jal	Restrict_bounds
		move	$s6, $v0
		j	draw_cursor
		
		select:
		move	$a1, $s6
		move	$a2, $s7
		move	$a0, $s5
		jal	Cursor_select
		move	$s5, $v0
		
		j	draw_cursor
		

exit:
	li	$v0, 10
	syscall
	
# Functions -----------------------------------------------------------------------------------------------------

# Draws a pixel at the designated pixel coordinates
# Params
# $a0: x-coordinate
# $a1: y-coordinate
# $a2: color
Draw_pixel:
	mul	$t0, $a1, WIDTH		# y * width
	mul	$t0, $t0, 4		# * 4
	mul	$t1, $a0, 4		# x * 4
	add	$t2, $t0, $t1		# 4*y*width + 4*x
	add	$t3, $gp, $t2		# target address = $gp + 4*y*width + 4*x
	sw	$a2, ($t3)		# Store color at target
	
	jr	$ra


# Draws a square at the designated pixel coordinates with specified side length
# Params
# $a0: x-coordinate of top left corner
# $a1: y-coordinate of top left corner
# $a2: color
# $a3: side length
Draw_square:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# $t0: current x
	# $t1: current y
	# $t2: upper bound for x
	# $t3: upper bound for y
	
	move	$t0, $a0	# $t0 = starting x
	move	$t1, $a1	# $t1 = starting y
	add	$t2, $t0, $a3	# upper bound x = starting x + side length
	add	$t3, $t1, $a3	# same for upper bound y
	
	draw_loop:
	
		# Save $t0 to $t3
		addi	$sp, $sp, -4
		sw	$t0, ($sp)
		addi	$sp, $sp, -4
		sw	$t1, ($sp)
		addi	$sp, $sp, -4
		sw	$t2, ($sp)
		addi	$sp, $sp, -4
		sw	$t3, ($sp)
		
		move	$a0, $t0	# for draw_pixel
		move	$a1, $t1
		# color is already in $a2
		jal	Draw_pixel
		
		# Restore $t0 to $t3
		lw	$t3, ($sp)
		addi	$sp, $sp, 4
		lw	$t2, ($sp)
		addi	$sp, $sp, 4
		lw	$t1, ($sp)
		addi	$sp, $sp, 4
		lw	$t0, ($sp)
		addi	$sp, $sp, 4
		
		
		addi	$t0, $t0, 1		# add 1 to x
		
		blt	$t0, $t2, next		# if x > upper bound x
		sub	$t0, $t0, $a3		# x -= side length
		addi	$t1, $t1, 1		# y++
		
		next:
		bge	$t1, $t3, done		# If y >= upper y, you're done
		j	draw_loop		# else loop
	
	done:
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	
	jr	$ra
	
	
# Draws the squares for the board
Draw_board:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# $t0: current x
	# $t1: current y
	# $t2: max of 8
	# $t3: color
	
	li	$t0, 0
	li	$t1, 0
	li	$t2, 8
	li	$t3, 0
	
	
	# Put color into $a2 for Draw_square first
	li	$a2, DARK_BROWN
	
	draw_board_loop:
		# Store $t0 to $t3
		addi	$sp, $sp, -4
		sw	$t0, ($sp)
		addi	$sp, $sp, -4
		sw	$t1, ($sp)
		addi	$sp, $sp, -4
		sw	$t2, ($sp)
		addi	$sp, $sp, -4
		sw	$t3, ($sp)
		
		mul	$a0, $t0, SQUARE_SIZE
		mul	$a1, $t1, SQUARE_SIZE
		
		li	$a3, SQUARE_SIZE
		
		jal	Draw_square
		
		
		# Restore
		lw	$t3, ($sp)
		addi	$sp, $sp, 4
		lw	$t2, ($sp)
		addi	$sp, $sp, 4
		lw	$t1, ($sp)
		addi	$sp, $sp, 4
		lw	$t0, ($sp)
		addi	$sp, $sp, 4
		
		
		addi	$t0, $t0, 1		# add 1 to x
		
		# swap browns
		beq	$a2, DARK_BROWN, swap_to_light_brown
		li	$a2, DARK_BROWN
		j	swap_done
		swap_to_light_brown:
		li	$a2, LIGHT_BROWN
		
		swap_done:
		blt	$t0, $t2, next1		# if x >= upper bound x
		
		sub	$t0, $t0, $t2		# x -= 8
		addi	$t1, $t1, 1		# y++
		
		# Do another color swap when you go to the next row
		beq	$a2, DARK_BROWN, swap_to_light_brown_y
		li	$a2, DARK_BROWN
		j	next1
		swap_to_light_brown_y:
		li	$a2, LIGHT_BROWN
		
		next1:
		bge	$t1, $t2, done1		# If y >= 8, you're done
		j	draw_board_loop		# else loop

	done1:
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	
	jr	$ra




# Least sig. byte is side color, then piece, then selected

# most significant

# 00 = not selected
# 01 = selected

# 06 = pawn
# 01 = king
# 02 = queen
# 03 = rook
# 04 = bishop
# 05 = knight

# 00 = white side
# 01 = black side

# least significant

# Draws all the pieces as specified in the array pieces
Draw_pieces:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# Store as these s registers are used in Cursor_select
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	addi	$sp, $sp, -4
	sw	$s2, ($sp)
	addi	$sp, $sp, -4
	sw	$s3, ($sp)
	
	
	# $t0: squares into the array
	# $t1: x coord
	# $t2: y coord
	li	$t0, 0
	li	$t1, 0
	li	$t2, 0
	
	draw_pieces_loop:
	
		# Save these coords so later functions don't change them
		addi	$sp, $sp, -4
		sw	$t0, ($sp)
		addi	$sp, $sp, -4
		sw	$t1, ($sp)
		addi	$sp, $sp, -4
		sw	$t2, ($sp)
	
		# Move current x and y into argument registers
		move	$a0, $t1
		move	$a1, $t2
		
		jal	Get_address_from_coords
		move	$s0, $v0
		
		# Break apart hex
		lbu	$s1, ($s0)			# $s1 holds side color
		lbu	$s2, 1($s0)			# $s2 holds piece type
		lbu	$s3, 2($s0)			# $s3 holds selected
		
		
		# If the piece is selected turn it gray
		beq	$s3, 0x00, not_selected
		li	$a2, GRAY
		j	which_piece
		
		not_selected:
		# If the piece's color code is 0x00 make it white side, else black
		beq	$s1, 0x00, make_white		
		li	$a2, BLACK
		j	which_piece
		make_white:
		li	$a2, WHITE
		
		which_piece:
		bne	$s2, 0x01, queen_check
		jal	Draw_king
		j	done_draw_piece
		queen_check:
		bne	$s2, 0x02, rook_check
		jal	Draw_queen
		j	done_draw_piece
		rook_check:
		bne	$s2, 0x03, bishop_check
		jal	Draw_rook
		j	done_draw_piece
		bishop_check:
		bne	$s2, 0x04, knight_check
		jal	Draw_bishop
		j	done_draw_piece
		knight_check:
		bne	$s2, 0x05, pawn_check
		jal	Draw_knight
		j	done_draw_piece
		pawn_check:
		bne	$s2, 0x06, done_draw_piece
		jal	Draw_pawn
		j	done_draw_piece
	
	
		done_draw_piece:
	
		# Restore the coords
		lw	$t2, ($sp)
		addi	$sp, $sp, 4
		lw	$t1, ($sp)
		addi	$sp, $sp, 4
		lw	$t0, ($sp)
		addi	$sp, $sp, 4
		
		# Compute new x and y
		addi	$t0, $t0, 1			# Add 1 to how far we are into the array (squarewise)
		li	$t3, 8				
		div	$t0, $t3
		mfhi	$t1				# new x is the remainder
		mflo	$t2				# new y is the quotient
		
		ble	$t0, 64, draw_pieces_loop	# End of array when you've computed all 64 squares
	
	# Load s registers back
	lw	$s3, ($sp)
	addi	$sp, $sp, 4
	lw	$s2, ($sp)
	addi	$sp, $sp, 4
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra


# Params
# $a0: x-coordinate of space
# $a1: y-coordinate of space
# $a2: color, only BLACK or WHITE
Draw_pawn:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# Store $s0, $s1 as well, because Draw_pieces stores the address in $s0
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)

	# Using s registers now because if I continue using t registers to keep things orderly
	# then I'm gonna have a lot of repeated stack pushes and pops
	# $s0: x-coord of pixel
	# $s1: y-coord of pixel
	# $s2: white or black
	mul	$s0, $a0, SQUARE_SIZE
	mul	$s1, $a1, SQUARE_SIZE
	
	# hardcoded, unlucky
	# $a2 feeds into Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 10
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 10
	jal	Draw_pixel
	jal	Draw_base
	
	# Restore $s0, $s1
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra

# Params
# $a0: x-coordinate of space
# $a1: y-coordinate of space
# $a2: color, only BLACK or WHITE
Draw_king:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	
	# Store $s0, $s1 as well
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	
	# Multiply x and y by square_size to get pixel coords
	mul	$s0, $a0, SQUARE_SIZE
	mul	$s1, $a1, SQUARE_SIZE
	
	addi	$a0, $s0, 7	# Cross
	addi	$a1, $s1, 1
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 1
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 6	# Left wing thing
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 3
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 3
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 10
	jal	Draw_pixel
	addi	$a0, $s0, 9	# Right wing thing
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 10
	jal	Draw_pixel
	jal	Draw_base
	
	# Restore $s0, $s1
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra

# Params
# $a0: x-coordinate of space
# $a1: y-coordinate of space
# $a2: color, only BLACK or WHITE
Draw_queen:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# Store $s0, $s1 as well
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	
	mul	$s0, $a0, SQUARE_SIZE
	mul	$s1, $a1, SQUARE_SIZE
	
	addi	$a0, $s0, 3	# Left spike thing
	addi	$a1, $s1, 10
	jal	Draw_pixel
	addi	$a0, $s0, 3
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 2
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 2
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 1
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 1
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 2
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 2
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 3
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 5	# Mid left spike thing
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 8	# Mid right spike thing
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 11	# Right spike
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 13
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 14
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 14
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 13
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 13
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 13
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 10
	jal	Draw_pixel
	jal	Draw_base
	
	# Restore $s0, $s1
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra


# Params
# $a0: x-coordinate of space
# $a1: y-coordinate of space
# $a2: color, only BLACK or WHITE
Draw_rook:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# Store $s0, $s1 as well
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	
	mul	$s0, $a0, SQUARE_SIZE
	mul	$s1, $a1, SQUARE_SIZE
	
	addi	$a0, $s0, 4	# Spiky crown thing
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 5	# Torso
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 10
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 10
	jal	Draw_pixel
	jal	Draw_base
	
	# Restore $s0, $s1
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra



# Params
# $a0: x-coordinate of space
# $a1: y-coordinate of space
# $a2: color, only BLACK or WHITE
Draw_bishop:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# Store $s0, $s1 as well
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	
	mul	$s0, $a0, SQUARE_SIZE
	mul	$s1, $a1, SQUARE_SIZE
	
	addi	$a0, $s0, 7	# My fingers are tired
	addi	$a1, $s1, 1
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 1
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 10
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 10
	jal	Draw_pixel
	jal	Draw_base
	
	# Restore $s0, $s1
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra



# Params
# $a0: x-coordinate of space
# $a1: y-coordinate of space
# $a2: color, only BLACK or WHITE
Draw_knight:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# Store $s0, $s1 as well
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	
	mul	$s0, $a0, SQUARE_SIZE
	mul	$s1, $a1, SQUARE_SIZE
	
	addi	$a0, $s0, 8	# Drawing horses is hard
	addi	$a1, $s1, 1
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 10
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 4
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 5
	jal	Draw_pixel
	addi	$a0, $s0, 13
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 6
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 7
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 8
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 9
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 10
	jal	Draw_pixel
	jal	Draw_base
	
	# Restore $s0, $s1
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra

# Draws the base of the pieces
Draw_base:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# Store $s0, $s1 as well
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	
	addi	$a0, $s0, 4
	addi	$a1, $s1, 11
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 11
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 11
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 11
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 11
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 11
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 11
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 11
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 12
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 12
	jal	Draw_pixel
	addi	$a0, $s0, 4
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 5
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 6
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 7
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 8
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 9
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 10
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 11
	addi	$a1, $s1, 13
	jal	Draw_pixel

	# Restore $s0, $s1
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra



# Draws the selection cursor square
# Params
# $a0: square x
# $a1: square y
# $a2: color
Draw_cursor:

	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# Store $s0, $s1 as well
	addi	$sp, $sp, -4
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	
	mul	$s0, $a0, SQUARE_SIZE
	mul	$s1, $a1, SQUARE_SIZE
	
	addi	$a0, $s0, 0		# Top left corner
	addi	$a1, $s1, 0
	jal	Draw_pixel
	addi	$a0, $s0, 1
	addi	$a1, $s1, 0
	jal	Draw_pixel
	addi	$a0, $s0, 2
	addi	$a1, $s1, 0
	jal	Draw_pixel
	addi	$a0, $s0, 3
	addi	$a1, $s1, 0
	jal	Draw_pixel
	addi	$a0, $s0, 0
	addi	$a1, $s1, 1
	jal	Draw_pixel
	addi	$a0, $s0, 0
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 0
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 15		# Top right corner
	addi	$a1, $s1, 0
	jal	Draw_pixel
	addi	$a0, $s0, 14
	addi	$a1, $s1, 0
	jal	Draw_pixel
	addi	$a0, $s0, 13
	addi	$a1, $s1, 0
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 0
	jal	Draw_pixel
	addi	$a0, $s0, 15
	addi	$a1, $s1, 1
	jal	Draw_pixel
	addi	$a0, $s0, 15
	addi	$a1, $s1, 2
	jal	Draw_pixel
	addi	$a0, $s0, 15
	addi	$a1, $s1, 3
	jal	Draw_pixel
	addi	$a0, $s0, 0		# Bottom left corner
	addi	$a1, $s1, 15
	jal	Draw_pixel
	addi	$a0, $s0, 0
	addi	$a1, $s1, 14
	jal	Draw_pixel
	addi	$a0, $s0, 0
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 0
	addi	$a1, $s1, 12
	jal	Draw_pixel
	addi	$a0, $s0, 1
	addi	$a1, $s1, 15
	jal	Draw_pixel
	addi	$a0, $s0, 2
	addi	$a1, $s1, 15
	jal	Draw_pixel
	addi	$a0, $s0, 3
	addi	$a1, $s1, 15
	jal	Draw_pixel
	addi	$a0, $s0, 15		# Bottom right corner
	addi	$a1, $s1, 15
	jal	Draw_pixel
	addi	$a0, $s0, 15
	addi	$a1, $s1, 14
	jal	Draw_pixel
	addi	$a0, $s0, 15
	addi	$a1, $s1, 13
	jal	Draw_pixel
	addi	$a0, $s0, 15
	addi	$a1, $s1, 12
	jal	Draw_pixel
	addi	$a0, $s0, 14
	addi	$a1, $s1, 15
	jal	Draw_pixel
	addi	$a0, $s0, 13
	addi	$a1, $s1, 15
	jal	Draw_pixel
	addi	$a0, $s0, 12
	addi	$a1, $s1, 15
	jal	Draw_pixel
	
	
	# Restore $s0, $s1
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra

# Clears the cursor by drawing the square underneath it over it
# Params
# $a0: square x
# $a1: square y
Clear_cursor:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# if $a0 + $a1 is even, DARK_BROWN else LIGHT
	add	$t0, $a0, $a1
	li	$t1, 2
	div	$t0, $t1
	mfhi	$t0
	beq	$t0, 1, make_square_light_brown
	li	$a2, DARK_BROWN
	j	clear_it
	make_square_light_brown:
	li	$a2, LIGHT_BROWN
	clear_it:

	jal	Draw_cursor
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra

# Redraws a square based on square x and y coords
# Params
# $a0: square x
# $a1: square y
Redraw_square:
	# Store $ra as there are nested functions
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# if $s6 + $s7 is even, DARK_BROWN else LIGHT
	add	$t0, $a0, $a1
	li	$t1, 2
	div	$t0, $t1
	mfhi	$t0
	beq	$t0, 1, make_square_light_brown1
	li	$a2, DARK_BROWN
	j	redraw_the_square
	make_square_light_brown1:
	li	$a2, LIGHT_BROWN
	redraw_the_square:

	mul	$a0, $a0, SQUARE_SIZE
	mul	$a1, $a1, SQUARE_SIZE
	li	$a3, SQUARE_SIZE
	jal	Draw_square
	
	# Restore $ra
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
	


# Returns the address for the square at the specified coordinates
# Params
# $a0: x
# $a1: y
# Returns
# $v0: address of the desired data
Get_address_from_coords:
	la	$t0, pieces
	mul	$t1, $a0, 4
	mul	$t2, $a1, 32
	add	$t3, $t1, $t2
	add	$t0, $t0, $t3
	move	$v0, $t0

	jr	$ra
	
# Params
# $a0: address
# Returns
# $v0: square x
# $v1: square y
Get_coords_from_address:
	la	$t0, pieces
	sub	$t1, $a0, $t0
	div	$t1, $t1, 4
	li	$t2, 8
	div	$t1, $t2
	mfhi	$v0
	mflo	$v1
	
	jr	$ra
	

# Returns the number, or the lower/upper bound if the number is less/greater than said bounds
# Params
# $a0: the number
# $a1: lower bound
# $a2: upper bound
# Returns
# $v0: the number within bounds
Restrict_bounds:
	
	blt	$a0, $a1, return_lower
	bgt	$a0, $a2, return_upper
	move	$v0, $a0
	j	done_restrict_bounds
	return_lower:
	move	$v0, $a1
	j	done_restrict_bounds
	return_upper:
	move	$v0, $a2
	
	done_restrict_bounds:
	jr	$ra
	
	
# Selects the piece under the cursor and highlights possible places to move it
# Or places the selected piece
# Params
# $a0: address of the piece's data
# $a1: cursor x
# $a2: cursor y
# Returns
# $v0: original address or 0 if a piece was removed
Cursor_select:
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	move	$s0, $a0			# $s0 holds address of the piece
	move	$s1, $a1			# $s1 holds cursor x
	move	$s2, $a2			# $s2 holds cursor y

	bne	$s0, $0, place_piece_check	# If the address is 0 then no piece is selected, so select a piece
	# Select piece
	move	$a0, $s1			# Get cursor address
	move	$a1, $s2
	
	jal	Get_address_from_coords
	
	# Check if selected square has a piece or not
	lw	$t0, ($v0)
	beq	$t0, $0, no_piece_in_square
	move	$s0, $v0			# If there is a piece, move the address of the piece to $s0
	
	# Store the piece with selected as true
	ori	$t0, $t0, 0x00010000
	sw	$t0, ($s0)			# This will make the selected piece gray
	
	# highlight squares
	move	$a0, $s0
	jal	Highlight_squares
	
	no_piece_in_square:
	j	done_cursor_select
	
	place_piece_check:
	move	$a0, $s1		# Get address of cursor position
	move	$a1, $s2
	
	jal	Get_address_from_coords
	
	lw	$t0, ($s0)		# Load the piece's data from the address into $t0
	
	andi	$t0, $t0, 0xff00ffff	# Deselect the piece
	
	addi	$sp, $sp, -4		# Store this piece in stack
	sw	$t0, ($sp)
	
	
	# Remember $s0 still holds the original piece's address
	# STORE ONLY WHEN ON A VALID SPOT
	move	$a0, $s0
	jal	Get_coords_from_address
	move	$t3, $v0			# Original piece's x
	move	$t4, $v1			# Original piece's y
	
	# If you select the piece again, deselect it
	bne	$t3, $s1, test_for_piece	# If the x's are the same, fall through
	bne	$t4, $s2, test_for_piece	# If the y's are the same, place the piece at the same spot
	j	store_at_cursor
	
	test_for_piece:
	# Load piece data
	lbu	$t1, ($s0)			# $t1 contains side
	lbu	$t2, 1($s0)			# $t2 contains piece type
	
	# test_for_pawn:
	bne	$t2, 0x06, test_for_king
	
	beq	$t1, 0x00, test_for_pawn_white		# If pawn is white
	bne	$t3, $s1, pawn_black_check_diagonal	# If cursor x != pawn x
	addi	$t5, $s2, -1				# 1 above cursor
	bne	$t4, $t5, pawn_black_check_second_square		# If cursor is 1 square below pawn
	move	$a0, $s1
	move	$a1, $s2
	jal	Get_address_from_coords			# Get address at cursor
	lw	$t0, ($v0)				# Piece at cursor
	beq	$t0, $0, store_at_cursor		# If there isn't a piece, move king
	j	done_cursor_select_and_pop
	
	
	pawn_black_check_second_square:
	bne	$t4, 1, done_cursor_select_and_pop	# If pawn hasn't moved, allow it to move two squares
	addi	$t5, $s2, -2
	bne	$t4, $t5, done_cursor_select_and_pop	# if cursor is 2 squares below pawn
	move	$a0, $s1
	move	$a1, $s2
	jal	Get_address_from_coords			# Get address at cursor
	lw	$t0, ($v0)				# Piece at cursor
	beq	$t0, $0, store_at_cursor		# If there isn't a piece, move king
	j	done_cursor_select_and_pop
	
	pawn_black_check_diagonal:
	sub	$t5, $t3, $s1				# piece x - cursor x
	abs	$t5, $t5
	bne	$t5, 1, done_cursor_select_and_pop
	addi	$t5, $s2, -1				# 1 above cursor
	bne	$t4, $t5, done_cursor_select_and_pop		# If cursor is 1 square below pawn
	move	$a0, $s1
	move	$a1, $s2
	jal	Get_address_from_coords			# Get address at cursor
	lw	$t0, ($v0)				# Piece at cursor
	beq	$t0, $0, done_cursor_select_and_pop		# If there isn't a piece, move king
	lw	$t2, ($s0)
	xor	$t1, $t0, $t2				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	

	test_for_pawn_white:
	bne	$t3, $s1, pawn_white_check_diagonal	# If cursor x != pawn x
	addi	$t5, $s2, 1				# 1 above cursor
	bne	$t4, $t5, pawn_white_check_second_square		# If cursor is 1 square below pawn
	move	$a0, $s1
	move	$a1, $s2
	jal	Get_address_from_coords			# Get address at cursor
	lw	$t0, ($v0)				# Piece at cursor
	beq	$t0, $0, store_at_cursor		# If there isn't a piece, move king
	j	done_cursor_select_and_pop
	
	
	pawn_white_check_second_square:
	bne	$t4, 6, done_cursor_select_and_pop	# If pawn hasn't moved, allow it to move two squares
	addi	$t5, $s2, 2
	bne	$t4, $t5, done_cursor_select_and_pop	# if cursor is 2 squares below pawn
	move	$a0, $s1
	move	$a1, $s2
	jal	Get_address_from_coords			# Get address at cursor
	lw	$t0, ($v0)				# Piece at cursor
	beq	$t0, $0, store_at_cursor		# If there isn't a piece, move king
	j	done_cursor_select_and_pop
	
	
	
	
	
	pawn_white_check_diagonal:
	sub	$t5, $t3, $s1				# piece x - cursor x
	abs	$t5, $t5
	bne	$t5, 1, done_cursor_select_and_pop
	addi	$t5, $s2, 1				# 1 above cursor
	bne	$t4, $t5, done_cursor_select_and_pop		# If cursor is 1 square below pawn
	move	$a0, $s1
	move	$a1, $s2
	jal	Get_address_from_coords			# Get address at cursor
	lw	$t0, ($v0)				# Piece at cursor
	beq	$t0, $0, done_cursor_select_and_pop		# If there isn't a piece, move king
	lw	$t2, ($s0)
	xor	$t1, $t0, $t2				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	
	
	
	
	
	test_for_king:
	bne	$t2, 0x01, test_for_queen
	sub	$t5, $s1, $t3				# Difference between cursor x and king x
	abs	$t5, $t5
	bgt	$t5, 1, done_cursor_select_and_pop	# If cursor x is 1 x away from king, fall through
	sub	$t5, $s2, $t4				# Difference between cursor y and king y
	abs	$t5, $t5
	bgt	$t5, 1, done_cursor_select_and_pop	# If both cursor x and y are within 1 square of king, test if piece is ally or not
	move	$a0, $s1
	move	$a1, $s2
	jal	Get_address_from_coords			# Get address at cursor
	lw	$t0, ($v0)				# Piece at cursor
	beq	$t0, $0, store_at_cursor		# If there isn't a piece, move king
	lw	$t2, ($s0)
	xor	$t1, $t0, $t2				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	#test_for_queen:
	#bne	$t2, 0x02, test_for_rook
	#beq	$t3, $s1, store_at_cursor		# If cursor x and queen x are the same, move
	#beq	$t4, $s2, store_at_cursor		# If cursor y and queen y are the same, move
	#sub	$t5, $s1, $t3				# cursor x - queen x
	#abs	$t5, $t5
	#sub	$t6, $s2, $t4				# cursor y - queen y
	#abs	$t6, $t6
	#beq	$t5, $t6, store_at_cursor		# if cursor is diagonal to queen, move
	#j	done_cursor_select_and_pop
	
	
	
	test_for_queen:
	bne	$t2, 0x02, test_for_rook
	beq	$t3, $s1, queen_vertical_test_for_pieces	# If cursor x and queen x are the same, raycast vertically
	beq	$t4, $s2, queen_horizontal_test_for_pieces	# If cursor y and queen y are the same, raycast horizontally
	
	sub	$t5, $s1, $t3					# cursor x - queen x
	abs	$t6, $t5
	sub	$t7, $s2, $t4					# cursor y - queen y
	abs	$t8, $t7
	beq	$t6, $t8, queen_diagonal_test_for_pieces	# if cursor is diagonal to queen, move
	j	done_cursor_select_and_pop
	
	queen_diagonal_test_for_pieces:
	bne	$t5, $t7, queen_nesw_test_for_pieces		# If cursor is on /
	bgt	$t5, 0, pre_queen_raycast_se_loop		# Southeast raycast
	# Northwest raycast
	li	$t5, 1
	queen_raycast_nw_loop:
	
	sub	$t6, $t3, $t5				# $t6 = queen x + offset
	sub	$t7, $t4, $t5				# $t7 = queen y + offset
	blt	$t7, $s2, store_at_cursor		# If there are no pieces up to the cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t7				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, queen_raycast_nw_loop	# If there's a piece at this square, check cursor position, else continue
	blt	$s2, $t7, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	pre_queen_raycast_se_loop:
	li	$t5, 1
	queen_raycast_se_loop:
	add	$t6, $t3, $t5				# $t6 = queen x + offset
	add	$t7, $t4, $t5				# $t7 = queen y + offset
	
	bgt	$t7, $s2, store_at_cursor		# If there are no pieces up to the cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t7				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, queen_raycast_se_loop	# If there's a piece at this square, check cursor position, else continue
	bgt	$s2, $t7, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	
	
	
	
	queen_nesw_test_for_pieces:
	bgt	$t5, $t7, pre_queen_raycast_ne_loop		# Northeast raycast
	# Southwest raycast
	li	$t5, 1
	queen_raycast_sw_loop:
	
	sub	$t6, $t3, $t5				# $t6 = queen x + offset
	add	$t7, $t4, $t5				# $t7 = queen y + offset
	
	bgt	$t7, $s2, store_at_cursor		# If there are no pieces up to the cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t7				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, queen_raycast_sw_loop	# If there's a piece at this square, check cursor position, else continue
	bgt	$s2, $t7, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	pre_queen_raycast_ne_loop:
	li	$t5, 1
	queen_raycast_ne_loop:
	add	$t6, $t3, $t5				# $t6 = queen x + offset
	sub	$t7, $t4, $t5				# $t7 = queen y + offset
	
	blt	$t7, $s2, store_at_cursor		# If there are no pieces up to the cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t7				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, queen_raycast_ne_loop	# If there's a piece at this square, check cursor position, else continue
	blt	$s2, $t7, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	queen_vertical_test_for_pieces:
	li	$t5, 1
	
	bgt	$s2, $t4, queen_raycast_south_loop		# if cursor y > queen y
	
	# Raycast north
	queen_raycast_north_loop:
	sub	$t6, $t4, $t5				# $t6 = queen y + offset
	blt	$t6, $s2, store_at_cursor		# If there are no pieces up to rhe cursor, just store at cursor
	move	$a0, $t3				# queen x
	move	$a1, $t6				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, queen_raycast_north_loop	# If there's a piece at this square, check cursor position, else continue
	blt	$s2, $t6, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	# Raycast south
	queen_raycast_south_loop:
	add	$t6, $t4, $t5				# $t6 = queen y + offset
	bgt	$t6, $s2, store_at_cursor		# If there are no pieces up to rhe cursor, just store at cursor
	move	$a0, $t3				# queen x
	move	$a1, $t6				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, queen_raycast_south_loop	# If there's a piece at this square, check cursor position, else continue
	bgt	$s2, $t6, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	queen_horizontal_test_for_pieces:
	li	$t5, 1
	
	bgt	$s1, $t3, queen_raycast_east_loop		# if cursor x > queen x

	# Raycast west
	queen_raycast_west_loop:
	sub	$t6, $t3, $t5				# $t6 = queen x - offset
	blt	$t6, $s1, store_at_cursor		# If there are no pieces up to rhe cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t4				# queen y
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, queen_raycast_west_loop	# If there's a piece at this square, check cursor position, else continue
	blt	$s1, $t6, done_cursor_select_and_pop	# If cursor x > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	# Raycast east
	queen_raycast_east_loop:
	add	$t6, $t3, $t5				# $t6 = queen x + offset
	bgt	$t6, $s1, store_at_cursor		# If there are no pieces up to rhe cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t4				# queen y
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, queen_raycast_east_loop	# If there's a piece at this square, check cursor position, else continue
	bgt	$s1, $t6, done_cursor_select_and_pop	# If cursor x > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	
	
	
	#test_for_rook:
	#bne	$t2, 0x03, test_for_bishop
	#beq	$t3, $s1, store_at_cursor		# If cursor x and rook x are the same, move
	#beq	$t4, $s2, store_at_cursor		# If cursor y and rook y are the same, move
	#j	done_cursor_select_and_pop
	
	test_for_rook:
	bne	$t2, 0x03, test_for_bishop
	beq	$t3, $s1, rook_vertical_test_for_pieces		# If cursor x and queen x are the same, raycast vertically
	beq	$t4, $s2, rook_horizontal_test_for_pieces	# If cursor y and queen y are the same, raycast horizontally
	j	done_cursor_select_and_pop
	
	rook_vertical_test_for_pieces:
	li	$t5, 1
	
	bgt	$s2, $t4, rook_raycast_south_loop		# if cursor y > queen y
	
	# Raycast north
	rook_raycast_north_loop:
	sub	$t6, $t4, $t5				# $t6 = queen y + offset
	blt	$t6, $s2, store_at_cursor		# If there are no pieces up to rhe cursor, just store at cursor
	move	$a0, $t3				# queen x
	move	$a1, $t6				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, rook_raycast_north_loop	# If there's a piece at this square, check cursor position, else continue
	blt	$s2, $t6, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	# Raycast south
	rook_raycast_south_loop:
	add	$t6, $t4, $t5				# $t6 = queen y + offset
	bgt	$t6, $s2, store_at_cursor		# If there are no pieces up to rhe cursor, just store at cursor
	move	$a0, $t3				# queen x
	move	$a1, $t6				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, rook_raycast_south_loop	# If there's a piece at this square, check cursor position, else continue
	bgt	$s2, $t6, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	rook_horizontal_test_for_pieces:
	li	$t5, 1
	
	bgt	$s1, $t3, rook_raycast_east_loop		# if cursor x > queen x

	# Raycast west
	rook_raycast_west_loop:
	sub	$t6, $t3, $t5				# $t6 = queen x - offset
	blt	$t6, $s1, store_at_cursor		# If there are no pieces up to rhe cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t4				# queen y
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, rook_raycast_west_loop	# If there's a piece at this square, check cursor position, else continue
	blt	$s1, $t6, done_cursor_select_and_pop	# If cursor x > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	# Raycast east
	rook_raycast_east_loop:
	add	$t6, $t3, $t5				# $t6 = queen x + offset
	bgt	$t6, $s1, store_at_cursor		# If there are no pieces up to rhe cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t4				# queen y
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, rook_raycast_east_loop	# If there's a piece at this square, check cursor position, else continue
	bgt	$s1, $t6, done_cursor_select_and_pop	# If cursor x > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop		# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#test_for_bishop:
	#bne	$t2, 0x04, test_for_knight
	#sub	$t5, $s1, $t3				# cursor x - bishop x
	#abs	$t5, $t5
	#sub	$t6, $s2, $t4				# cursor y - bishop y
	#abs	$t6, $t6
	#beq	$t5, $t6, store_at_cursor		# if cursor is diagonal to bishop, move
	#j	done_cursor_select_and_pop
	
	test_for_bishop:
	bne	$t2, 0x04, test_for_knight
	sub	$t5, $s1, $t3					# cursor x - queen x
	abs	$t6, $t5
	sub	$t7, $s2, $t4					# cursor y - queen y
	abs	$t8, $t7
	beq	$t6, $t8, bishop_diagonal_test_for_pieces	# if cursor is diagonal to queen, move
	j	done_cursor_select_and_pop
	
	bishop_diagonal_test_for_pieces:
	bne	$t5, $t7, bishop_nesw_test_for_pieces		# If cursor is on /
	bgt	$t5, 0, pre_bishop_raycast_se_loop		# Southeast raycast
	# Northwest raycast
	li	$t5, 1
	bishop_raycast_nw_loop:
	
	sub	$t6, $t3, $t5				# $t6 = queen x + offset
	sub	$t7, $t4, $t5				# $t7 = queen y + offset
	blt	$t7, $s2, store_at_cursor		# If there are no pieces up to the cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t7				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, bishop_raycast_nw_loop		# If there's a piece at this square, check cursor position, else continue
	blt	$s2, $t7, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop	# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	pre_bishop_raycast_se_loop:
	li	$t5, 1
	bishop_raycast_se_loop:
	add	$t6, $t3, $t5				# $t6 = queen x + offset
	add	$t7, $t4, $t5				# $t7 = queen y + offset
	
	bgt	$t7, $s2, store_at_cursor		# If there are no pieces up to the cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t7				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, bishop_raycast_se_loop		# If there's a piece at this square, check cursor position, else continue
	bgt	$s2, $t7, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop	# If same side, don't highlight
	j	store_at_cursor
	

	bishop_nesw_test_for_pieces:
	bgt	$t5, $t7, pre_bishop_raycast_ne_loop	# Northeast raycast
	# Southwest raycast
	li	$t5, 1
	bishop_raycast_sw_loop:
	
	sub	$t6, $t3, $t5				# $t6 = queen x + offset
	add	$t7, $t4, $t5				# $t7 = queen y + offset
	
	bgt	$t7, $s2, store_at_cursor		# If there are no pieces up to the cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t7				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, bishop_raycast_sw_loop		# If there's a piece at this square, check cursor position, else continue
	bgt	$s2, $t7, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop	# If same side, don't highlight
	j	store_at_cursor
	
	
	pre_bishop_raycast_ne_loop:
	li	$t5, 1
	bishop_raycast_ne_loop:
	add	$t6, $t3, $t5				# $t6 = queen x + offset
	sub	$t7, $t4, $t5				# $t7 = queen y + offset
	
	blt	$t7, $s2, store_at_cursor		# If there are no pieces up to the cursor, just store at cursor
	move	$a0, $t6				# queen x + offset
	move	$a1, $t7				# queen y + offset
	
	addi	$sp, $sp, -4				# Store $t3 as Get_address_from_coords modifies up to $t3
	sw	$t3, ($sp)
	
	jal	Get_address_from_coords			# Get address at this square
	
	lw	$t3, ($sp)
	addi	$sp, $sp, 4
	
	lw	$t9, ($v0)				# Piece at this square
	addi	$t5, $t5, 1
	beq	$t9, $0, bishop_raycast_ne_loop		# If there's a piece at this square, check cursor position, else continue
	blt	$s2, $t7, done_cursor_select_and_pop	# If cursor y > the first piece, don't move
	# check piece ally or not, move accordingly
	lw	$t7, ($s0)				# Queen data
	xor	$t8, $t9, $t7				# Test if queen and current piece are same side
	andi	$t8, $t8, 0x000000ff
	beq	$t8, $0, done_cursor_select_and_pop	# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	
	
	
	
	
	test_for_knight:
	bne	$t2, 0x05, done_cursor_select_and_pop
	beq	$t3, $s1, done_cursor_select_and_pop	# If cursor x and knight x are the same, not valid
	beq	$t4, $s2, done_cursor_select_and_pop	# If cursor y and knight y are the same, not valid
	sub	$t5, $s1, $t3				# cursor x - knight x
	abs	$t5, $t5
	sub	$t6, $s2, $t4				# cursor y - knight y
	abs	$t6, $t6
	add	$t5, $t5, $t6				# Sum of delta x and delta y
	bne	$t5, 3, done_cursor_select_and_pop	# If delta x + delta y = 3, test for pieces
	# Test for pieces
	move	$a0, $s1
	move	$a1, $s2
	jal	Get_address_from_coords			# Get address at cursor
	lw	$t0, ($v0)				# Piece at cursor
	beq	$t0, $0, store_at_cursor		# If there isn't a piece, move king
	lw	$t2, ($s0)
	xor	$t1, $t0, $t2				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_cursor_select_and_pop	# If same side, don't highlight
	j	store_at_cursor
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	store_at_cursor:
	
	# Clear old piece
	move	$a0, $s0
	jal	Get_coords_from_address
	move	$a0, $v0
	move	$a1, $v1
	jal	Redraw_square
	sw	$0, ($s0)		# Store 0 back into the address (removing the piece)
	
	
	
	move	$a0, $s1		# Get address of cursor position
	move	$a1, $s2
	
	jal	Get_address_from_coords
	
	lw	$t0, ($sp)		# Load the piece back
	addi	$sp, $sp, 4
	
	sw	$t0, ($v0)		# Store the piece's data at the cursor position
	
	
	
	
	# Draw new piece
	move	$a0, $s1
	move	$a1, $s2
	jal	Redraw_square		# Clear the square at the cursor first
	
	jal	Draw_board
	
	
	
	li	$s0, 0			# Set the address back to 0
	
	j	done_cursor_select
	
	done_cursor_select_and_pop:	# If the piece was not placed in a valid spot, move $sp up
	addi	$sp, $sp, 4
	
	done_cursor_select:
	jal	Draw_pieces		# Redraw the pieces
	
	move	$v0, $s0
	
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
	
# Draws a yellow square based on x and y coords
# Params
# $a0: square x
# $a1: square y
# $a2: color
Highlight_square:
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	#li	$a2, YELLOW

	blt	$a0, $0, skip_highlight		# If x and y are outside of board don't do anything
	blt	$a1, $0, skip_highlight
	bgt	$a0, 7, skip_highlight
	bgt	$a1, 7, skip_highlight



	mul	$a0, $a0, SQUARE_SIZE		# Draw yellow square
	mul	$a1, $a1, SQUARE_SIZE
	li	$a3, SQUARE_SIZE
	jal	Draw_square
	
	skip_highlight:
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
	
# Highlight squares based on selected piece
# Params
# $a0: address of piece data
Highlight_squares:
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	
	addi	$sp, $sp, -4				# Save these because Cursor_select uses them
	sw	$s0, ($sp)
	addi	$sp, $sp, -4
	sw	$s1, ($sp)
	addi	$sp, $sp, -4
	sw	$s2, ($sp)
	addi	$sp, $sp, -4
	sw	$s3, ($sp)
	
	
	lbu	$s0, ($a0)				# $s0 holds the piece side
	lbu	$s1, 1($a0)				# $s1 holds the piece type
	
	jal	Get_coords_from_address
	
	move	$s2, $v0				# $s2 holds x
	move	$s3, $v1				# $s3 holds y
	
	li	$a2, YELLOW				# Highlight in yellow
	
	
	# If king
	bne	$s1, 0x01, pawn_check_highlight		# if king
	addi	$a0, $s2, -1
	addi	$a1, $s3, -1
	blt	$a0, 0, king_next_square1
	blt	$a1, 0, king_next_square1
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, king_test_opposite_side1	# If there is a piece, test if it's from opposite side
	jal	Highlight_square
	j	king_next_square1
	king_test_opposite_side1:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, king_next_square1		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	king_next_square1:
	addi	$a0, $s2, 0
	addi	$a1, $s3, -1
	blt	$a1, 0, king_next_square2
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, king_test_opposite_side2		# If there is a piece, stop highlighting
	jal	Highlight_square
	j	king_next_square2
	king_test_opposite_side2:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, king_next_square2		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	king_next_square2:
	addi	$a0, $s2, 1
	addi	$a1, $s3, -1
	bgt	$a0, 7, king_next_square3
	blt	$a1, 0, king_next_square3
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, king_test_opposite_side3	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	king_next_square3
	king_test_opposite_side3:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, king_next_square3		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	king_next_square3:
	addi	$a0, $s2, -1
	addi	$a1, $s3, 0
	blt	$a0, 0, king_next_square4
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, king_test_opposite_side4	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	king_next_square4
	king_test_opposite_side4:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, king_next_square4		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	king_next_square4:
	addi	$a0, $s2, 1
	addi	$a1, $s3, 0
	bgt	$a0, 7, king_next_square5
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, king_test_opposite_side5	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	king_next_square5
	king_test_opposite_side5:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, king_next_square5		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	king_next_square5:
	addi	$a0, $s2, -1
	addi	$a1, $s3, 1
	blt	$a0, 0, king_next_square6
	bgt	$a1, 7, king_next_square6
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, king_test_opposite_side6	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	king_next_square6
	king_test_opposite_side6:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, king_next_square6		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	king_next_square6:
	addi	$a0, $s2, 0
	addi	$a1, $s3, 1
	bgt	$a1, 7, king_next_square7
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, king_test_opposite_side7	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	king_next_square7
	king_test_opposite_side7:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, king_next_square7		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	king_next_square7:
	addi	$a0, $s2, 1
	addi	$a1, $s3, 1
	bgt	$a0, 7, done_check_highlight
	bgt	$a1, 7, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, king_test_opposite_side8	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	done_check_highlight
	king_test_opposite_side8:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_check_highlight		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	j	done_check_highlight
	li	$a2, YELLOW
	
	
	pawn_check_highlight:
	bne	$s1, 0x06, queen_check_highlight	# if pawn
	beq	$s0, 0x00, pawn_white_highlight		# If piece is white, highlight sqaures above, not below
	# Pawn black highlight
	addi	$a0, $s2, 0
	addi	$a1, $s3, 1
	bgt	$a1, 7, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, pawn_red_square1		# If there is a piece, stop highlighting
	jal	Highlight_square
	
	pawn_red_square1:
	# Red squares
	addi	$a0, $s2, 1
	addi	$a1, $s3, 1
	bgt	$a1, 7, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	beq	$t0, $0, pawn_red_square2		# If there is a piece, stop highlighting
	# check allied
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pawn_red_square2		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	#j	done_check_highlight
	
	
	pawn_red_square2:
	# Red squares
	addi	$a0, $s2, -1
	addi	$a1, $s3, 1
	bgt	$a1, 7, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	beq	$t0, $0, pawn_black_second_square	# If there is a piece, stop highlighting
	# check allied
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pawn_black_second_square	# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	pawn_black_second_square:
	bne	$s3, 1, done_check_highlight		# Don't draw second square if the pawn has moved
	addi	$a0, $s2, 0
	addi	$a1, $s3, 2
	bgt	$a1, 7, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, done_check_highlight		# If there is a piece, stop highlighting
	jal	Highlight_square
	j	done_check_highlight
	
	pawn_white_highlight:
	addi	$a0, $s2, 0
	addi	$a1, $s3, -1
	blt	$a1, 0, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, pawn_white_red_square1		# If there is a piece, stop highlighting
	jal	Highlight_square
	
	pawn_white_red_square1:
	# Red squares
	addi	$a0, $s2, 1
	addi	$a1, $s3, -1
	blt	$a1, 0, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	beq	$t0, $0, pawn_white_red_square2		# If there is a piece, stop highlighting
	# check allied
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pawn_white_red_square2		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	#j	done_check_highlight
	
	
	pawn_white_red_square2:
	# Red squares
	addi	$a0, $s2, -1
	addi	$a1, $s3, -1
	blt	$a1, 0, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	beq	$t0, $0, pawn_white_second_square	# If there is a piece, stop highlighting
	# check allied
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pawn_white_second_square	# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	pawn_white_second_square:
	bne	$s3, 6, done_check_highlight		# Don't draw second square if the pawn has moved
	addi	$a0, $s2, 0
	addi	$a1, $s3, -2
	blt	$a1, 0, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, done_check_highlight		# If there is a piece, stop highlighting
	jal	Highlight_square
	j	done_check_highlight
	
	# TLDR: this essentially sends a line in each direction, checks if a piece is there, 
	# and if it's not it highlights a square and repeats
	# took way too long to write sadge
	queen_check_highlight:
	bne	$s1, 0x02, rook_check_highlight		# if queen
	li	$s4, 1					# index thing
	queen_highlight_loop_east:
	add	$a0, $s2, $s4
	addi	$a1, $s3, 0
	bgt	$a0, 7, pre_west
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, queen_test_opposite_side_east	# If there is a piece, test for piece
	jal	Highlight_square			# east
	addi	$s4, $s4, 1
	ble	$s4, 7, queen_highlight_loop_east
	j	pre_west
	queen_test_opposite_side_east:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pre_west			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	pre_west:
	li	$s4, 1					# index thing
	queen_highlight_loop_west:
	sub	$a0, $s2, $s4
	addi	$a1, $s3, 0
	blt	$a0, 0, pre_south
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, queen_test_opposite_side_west	# If there is a piece, stop highlighting
	jal	Highlight_square			# west
	addi	$s4, $s4, 1
	ble	$s4, 7, queen_highlight_loop_west
	j	pre_south
	queen_test_opposite_side_west:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pre_south			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	pre_south:
	li	$s4, 1					# index thing
	queen_highlight_loop_south:
	addi	$a0, $s2, 0
	add	$a1, $s3, $s4
	bgt	$a1, 7, pre_north
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, queen_test_opposite_side_south	# If there is a piece, stop highlighting
	jal	Highlight_square			# south
	addi	$s4, $s4, 1
	ble	$s4, 7, queen_highlight_loop_south
	j	pre_north
	queen_test_opposite_side_south:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pre_north			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	pre_north:
	li	$s4, 1					# index thing
	queen_highlight_loop_north:
	addi	$a0, $s2, 0
	sub	$a1, $s3, $s4
	blt	$a1, 0, pre_ne
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, queen_test_opposite_side_north	# If there is a piece, stop highlighting
	jal	Highlight_square			# north
	addi	$s4, $s4, 1
	ble	$s4, 7, queen_highlight_loop_north
	j	pre_ne
	queen_test_opposite_side_north:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pre_ne				# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	pre_ne:
	li	$s4, 1					# index thing
	queen_highlight_loop_ne:
	add	$a0, $s2, $s4
	sub	$a1, $s3, $s4
	bgt	$a0, 7, pre_sw
	blt	$a1, 0, pre_sw
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, queen_test_opposite_side_ne	# If there is a piece, stop highlighting
	jal	Highlight_square			# / corner
	addi	$s4, $s4, 1
	ble	$s4, 7, queen_highlight_loop_ne
	j	pre_sw
	queen_test_opposite_side_ne:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pre_sw				# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	pre_sw:
	li	$s4, 1					# index thing
	queen_highlight_loop_sw:
	sub	$a0, $s2, $s4
	add	$a1, $s3, $s4
	blt	$a0, 0, pre_se
	bgt	$a1, 7, pre_se
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, queen_test_opposite_side_sw	# If there is a piece, stop highlighting
	jal	Highlight_square			# / corner
	addi	$s4, $s4, 1
	ble	$s4, 7, queen_highlight_loop_sw
	j	pre_se
	queen_test_opposite_side_sw:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pre_se				# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	pre_se:
	li	$s4, 1					# index thing
	queen_highlight_loop_se:
	add	$a0, $s2, $s4
	add	$a1, $s3, $s4
	bgt	$a0, 7, pre_nw
	bgt	$a1, 7, pre_nw
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, queen_test_opposite_side_se	# If there is a piece, stop highlighting
	jal	Highlight_square			# \ corner
	addi	$s4, $s4, 1
	ble	$s4, 7, queen_highlight_loop_se
	j	pre_nw
	queen_test_opposite_side_se:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, pre_nw				# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	pre_nw:
	li	$s4, 1					# index thing
	queen_highlight_loop_nw:
	sub	$a0, $s2, $s4
	sub	$a1, $s3, $s4
	blt	$a0, 0, done_check_highlight
	blt	$a1, 0, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, queen_test_opposite_side_nw	# If there is a piece, stop highlighting
	jal	Highlight_square			# \ corner
	addi	$s4, $s4, 1
	ble	$s4, 7, queen_highlight_loop_nw
	j	done_check_highlight
	queen_test_opposite_side_nw:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_check_highlight		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	j	done_check_highlight
	
	
	
	
	rook_check_highlight:
	bne	$s1, 0x03, bishop_check_highlight	# if rook
	li	$s4, 1
	rook_highlight_loop_east:
	add	$a0, $s2, $s4
	addi	$a1, $s3, 0
	bgt	$a0, 7, rook_pre_west
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, rook_test_opposite_side_east	# If there is a piece, stop highlighting
	jal	Highlight_square			# east
	addi	$s4, $s4, 1
	ble	$s4, 7, rook_highlight_loop_east
	j	rook_pre_west
	rook_test_opposite_side_east:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, rook_pre_west			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	rook_pre_west:
	li	$s4, 1					# index thing
	rook_highlight_loop_west:
	sub	$a0, $s2, $s4
	addi	$a1, $s3, 0
	blt	$a0, 0, rook_pre_south
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, rook_test_opposite_side_west	# If there is a piece, stop highlighting
	jal	Highlight_square			# west
	addi	$s4, $s4, 1
	ble	$s4, 7, rook_highlight_loop_west
	j	rook_pre_south
	rook_test_opposite_side_west:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, rook_pre_south			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	rook_pre_south:
	li	$s4, 1					# index thing
	rook_highlight_loop_south:
	addi	$a0, $s2, 0
	add	$a1, $s3, $s4
	bgt	$a1, 7, rook_pre_north
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, rook_test_opposite_side_south	# If there is a piece, stop highlighting
	jal	Highlight_square			# south
	addi	$s4, $s4, 1
	ble	$s4, 7, rook_highlight_loop_south
	j	rook_pre_north
	rook_test_opposite_side_south:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, rook_pre_north			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	rook_pre_north:
	li	$s4, 1					# index thing
	rook_highlight_loop_north:
	addi	$a0, $s2, 0
	sub	$a1, $s3, $s4
	blt	$a1, 0, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, rook_test_opposite_side_north	# If there is a piece, stop highlighting
	jal	Highlight_square			# north
	addi	$s4, $s4, 1
	ble	$s4, 7, rook_highlight_loop_north
	j	done_check_highlight
	rook_test_opposite_side_north:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_check_highlight		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	
	
	bishop_check_highlight:
	bne	$s1, 0x04, knight_check_highlight	# if bishop
	li	$s4, 1
	bishop_highlight_loop_ne:
	add	$a0, $s2, $s4
	sub	$a1, $s3, $s4
	bgt	$a0, 7, bishop_pre_sw
	blt	$a1, 0, bishop_pre_sw
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, bishop_test_opposite_side_ne	# If there is a piece, stop highlighting
	jal	Highlight_square			# / corner
	addi	$s4, $s4, 1
	ble	$s4, 7, bishop_highlight_loop_ne
	j	bishop_pre_sw
	bishop_test_opposite_side_ne:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, bishop_pre_sw			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	bishop_pre_sw:
	li	$s4, 1					# index thing
	bishop_highlight_loop_sw:
	sub	$a0, $s2, $s4
	add	$a1, $s3, $s4
	blt	$a0, 0, bishop_pre_se
	bgt	$a1, 7, bishop_pre_se
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, bishop_test_opposite_side_sw	# If there is a piece, stop highlighting
	jal	Highlight_square			# / corner
	addi	$s4, $s4, 1
	ble	$s4, 7, bishop_highlight_loop_sw
	j	bishop_pre_se
	bishop_test_opposite_side_sw:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, bishop_pre_se			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	bishop_pre_se:
	li	$s4, 1					# index thing
	bishop_highlight_loop_se:
	add	$a0, $s2, $s4
	add	$a1, $s3, $s4
	bgt	$a0, 7, bishop_pre_nw
	bgt	$a1, 7, bishop_pre_nw
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, bishop_test_opposite_side_se	# If there is a piece, stop highlighting
	jal	Highlight_square			# \ corner
	addi	$s4, $s4, 1
	ble	$s4, 7, bishop_highlight_loop_se
	j	bishop_pre_nw
	bishop_test_opposite_side_se:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, bishop_pre_nw			# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	bishop_pre_nw:
	li	$s4, 1					# index thing
	bishop_highlight_loop_nw:
	sub	$a0, $s2, $s4
	sub	$a1, $s3, $s4
	blt	$a0, 0, done_check_highlight
	blt	$a1, 0, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, bishop_test_opposite_side_nw	# If there is a piece, stop highlighting
	jal	Highlight_square			# \ corner
	addi	$s4, $s4, 1
	ble	$s4, 7, bishop_highlight_loop_nw
	j	done_check_highlight
	bishop_test_opposite_side_nw:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_check_highlight		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	
	knight_check_highlight:
	bne	$s1, 0x05, done_check_highlight		# if knight
	addi	$a0, $s2, -2
	addi	$a1, $s3, -1
	blt	$a0, 0, knight_next_square1
	blt	$a1, 0, knight_next_square1
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, knight_test_opposite_side1	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	knight_next_square1
	knight_test_opposite_side1:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, knight_next_square1		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	knight_next_square1:
	addi	$a0, $s2, -1
	addi	$a1, $s3, -2
	blt	$a0, 0, knight_next_square2
	blt	$a1, 0, knight_next_square2
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, knight_test_opposite_side2	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	knight_next_square2
	knight_test_opposite_side2:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, knight_next_square2		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	
	knight_next_square2:
	addi	$a0, $s2, 2
	addi	$a1, $s3, -1
	bgt	$a0, 7, knight_next_square3
	blt	$a1, 0, knight_next_square3
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, knight_test_opposite_side3	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	knight_next_square3
	knight_test_opposite_side3:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, knight_next_square3		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	knight_next_square3:
	addi	$a0, $s2, -2
	addi	$a1, $s3, 1
	blt	$a0, 0, knight_next_square4
	bgt	$a1, 7, knight_next_square4
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, knight_test_opposite_side4	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	knight_next_square4
	knight_test_opposite_side4:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, knight_next_square4		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	knight_next_square4:
	addi	$a0, $s2, -1
	addi	$a1, $s3, 2
	blt	$a0, 0, knight_next_square5
	bgt	$a1, 7, knight_next_square5
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, knight_test_opposite_side5	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	knight_next_square5
	knight_test_opposite_side5:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, knight_next_square5		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	
	
	
	knight_next_square5:
	addi	$a0, $s2, 1
	addi	$a1, $s3, -2
	bgt	$a0, 7, knight_next_square6
	blt	$a1, 0, knight_next_square6
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, knight_test_opposite_side6	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	knight_next_square6
	knight_test_opposite_side6:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, knight_next_square6		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	knight_next_square6:
	addi	$a0, $s2, 1
	addi	$a1, $s3, 2
	bgt	$a0, 7, knight_next_square7
	bgt	$a1, 7, knight_next_square7
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, knight_test_opposite_side7	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	knight_next_square7
	knight_test_opposite_side7:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, knight_next_square7		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	knight_next_square7:
	addi	$a0, $s2, 2
	addi	$a1, $s3, 1
	bgt	$a0, 7, done_check_highlight
	bgt	$a1, 7, done_check_highlight
	jal	Get_address_from_coords			# Get address at highlight
	lw	$t0, ($v0)				# Piece at highlight
	bne	$t0, $0, knight_test_opposite_side8	# If there is a piece, stop highlighting
	jal	Highlight_square
	j	done_check_highlight
	knight_test_opposite_side8:
	xor	$t1, $t0, $s0				# Test if the piece is the same side
	andi	$t1, $t1, 0x000000ff
	beq	$t1, $0, done_check_highlight		# If same side, don't highlight
	li	$a2, DARK_RED
	jal	Highlight_square			# If not same, highlight opposing piece red
	li	$a2, YELLOW
	
	
	
	done_check_highlight:
	lw	$s3, ($sp)
	addi	$sp, $sp, 4
	lw	$s2, ($sp)
	addi	$sp, $sp, 4
	lw	$s1, ($sp)
	addi	$sp, $sp, 4
	lw	$s0, ($sp)
	addi	$sp, $sp, 4
	
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra











