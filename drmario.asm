################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Aref Malekanian, 1010193951
# Student 2: Albert Jun, 1009927144
#
# Implemented easy features: 1, 2, 4, 6, 11, 13
# Implemented hard feature: 5
#
# We assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
#
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       2
# - Unit height in pixels:     	2
# - Display width in pixels:    64
# - Display height in pixels:   64
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

BOTTLE_X_OFFSET: .word 9
BOTTLE_Y_OFFSET: .word 12
BOTTLE_WIDTH: .word 12
BOTTLE_HEIGHT: .word 18
NUM_VIRUSES: .word 4

# 24 by 14 sprite
GAME_OVER_SPRITE:
    .word 0, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038, 0, 0, 0, 0xA4D038, 0xA4D038, 0xA4D038, 0, 0, 0xA4D038, 0, 0, 0, 0xA4D038, 0, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038
    .word 0xA4D038, 0, 0, 0, 0,  0xA4D038, 0,  0xA4D038,  0xA4D038, 0,  0xA4D038,  0xA4D038, 0,  0xA4D038,  0xA4D038, 0  0xA4D038,  0xA4D038, 0  0xA4D038,  0xA4D038, 0, 0, 0
    .word 0xA4D038, 0, 0, 0, 0, 0, 0, 0xA4D038, 0xA4D038, 0, 0xA4D038, 0xA4D038, 0, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038, 0 0xA4D038, 0xA4D038, 0, 0, 0
    .word 0x78BE42, 0, 0, 0x78BE42, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0, 0x78BE42, 0, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42
    .word 0x78BE42, 0, 0, 0, 0, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0, 0x78BE42, 0, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0, 0
    .word 0, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0, 0, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0, 0, 0, 0x78BE42, 0 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    .word 0, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038, 0, 0 0xA4D038, 0, 0, 0, 0xA4D038, 0, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038, 0, 0xA4D038, 0xA4D038, 0xA4D038, 0xA4D038, 0
    .word 0xA4D038, 0, 0, 0, 0, 0xA4D038, 0, 0xA4D038, 0, 0, 0, 0xA4D038, 0, 0xA4D038, 0xA4D038, 0, 0, 0, 0, 0, 0xA4D038, 0, 0, 0xA4D038
    .word 0xA4D038, 0, 0, 0, 0, 0xA4D038, 0, 0xA4D038, 0xA4D038, 0, 0xA4D038, 0xA4D038, 0 0xA4D038, 0xA4D038, 0, 0, 0, 0, 0, 0xA4D038, 0, 0, 0xA4D038
    .word 0x78BE42, 0, 0, 0, 0, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0, 0 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42
    .word 0x78BE42, 0, 0, 0, 0, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0, 0, 0, 0, 0x78BE42, 0, 0x78BE42, 0
    .word 0, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0, 0, 0, 0x78BE42, 0x78BE42, 0x78BE42, 0, 0, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0x78BE42, 0, 0x78BE42, 0x78BE42, 0, 0, 0x78BE42,

# 8 by 7 sprite
RESTART_SPRITE:
    .word 0x6F2F07, 0x6F2F07, 0, 0, 0, 0, 0x6F2F07, 0x6F2F07
    .word 0x6F2F07, 0, 0xFCE207, 0xFCE207, 0xFCE207, 0, 0, 0x6F2F07
    .word 0x6F2F07, 0, 0xFCE207, 0, 0, 0xFCE207, 0, 0x6F2F07
    .word 0x6F2F07, 0, 0xF6A91B, 0xF6A91B, 0xF6A91B, 0, 0, 0x6F2F07
    .word 0x6F2F07, 0, 0xF6A91B, 0, 0xF6A91B, 0xF6A91B, 0, 0x6F2F07
    .word 0x6F2F07, 0, 0xF6A91B, 0, 0, 0xF6A91B, 0, 0x6F2F07
    .word 0x6F2F07, 0x6F2F07, 0, 0, 0, 0, 0x6F2F07, 0x6F2F07

# 3 by 4 sprite
PAUSE_SPRITE:
    .word 0x8B9FA9,  0,  0x8B9FA9
    .word 0x8B9FA9,  0,  0x8B9FA9
    .word 0x8B9FA9,  0,  0x8B9FA9
    .word 0x8B9FA9,  0,  0x8B9FA9

# 3 by 4 sprite
RESUME_SPRITE:
    .word 0, 0, 0
    .word 0, 0, 0
    .word 0, 0, 0
    .word 0, 0, 0

# 9 by 14 sprite
DR_MARIO_SPRITE: 
    .word 0, 0, 0x8C8C8C, 0, 0, 0, 0, 0, 0
    .word 0, 0x8C8C8C, 0x8C8C8C, 0, 0xA3A3A3, 0x944F05, 0x944F05, 0x944F05, 0
    .word 0, 0x706B6B, 0x706B6B, 0, 0xA3A3A3, 0x2288EC, 0x2288EC, 0x2288EC, 0x2288EC
    .word 0, 0xFFFFFF, 0xFFFFFF, 0xFFB56C, 0x4A86E8, 0xFFB56C, 0x944F05, 0x944F05, 0x944F05
    .word 0, 0xFFB56C, 0xFFB56C, 0xFFB56C, 0x0000FF, 0xFFB56C, 0x944F05, 0xFFB56C, 0x944F05
    .word 0xFFB56C, 0xFFB56C, 0xFFB56C, 0x944F05, 0xFFB56C, 0x944F05, 0x944F05, 0xFFB56C, 0x944F05
    .word 0, 0x944F05, 0x944F05, 0x944F05, 0x944F05, 0xFFB56C, 0xFFB56C, 0x944F05, 0x944F05
    .word 0, 0, 0xFFB56C, 0xFFB56C, 0xFFB56C, 0xFFB56C, 0xFFB56C, 0xFFB56C, 0
    .word 0, 0, 0xFFFFFF, 0xFF0000, 0xFF0000, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF
    .word 0, 0, 0xFFFFFF, 0xFFFFFF, 0xFF0000, 0xFFFFFF, 0x706B6B, 0x706B6B, 0x706B6B
    .word 0, 0, 0xFFFFFF, 0xFFFFFF,  0xFFFFFF,  0xFFFFFF,  0xFFFFFF, 0x8C8C8C, 0x8C8C8C
    .word 0, 0, 0x1067C6, 0x1067C6, 0, 0x1067C6, 0x1067C6, 0, 0,
    .word 0, 0x995E00, 0x995E00, 0, 0, 0, 0x995E00, 0x995E00, 0
    .word 0x995E00, 0x995E00, 0x995E00, 0, 0, 0, 0x995E00, 0x995E00, 0x995E00

# 7 by 7 sprite
RED_VIRUS:
    .word 0x000000, 0xFF0000, 0xFF0000, 0xFF0000, 0xFF0000, 0xFF0000, 0x000000
    .word 0xFF0000, 0x000000, 0xFFFF00, 0x000000, 0xFFFF00, 0x000000, 0xFF0000
    .word 0xFF0000, 0x000000, 0x000000, 0xFF0000, 0x000000, 0x000000, 0xFF0000
    .word 0xFF0000, 0xFF0000, 0xFF0000, 0x000000, 0xFF0000, 0xFF0000, 0xFF0000
    .word 0xFF0000, 0x000000, 0xFFFF00, 0x000000, 0xFFFF00, 0x000000, 0xFF0000
    .word 0x000000, 0xFF0000, 0xFF0000, 0xFF0000, 0xFF0000, 0xFF0000, 0x000000
    .word 0xFFFF00, 0xFFFF00, 0x000000, 0x000000, 0x000000, 0xFFFF00, 0xFFFF00

# 7 by 7 sprite
BLUE_VIRUS:
    .word 0x000000, 0x2B6CF3, 0x2B6CF3, 0x000000, 0x2B6CF3, 0x2B6CF3, 0x000000
    .word 0x2B6CF3, 0x000000, 0x000000, 0x2B6CF3, 0x000000, 0x000000, 0x2B6CF3
    .word 0x000000, 0x2B6CF3, 0xFFFF00, 0x2B6CF3, 0xFFFF00, 0x2B6CF3, 0x000000
    .word 0x2B6CF3, 0x2B6CF3, 0x2B6CF3, 0x2B6CF3, 0x2B6CF3, 0x2B6CF3, 0x2B6CF3
    .word 0x2B6CF3, 0x000000, 0x000000, 0xFFFF00, 0x000000, 0x000000, 0x2B6CF3
    .word 0x000000, 0x2B6CF3, 0x2B6CF3, 0x2B6CF3, 0x2B6CF3, 0x2B6CF3, 0x000000
    .word 0xFFFF00, 0xFFFF00, 0x000000, 0x000000, 0x000000, 0xFFFF00, 0xFFFF00

# 7 by 7 sprite
YELLOW_VIRUS:
    .word 0xFFFF00, 0x000000, 0x2B6CF3, 0x000000, 0x2B6CF3, 0x000000, 0xFFFF00
    .word 0x000000, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0x000000
    .word 0xFFFF00, 0x000000, 0x2B6CF3, 0x000000, 0x2B6CF3, 0x000000, 0xFFFF00
    .word 0xFFFF00, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0xFFFF00
    .word 0xFFFF00, 0xFFFF00, 0x000000, 0x000000, 0x000000, 0xFFFF00, 0xFFFF00
    .word 0x000000, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0xFFFF00, 0x000000
    .word 0x2B6CF3, 0x2B6CF3, 0x000000, 0x000000, 0x000000, 0x2B6CF3, 0x2B6CF3


INSTRUMENT:     .word 1

NOTES: 			.half   63, 64, 63, 64, 62, 60, 60, 62, 63, 64, 62, 60, 60, 0,
63, 64, 63, 64, 62, 60, 60, 62, 44, 44, 44, 46, 46, 46, 47, 47, 47, 48, 48, 48
63, 64, 63, 64, 62, 60, 60, 62, 63, 64, 62, 60, 60, 0,
63, 64, 63, 64, 62, 60, 60, 62,
92, 88, 85, 81, 77, 74, 70, 66, 63, 59, 55, 52, 48, 44, 41, 37


DURATIONS: 		.half   176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 352, 352, 
                        176, 176, 176, 176, 176, 176, 176, 176, 88, 88, 176, 88, 88, 176, 88, 88, 176, 88, 88, 176,
                        176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 352, 352,
                        176, 176, 176, 176, 176, 176, 176, 176,
                        88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88


VOLUMES:		.half 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0,
                      20, 20, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30
                      20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0,
                      20, 20, 20, 20, 20, 20, 20, 20, 
                      20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20

MUSIC_DELAY: .word  8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 13, 
                    8, 8, 8, 8, 8, 8, 8, 8, 4, 4, 8, 4, 4, 8, 4, 4, 8, 4, 4, 8, 
                    8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 14, 
                    8, 8, 8, 8, 8, 8, 8, 8, 
                    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3

##############################################################################
# Mutable Data
##############################################################################
CAPSULE_X1: .word 0
CAPSULE_Y1: .word 0
CAPSULE_X2: .word 0
CAPSULE_Y2: .word 0
PILL_ROTATION: .word 0
CAPSULE_COLOUR_1: .word 0x000000
CAPSULE_COLOUR_2: .word 0x000000

NEXT_CAPSULE_COLOUR_1: .word 0x000009
NEXT_CAPSULE_COLOUR_2: .word 0x000000

GRAVITY_COUNTER: .word 0
GRAVITY_SPEED: .word 50    # (The lower the faster) 

NOTE_NUM: .word 0
MUSIC_SPEED: .word 0

    
##############################################################################
# Code
##############################################################################
	.text
	.globl main

# Macro for playing the music
.macro make_note (%note, %DURATIONS, %VOLUMES)
    li $v0, 31                # Syscall for playing a midi sound
    move $a0, %note           # Note 0 ~ 127
    move $a1, %DURATIONS      # Durations in milliseconds
    lw $a2, INSTRUMENT        # Instrument, # 1 is acoustic piano
    move $a3, %VOLUMES        # Volume
    syscall
.end_macro

# Saved colours
li $s1, 0xe03c31    # $s1 = red
li $s2, 0xfbec5d 	# $s2 = yellow
li $s3, 0x318ce7 	# $s3 = blue
# grey = 0x858585 

    
# Initialize the game
main:
    # Draw everything!
    li $s0, 0
    jal reset_bitmap_display        # Reset the display
	jal draw_bottle                 # Draw bottle
	jal draw_pills                  # Draw the pills
	jal draw_viruses                # Draw the viruses inside the bottle
    jal draw_dr_mario               # Draw Dr.Mario and the viruses

    # reset gravity counter
    la $t0, GRAVITY_COUNTER
    li $t1, 0
    sw $t1, 0($t0)

    # reset gravity speed
    la $t0, GRAVITY_SPEED
    li $t1, 55
    sw $t1, 0($t0)       # Store the new speed

    # Reset note number
    la $t0, NOTE_NUM
    li $t1, 0
    sw $t1, 0($t0)
    
    # Reset music counter
    la $t0, MUSIC_SPEED
    li $t1, 0
    sw $t1, 0($t0)
    
# Run the game.
game_loop:
    # 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
	# 2a. Check for collisions - (done by helper functions in keyboard_input)
	# 2b. Update locations (capsules) - (done by helper functions in keyboard_input)
    jal key_check
    
	# 3. Draw the screen (we don't draw the scene, we redraw the pill in its new position)
    
	# 4. Sleep
	jal sleep

    # 5. Apply gravity every 1 second
    jal gravity 

    # 6. Play the next note if ready
    jal play_music
 
    # 7. Go back to Step 1
    j game_loop


##############################################################################
# Feature Functions
##############################################################################
#------------------------------------------------------------
# Play the Dr. Mario’s theme music in the background while playing the game.
play_music:
     # Increment music counter
     la $t0, MUSIC_SPEED
     lw $t1, MUSIC_SPEED
     addi $t1, $t1, 1
     sw $t1, 0($t0)
     
     la $t7, NOTES
     la $t6, DURATIONS
     sub $t7, $t6, $t7      # Address difference between notes & duration (Tells how many elements are in duration)
     srl $t7, $t7, 1        # Since we are working with half, divide this num by 2 for the # of elements
      
     li $t5, 0              # Loop counter for notes

     la $t4, MUSIC_DELAY    # MUSIC_DELAY: the number of iterations inside game_loop to play a note
     lw $t5, NOTE_NUM       # NOTE_NUM: next note to play
     sll $t5, $t5, 2        # Multiply by 4 (each memory location is 4 bytes)
     add $t4, $t4, $t5
     lw $t4, 0($t4)         # Load corresponding MUSIC_DELAY into $t4
     
     beq $t1, $t4, play_note   # play every MUSIC_DELAY iterations
     j end_play_music
     
     play_note:
        lw $t5, NOTE_NUM
        sll $t8, $t5, 1        # Retrieve corresponding byte using the loop counter by multiplying 2
        
        lh $t1, NOTES($t8)
        lh $t2, DURATIONS($t8)
        lh $t3, VOLUMES($t8)
        
        make_note ($t1, $t2, $t3)         # Create and play the note inside the macro
        
        addi $t5, $t5, 1
        la $t0, NOTE_NUM                  # Store address of NOTE_NUM
        sw $t5, 0($t0)                    # Update the value of NOTE_NUM
        
        beq $t5, $t7, initialize_music    # Continue playing until the loop counter = # of elements
        
        # Reset music counter
        la $t0, MUSIC_SPEED
        li $t1, 0
        sw $t1, 0($t0)
        
        j end_play_music
        
        initialize_music:
            # Reset note number
            la $t0, NOTE_NUM
            li $t1, 0
            sw $t1, 0($t0)
            
            # Reset music counter
            la $t0, MUSIC_SPEED
            li $t1, 0
            sw $t1, 0($t0)
        
end_play_music:
    jr $ra 

#------------------------------------------------------------
# Apply gravity, so that each second that passes will automatically move the capsule down one row.
gravity:
    addi $sp, $sp, -4                   # Move the stack pointer to an empty location.
    sw $ra, 0($sp)                      # Store $ra on the stack for safe keeping.

    # Increment gravity counter
    lw $t1, GRAVITY_COUNTER
    la $t0, GRAVITY_COUNTER
    addi $t1, $t1, 1  
    sw $t1, 0($t0)
    
    # Only apply gravity once every GRAVITY_SPEED loops
    lw $t2, GRAVITY_SPEED
    bne $t1, $t2, end_gravity
    
    # Move block down and reset gravity counter
    li $t1, 0
    sw $t1, 0($t0)      # reset gravity counter back to 0
    jal respond_to_S    # move block downward

    # Decrease GRAVITY_SPEED to speed up falling 
    lw $t2, GRAVITY_SPEED
    ble $t2, 8, end_increase_speed  # Don't decrease if it is at 8 already
    
    la $t0, GRAVITY_SPEED
    addi $t2, $t2, -2    # Reduce GRAVITY_SPEED (which increases gravity)
    sw $t2, 0($t0)       # Store the new speed
    
    end_increase_speed:
        
end_gravity:
    lw $ra, 0($sp)          	# Restore $ra from the stack.
    addi $sp, $sp, 4       		# Move the stack pointer to the current top of the stack.
    jr $ra    

#------------------------------------------------------------
# Draw dr.mario and the viruses as pixel art beside the bottle
draw_dr_mario: 
    addi $sp, $sp, -4                   # Move the stack pointer to an empty location.
    sw $ra, 0($sp)                      # Store $ra on the stack for safe keeping.

    # Draw dr.mario
    li $a0, 9                    # - a0: the width of the sprite
    li $a1, 14                   # - a1: the height of the sprite
    li $a2, 22                   # - a2: the x-offset of where to start drawing the sprite from
    li $a3, 14                   # - a3: the Y-offset of where to start drawing the sprite from
    la $s4, DR_MARIO_SPRITE      # - s4: the address of the sprite space
    jal draw_sprite

    # Draw red virus
    li $a0, 7                    # - a0: the width of the sprite
    li $a1, 7                    # - a1: the height of the sprite
    li $a2, 1                    # - a2: the x-offset of where to start drawing the sprite from
    li $a3, 6                    # - a3: the Y-offset of where to start drawing the sprite from
    la $s4, RED_VIRUS            # - s4: the address of the sprite space
    jal draw_sprite

    # Draw blue virus
    li $a0, 7                    # - a0: the width of the sprite
    li $a1, 7                    # - a1: the height of the sprite
    li $a2, 1                    # - a2: the x-offset of where to start drawing the sprite from
    li $a3, 15                    # - a3: the Y-offset of where to start drawing the sprite from
    la $s4, BLUE_VIRUS            # - s4: the address of the sprite space
    jal draw_sprite

    # Draw yellow virus
    li $a0, 7                    # - a0: the width of the sprite
    li $a1, 7                    # - a1: the height of the sprite
    li $a2, 1                    # - a2: the x-offset of where to start drawing the sprite from
    li $a3, 24                    # - a3: the Y-offset of where to start drawing the sprite from
    la $s4, YELLOW_VIRUS            # - s4: the address of the sprite space
    jal draw_sprite

    lw $ra, 0($sp)          	# Restore $ra from the stack.
    addi $sp, $sp, 4       		# move the stack pointer to the current top of the stack.
    jr $ra 


##############################################################################
# Drawing Functions
##############################################################################
#------------------------------------------------------------
# Draw the game scene (the medicine bottle)
draw_bottle:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.
	
	lw $t6, BOTTLE_X_OFFSET			# load x-offset
	lw $t7, BOTTLE_Y_OFFSET			# load y-offset
	lw $t8, BOTTLE_WIDTH			# load width of the bottle
	lw $t9, BOTTLE_HEIGHT			# load height of the bottle
	li $a3, 0x858585  				# set colour to grey

	# draw the top of the bottle
	add $a0, $t6, $zero	
	add $a1, $t7, $zero
	add $a2, $t8, $zero	
	jal draw_horizontal
	
	# draw the bottom of the bottle
	add $a0, $t6, $zero	
	add $a1, $t7, $zero
	add $a1, $a1, $t9		# move y offset by height
	add $a2, $t8, $zero		
	addi $a1, $a1, -1
	jal draw_horizontal

	# draw the left side of the bottle
	add $a0, $t6, $zero
	add $a1, $t7, $zero
	add $a2, $t9, $zero
	jal draw_vertical

	# draw the right side of the bottle
	add $a0, $t6, $zero
	add $a1, $t7, $zero
	add $a0, $a0, $t8 		# move x offset by width
	add $a2, $t9, $zero
	addi $a0, $a0, -1
	jal draw_vertical

	# draw the top of the bottle
	add $a0, $t6, $zero	
	add $a1, $t7, $zero
	add $a2, $t8, $zero	
	jal draw_horizontal

	# draw the left opening 
	add $a0, $t6, $zero	
	add $a1, $t7, $zero 
    
    # calculate x position
	sra $t5, $t8, 1 	# divide x-offset by 2 and store in t5
	add $a0, $a0, $t5
	addi $a0, $a0, -2
    # calculate y position
    addi $a1, $a1, -2
    
    li $a2, 2
    jal draw_vertical

    # draw the right opening 
	add $a0, $t6, $zero	
	add $a1, $t7, $zero 
    
    # calculate x position
	sra $t5, $t8, 1 	# divide x-offset by 2 and store in t5
	add $a0, $a0, $t5
    addi $a0, $a0, 1
    # calculate y position
    addi $a1, $a1, -2
    
    li $a2, 2
    jal draw_vertical

	# make the hole in the top of the bottle
	add $a3, $zero, $zero  # set colour to black
	add $a0, $t6, $zero
	add $a1, $t7, $zero
    
    # calculate x position
	sra $t5, $t8, 1 	# divide x-offset by 2 and store in t5
	add $a0, $a0, $t5
	addi $a0, $a0, -1
	li $a2, 2
	jal draw_horizontal

	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.
    jr $ra
end_draw_scene:

# -----------------------------------------------------------
# Reset the screen by colouring every pixel black. 
reset_bitmap_display:
    addi $sp, $sp, -4               # Move the stack pointer to an empty location.
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.
    li $t2, 0                       # The loop variable
    
    reset_bitmap_display_loop:
        li $a0, 0                   # a0: X coordinate of the start of the line
        move $a1, $t2               # a1: Y coordinate of the start of the line
        li $a2, 32                  # a2: Length of the line
        li $a3, 0                   # a3: Colour of the line (black)
        jal draw_horizontal
        
        addi, $t2, $t2, 1           # increment the loop variable
        beq $t2, 31, end_reset_bitmap_display
        j reset_bitmap_display_loop

end_reset_bitmap_display:
    lw $ra, 0($sp)          	# Restore $ra from the stack.
    addi $sp, $sp, 4       		# move the stack pointer to the current top of the stack.
    jr $ra 

#------------------------------------------------------------
# Draw two new pills, one at the opening, and one to the right of the bottle with random colours
draw_pills:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	# randomly set the current pills colour
	la $a0, CAPSULE_COLOUR_1
	la $a1, CAPSULE_COLOUR_2
	jal set_colour

	# randomly set the next pills colour
	la $a0, NEXT_CAPSULE_COLOUR_1
	la $a1, NEXT_CAPSULE_COLOUR_2
	jal set_colour
	
	jal draw_current_pill			# draw the pill thats inside the bottle
	jal draw_next_pill				# draw the pill thats outside the bottle
	
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.
    jr $ra
end_draw_pill:
	
#------------------------------------------------------------
# Draw viruses of random colour in the lower half of the playing field 
# - a0: The number of viruses to draw
draw_viruses:	
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping. 

	lw $t6, NUM_VIRUSES				# $t6 = number of viruses to draw 
	add $t5, $zero, $zero 			# Loop variable: $t5 = 0
	
	draw_virus_loop:
    	# Calculate X lower bound 
    	lw $t1, BOTTLE_X_OFFSET
    	addi $t1, $t1, 1				# X lower bound = X offset + 1
    	
    	# Generate a random number from 0 to (bottle width - 3)
    	lw $t2, BOTTLE_WIDTH
    	addi $t2, $t2, -3               # Ensure we stay within width
    	add $a0, $t2, $zero
    	jal random_value
    	
    	# Calculate X-coordinate (random number + x lower bound)
    	add $t3, $v0, $t1				# Correctly add lower bound
    	sll $t3, $t3, 2					# Store X position in $t3
	
		# Calculate Y lower bound
		lw $t1, BOTTLE_Y_OFFSET
		lw $t2, BOTTLE_HEIGHT
		sra $t2, $t2, 1 			# divide the height by 2
		add $t1, $t1, $t2 			# Y lower bound = Y offset + half of bottle height 
	
		# Generate a random number from 0 to half the bottle height - 1
		lw $t2, BOTTLE_HEIGHT
		sra $t2, $t2, 1 			# divide the height by 2
		addi $t2, $t2, -1
		add $a0, $t2, $zero
		jal random_value
	
		# Calculate Y-coordinate (random number + Y lower bound)
		add $t4, $v0, $t1
		sll $t4, $t4, 7				# Store Y position in $t4
	
		# Calculate the position of the virus 
		lw $t0, ADDR_DSPL
		add $t0, $t0, $t3			# Add X-coord
		add $t0, $t0, $t4			# Add Y-coord
        
		lw $t8, 0($t0)
		bne $t8, $zero, draw_virus_loop
		
		# Random generator to determine the colour of a virus
		li $v0, 42
		li $a0, 0
		li $a1, 3
		
		syscall
		move $t1, $a0
		
		# Check if red, blue, or yellow: 
		beq $t1, 0, red_virus
		beq $t1, 1, yellow_virus
        beq $t1, 2, blue_virus
	
		red_virus:
            addi $t9, $s1, -1
			sw $t9, 0($t0)
		    j end_virus
		
		yellow_virus:
            addi $t9, $s2, -1
			sw $t9, 0($t0)
		    j end_virus
		
		blue_virus:
            addi $t9 $s3, -1
			sw $t9, 0($t0)
	
		end_virus:

	addi $t5, $t5, 1				# Increment loop variable 
	beq $t5, $t6, end_draw_virus	# Done drawing viruses (loop variable = # of viruses)
	j draw_virus_loop				# Reiterate otherwise (need to draw more viruses)

	end_draw_virus:		
		lw $ra, 0($sp)          	# Restore $ra from the stack.
		addi $sp, $sp, 4       		# move the stack pointer to the current top of the stack.
	    jr $ra

# ------------------------------------------------------------
# Draw a sprite (2D image) onto the screen by copying pixel data from the given sprite space into the display memory. 
# - a0: the width of the sprite
# - a1: the height of the sprite
# - a2: the x-offset of where to start drawing the sprite from
# - a3: the y-offset of where to start drawing the sprite from
# - s4: the address of the sprite space
draw_sprite:
    addi $sp, $sp, -4               # Move the stack pointer to an empty location.
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.
    
    li $t1, 0                       # The x position (inner loop variable) 
    li $t2, -1                      # The y position (outer loop variable)
    
    draw_sprite_outer:
        li $t1, 0                           # Reset the row position (inner loop variable) 
        addi $t2, $t2, 1                    # move to down the next row (incerement outer loop var)
        beq $t2, $a1, end_draw_sprite_outer
        
        

        draw_sprite_inner:
            # Calculate the address of the current pixel to draw in display memory
            lw $t0, ADDR_DSPL
            add $t3, $t1, $a2
            add $t4, $t2, $a3
            sll $t3, $t3, 2                  # Multiply column index by 4 (word size)
            sll $t4, $t4, 7                  # Multiply row index by 128 (for memory addressing)
            add $t0, $t0, $t3                # Add column offset to display memory address
            add $t0, $t0, $t4                # Add row offset to display memory address

            
            # Load the colour of the current pixel from the sprite space
            move $t9, $s4                    # Load the address of the sprite space
            mul $t8, $t2, $a0                # Calculate the row offset (row * width)
            add $t8, $t8, $t1                # Add the column index to get the total offset
            sll $t8, $t8, 2                  # Multiply the total offset by 4 to get the byte offset
            add $t9, $t9, $t8                # Add the byte offset to the sprite space address
            lw $t8, 0($t9)                   # Load the pixel color from sprite space

            # Store the color into the display memory
            sw $t8, 0($t0)
            

            addi $t1, $t1, 1        # move to the right (incerement inner loop var)
            beq $t1, $a0, draw_sprite_outer
            j draw_sprite_inner 

        end_draw_sprite_inner:


    end_draw_sprite_outer:
        lw $ra, 0($sp)          	# Restore $ra from the stack.
    	addi $sp, $sp, 4       		# move the stack pointer to the current top of the stack.
        jr $ra 

#------------------------------------------------------------
# Load random colours into the given memory locations
# - a0: memory address of the first location to set
# - a1: memory address of the second location to set
set_colour:
	# store given memory locations in $t3, and $t4
	add $t3, $a0, $zero
	add $t4, $a1, $zero
	
	# Random generator to determine colours of pill
	li $v0, 42
	li $a0, 0
	li $a1, 3
	
	syscall
	move $t1, $a0
	
	# Check_first: 
	beq $t1, 0, first_red
	beq $t1, 1, first_blue
	beq $t1, 2, first_yellow

	first_red:
		sw $s1, 0($t3)
	    j end_first
	
	first_blue:
		sw $s2, 0($t3)
	    j end_first
	
	first_yellow:
		sw $s3, 0($t3)

	end_first:

	li $a0, 0
	syscall
	move $t2, $a0
	
	# Check_second
	beq $t2, 0, second_red
	beq $t2, 1, second_blue
	beq $t2, 2, second_yellow
		
	second_red:
		sw $s1, 0($t4)
	    j end_second
	
	second_blue:
		sw $s2, 0($t4)
	    j end_second
	
	second_yellow:
		sw $s3, 0($t4)
		j end_second
		
	end_second:

	jr $ra
end_set_colour:

#------------------------------------------------------------
# Draw the current pill (the one that is inside the bottle) and reset the X and Y coordinate of the current pill
draw_current_pill:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	# Set the pill rotation to 0
	la $t0, PILL_ROTATION
	sw $zero, 0($t0)
	
	lw $t1, BOTTLE_WIDTH 	# t1 = bottle width 
	lw $t2, BOTTLE_X_OFFSET # t2 = bottle x offset
	
	# calculate X-position of left half and store it in CAPSULE_X1
	sra $t1, $t1, 1
	add $t1, $t1, $t2
	addi $t1, $t1, -1
	la $t3, CAPSULE_X1
	sw $t1, 0($t3)

	# calculate X-position of right half and store it in CAPSULE_X2
	addi $t1, $t1, 1
	la $t3, CAPSULE_X2
	sw $t1, 0($t3)

	lw $t1, BOTTLE_Y_OFFSET # t1 = bottle y offset
	# calculate Y-position of both halves and store it in CAPSULE_Y1 and CAPSULE_Y2
	addi $t1, $t1, 1
	la $t2, CAPSULE_Y1
	la $t3, CAPSULE_Y2
	sw $t1, 0($t2)
	sw $t1, 0($t3)

	# Check if new pill has collision
	# If so, game over!
	lw $t1 CAPSULE_X1
	lw $t2 CAPSULE_Y1

	lw $t0, ADDR_DSPL	# Load display address
	sll $t1, $t1, 2 	# Calculate X-coordinate
    sll $t2, $t2, 7		# Calculate Y-coordinate
	add $t0, $t0, $t1
	add $t0, $t0, $t2
	lw $t3, 0($t0)

	bne $t3, $zero, game_over 	# If the spot is not empty (not black), jump to game over

	# Colour the left half in the correct position and colour
	lw $t0, ADDR_DSPL
	lw $t1, CAPSULE_X1
	lw $t2, CAPSULE_Y1
	lw $t5, CAPSULE_COLOUR_1
	sll $t1, $t1, 2
	sll $t2, $t2, 7
	add $t0, $t0, $t1
	add $t0, $t0, $t2
	sw $t5, 0($t0)

	# Colour the right half in the correct position and colour
	lw $t0, ADDR_DSPL
	lw $t3, CAPSULE_X2
	lw $t4, CAPSULE_Y2
	lw $t6, CAPSULE_COLOUR_2
	sll $t3, $t3, 2
	sll $t4, $t4, 7
	add $t0, $t0, $t3
	add $t0, $t0, $t4
	sw $t6, 0($t0)

	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.
    jr $ra
end_draw_current_pill:

#------------------------------------------------------------
# Draw the next pill (the one that is outside the bottle) to show the colours of the next pill that will be played
draw_next_pill:

	# X coordinate caclualtions
	lw $t1, BOTTLE_WIDTH 	# t1 = bottle width 
	lw $t2, BOTTLE_X_OFFSET # t2 = bottle x offset
	# calculate X-position of the capsule and store it in $t3
	add $t3, $t2, $t1
	addi $t3, $t3, 2

	
	# Y coordinate caclualtions
	lw $t1, BOTTLE_Y_OFFSET # t1 = bottle y offset
	# calculate the Y-position of the top half and it in #t4
	addi $t4, $t1, -1

	# Colour the capsule in the correct position and colour
	lw $t0, ADDR_DSPL
	lw $t5, NEXT_CAPSULE_COLOUR_1
	lw $t6, NEXT_CAPSULE_COLOUR_2
	sll $t3, $t3, 2
	sll $t4, $t4, 7
	add $t0, $t0, $t3
	add $t0, $t0, $t4
	sw $t5, 0($t0)
	sw $t6, 128($t0)

	jr $ra
end_draw_next_pill: 

#------------------------------------------------------------
# Draw a horizontal line
# - a0: X coordinate of the start of the line
# - a1: Y coordinate of the start of the line
# - a2: Length of the line
# - a3: Colour of the line
draw_horizontal:	
	lw $t0, ADDR_DSPL		#store base address for display
	sll $a0, $a0, 2 		# calculate x-offset
	sll $a1, $a1, 7 		# calculate y-offset
	add $t0, $t0, $a0		# add the x-offsets to the starting location of the draw
	add $t0, $t0, $a1		# add the x-offsets to the starting location of the draw
	li $t1, 0				# loop variable
	
	draw_horizontal_loop:
		sw $a3, 0($t0)							# draw a pixel at the offset
		addi $t0, $t0, 4      					# move to the next column.
		addi $t1, $t1, 1						# increment the loop variable
		beq $t1, $a2 end_draw_horizontal_loop 	# branch when loop variable == length of line
		j draw_horizontal_loop
	end_draw_horizontal_loop:
		
	jr $ra			# return to caller
end_draw_horizontal:

#------------------------------------------------------------
# Draw a vertical line
# - a0: X coordinate of the start of the line
# - a1: Y coordinate of the start of the line
# - a2: Length of the line
# - a3: Colour of the line
draw_vertical:	
	lw $t0, ADDR_DSPL		#store base address for display
	sll $a0, $a0, 2 		# calculate x-offset
	sll $a1, $a1, 7 		# calculate y-offset
	add $t0, $t0, $a0		# add the x-offsets to the starting location of the draw
	add $t0, $t0, $a1		# add the x-offsets to the starting location of the draw
	li $t1, 0				# loop variable
	
	draw_vertical_loop:
		sw $a3, 0($t0)							# draw a pixel at the offset
		addi $t0, $t0, 128      				# move to the next pixel in the row.
		addi $t1, $t1, 1						# increment the loop variable
		beq $t1, $a2 end_draw_vertical_loop 	# branch when loop variable == length of line
		j draw_vertical_loop					
	end_draw_vertical_loop:
		
	jr $ra			# return to caller
end_draw_vertical:



##############################################################################
# Keyboard Input Handling Functions
##############################################################################
#------------------------------------------------------------
# Check if a key has been pressed and call keyboard_input to respond to it
key_check:
    addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.
    
    lw $t0, ADDR_KBRD               # Load keyboard base address
    lw $t8, 0($t0)                  # Check if a key is pressed

    beq $t8, $zero, end_key_check   # If no key, return immediately

    lw $a0, 4($t0)                  # Load key ASCII value if a key was pressed
    jal keyboard_input              # Handle key press

end_key_check:
    lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.
	jr $ra

keyboard_input:                     # A key is pressed
	lw $t0, ADDR_KBRD
    lw $a0, 4($t0)                  # Load second word from keyboard
    beq $a0, 0x71, respond_to_Q     # Check if the key q was pressed
    beq $a0, 0x70, respond_to_P     # Check if the key p was pressed
    beq $a0, 0x77, respond_to_W     # Check if the key w was pressed
    beq $a0, 0x61, respond_to_A     # Check if the key a was pressed
    beq $a0, 0x73, respond_to_S     # Check if the key s was pressed
    beq $a0, 0x64, respond_to_D     # Check if the key d was pressed
    
    jr $ra 

#------------------------------------------------------------
# Paused the game
respond_to_P:
    addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.
    
    # Draw pause symbol
    li $a0, 3                    # - a0: the width of the sprite
    li $a1, 4                    # - a1: the height of the sprite
    li $a2, 2                     # - a2: the x-offset of where to start drawing the sprite from
    li $a3, 1                     # - a3: the Y-offset of where to start drawing the sprite from
    la $s4, PAUSE_SPRITE      # - s4: the address of the sprite space
    jal draw_sprite
    
    pause_loop:        
        lw $t0, ADDR_KBRD                # Load keyboard base address
        lw $t8, 0($t0)                   # Check if a key is pressed
        beq $t8, 0, pause_loop           # Wait until a key is pressed
        
        lw $a0, 4($t0)                   # Load the key value
        beq $a0, 0x70, end_respond_to_P  # If p was pressed, unpause the game
        j pause_loop                     # If it's not p, keep waiting
        
end_respond_to_P:
        # Erase pause symbol
        li $a0, 3                    # - a0: the width of the sprite
        li $a1, 4                    # - a1: the height of the sprite
        li $a2, 2                    # - a2: the x-offset of where to start drawing the sprite from
        li $a3, 1                    # - a3: the Y-offset of where to start drawing the sprite from
        la $s4, RESUME_SPRITE      # - s4: the address of the sprite space
        jal draw_sprite
    
        lw $t0, ADDR_KBRD  
        lw $t8, 0($t0)  

        lw $ra, 0($sp)                   # Restore $ra from the stack.
	    addi $sp, $sp, 4                 # move the stack pointer to the current top of the stack.
        jr $ra                           # Return after unpausing
    


#------------------------------------------------------------
# Quit gracefully.
respond_to_Q:
	j quit

#------------------------------------------------------------
# Draw the game over screen and wait until the play quits (q)
# Or restarts the game (r)
game_over:
    jal reset_bitmap_display        # Reset the display

    # Draw game over screen
    li $a0, 24                    # - a0: the width of the sprite
    li $a1, 14                    # - a1: the height of the sprite
    li $a2, 4                     # - a2: the x-offset of where to start drawing the sprite from
    li $a3, 5                     # - a3: the Y-offset of where to start drawing the sprite from
    la $s4, GAME_OVER_SPRITE      # - s4: the address of the sprite space
    jal draw_sprite

    # Draw game over screen
    li $a0, 8                    # - a0: the width of the sprite
    li $a1, 7                    # - a1: the height of the sprite
    li $a2, 12                   # - a2: the x-offset of where to start drawing the sprite from
    li $a3, 22                   # - a3: the Y-offset of where to start drawing the sprite from
    la $s4, RESTART_SPRITE       # - s4: the address of the sprite space
    jal draw_sprite
    
    game_over_loop:
        lw $t0, ADDR_KBRD               # Load keyboard base address
        lw $t8, 0($t0)                  # Check if a key is pressed
        
        beq $t8, 0, game_over_loop      # Wait until key is pressed
    
        # Check if a valid key has been pressed (q or r)
        lw $a0, 4($t0)                  # Load second word from key
        beq $a0, 0x71, respond_to_Q     # Check if the key q was pressed
        beq $a0, 0x72, respond_to_R     # Check if the key r was pressed
        j game_over_loop                # Otherwise, wait for another key

     respond_to_R:
         j main
         

#------------------------------------------------------------
# Handle clockwise rotations
respond_to_W:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	jal check_collision_W			# Check the rotation won't cause a collision 
	
	lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
	lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
	lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

	lw $t5, CAPSULE_COLOUR_1		# load capsule colour of first half
	lw $t6, CAPSULE_COLOUR_2		# load capsule colour of second half
	lw $t9, ADDR_DSPL				# t9 = display address

	# rotation logic
	beq $t0, $zero, rotate_0
	beq $t0, 1, rotate_1
	beq $t0, 2, rotate_2
	beq $t0, 3, rotate_3
		
	rotate_0:
		# calculate the x and y offset of second half to delete
		sll $t7, $t3, 2				
		sll $t8, $t4, 7
		# calculated the correct address to delete
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $zero, 0($t9) 			# colour the address black

		# calculate the new x and y offset of second half to paint
		addi $t3, $t3, -1
		addi $t4, $t4, 1
		la $t7, CAPSULE_X2
		la $t8, CAPSULE_Y2
		sw $t3, 0($t7)				# update the X coord of second half
		sw $t4, 0($t8)				# update the Y coord of second half
		sll $t7, $t3, 2				
		sll $t8, $t4, 7
		
		# calculated the correct address to paint
		lw 	$t9, ADDR_DSPL
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $t6, 0($t9) 				# colour the address appropriately (with colour 2)
		j end_respond_to_W    

	rotate_1:
		# calculate the x and y offset of second half to delete
		sll $t7, $t3, 2				
		sll $t8, $t4, 7
		# calculated the correct address to delete
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $zero, 0($t9) 			# colour the address black

		# calculate the new x and y offset of first half to paint
		addi $t1, $t1, 1
		la $t7, CAPSULE_X1
		la $t8, CAPSULE_Y1
		sw $t1, 0($t7)				# update the X coord of first half
		sw $t2, 0($t8)				# update the Y coord of first half
		sll $t7, $t1, 2				
		sll $t8, $t2, 7
		
		# calculated the correct address to paint
		lw 	$t9, ADDR_DSPL
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $t5, 0($t9) 			# colour the address appropriately (with colour 1)

		# calculate the new x and y offset of second half to paint
		addi $t4, $t4, -1
		la $t7, CAPSULE_X2
		la $t8, CAPSULE_Y2
		sw $t3, 0($t7)				# update the X coord of second half
		sw $t4, 0($t8)				# update the Y coord of second half
		sll $t7, $t3, 2				
		sll $t8, $t4, 7
		
		# calculated the correct address to paint
		lw 	$t9, ADDR_DSPL
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $t6, 0($t9) 			# colour the address appropriately (with colour 2)

		j end_respond_to_W      

	rotate_2:
		# calculate the x and y offset of second half to delete
		sll $t7, $t1, 2				
		sll $t8, $t2, 7
		# calculated the correct address to delete
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $zero, 0($t9) 			# colour the address black

		# calculate the new x and y offset of first half to paint
		addi $t1, $t1, -1
		addi $t2, $t2, 1
		la $t7, CAPSULE_X1
		la $t8, CAPSULE_Y1
		sw $t1, 0($t7)				# update the X coord of first half
		sw $t2, 0($t8)				# update the Y coord of first half
		sll $t7, $t1, 2				
		sll $t8, $t2, 7
		
		# calculated the correct address to paint
		lw 	$t9, ADDR_DSPL
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $t5, 0($t9) 			# colour the address appropriately (with colour 1)
		j end_respond_to_W

	rotate_3:
        # calculate the x and y offset of first half to delete
		sll $t7, $t1, 2				
		sll $t8, $t2, 7
		# calculated the correct address to delete
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $zero, 0($t9) 			# colour the address black

		# calculate the new x and y offset of first half to paint
		addi $t2, $t2, -1
		la $t7, CAPSULE_X1
		la $t8, CAPSULE_Y1
		sw $t1, 0($t7)				# update the X coord of first half
		sw $t2, 0($t8)				# update the Y coord of first half
		sll $t7, $t1, 2				
		sll $t8, $t2, 7
		
		# calculated the correct address to paint
		lw 	$t9, ADDR_DSPL
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $t5, 0($t9) 			# colour the address appropriately (with colour 1)

		# calculate the new x and y offset of second half to paint
		addi $t3, $t3, 1
		la $t7, CAPSULE_X2
		la $t8, CAPSULE_Y2
		sw $t3, 0($t7)				# update the X coord of second half
		sw $t4, 0($t8)				# update the Y coord of second half
		sll $t7, $t3, 2				
		sll $t8, $t4, 7
		
		# calculated the correct address to paint
		lw 	$t9, ADDR_DSPL
		add $t9, $t9, $t7
		add $t9, $t9, $t8
		sw $t6, 0($t9) 			# colour the address appropriately (with colour 2)
		
		j end_respond_to_W

end_respond_to_W:
	addi $t0, $t0, 1 			# increment rotation state

	# ensure it wraps around at 4
	li $t1, 4
	div $t0, $t1				# divide rotation state by 4
	mfhi $t0					# store remainder into t0
	la $t1, PILL_ROTATION	# get the rotation address
	sw $t0, 0($t1)				# update the rotation state

	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.
	jr $ra

#------------------------------------------------------------
# Handle left movement
respond_to_A:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	jal check_collision_A			# Check for collision to the left of the pill
	
	lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
	lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
	lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

	lw $t5, CAPSULE_COLOUR_1		# load capsule colour of first half
	lw $t6, CAPSULE_COLOUR_2		# load capsule colour of second half
	lw $t9, ADDR_DSPL				# t9 = display address
	
	# calculate the x and y offset of first half to delete
	sll $t7, $t1, 2				
	sll $t8, $t2, 7
	# calculated the correct address to delete
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $zero, 0($t9) 			# colour the address black

	# calculate the x and y offset of second half to delete
	sll $t7, $t3, 2				
	sll $t8, $t4, 7
	# calculated the correct address to delete
	lw $t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $zero, 0($t9) 			# colour the address black
	
	# calculate the new x and y offset of first half to paint
	addi $t1, $t1, -1
	la $t7, CAPSULE_X1
	la $t8, CAPSULE_Y1
	sw $t1, 0($t7)				# update the X coord of first half
	sw $t2, 0($t8)				# update the Y coord of first half
	sll $t7, $t1, 2				
	sll $t8, $t2, 7
	
	# calculated the correct address to paint
	lw 	$t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $t5, 0($t9) 			# colour the address appropriately (with colour 1)

	# calculate the new x and y offset of second half to paint
	addi $t3, $t3, -1
	la $t7, CAPSULE_X2
	la $t8, CAPSULE_Y2
	sw $t3, 0($t7)				# update the X coord of second half
	sw $t4, 0($t8)				# update the Y coord of second half
	sll $t7, $t3, 2				
	sll $t8, $t4, 7
	
	# calculated the correct address to paint
	lw 	$t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $t6, 0($t9) 			# colour the address appropriately (with colour 2)
	
end_respond_to_A:
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.
	jr $ra

#------------------------------------------------------------
# Handle downward movement
respond_to_S:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	jal check_collision_S
	
	lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
	lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
	lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

	lw $t5, CAPSULE_COLOUR_1		# load capsule colour of first half
	lw $t6, CAPSULE_COLOUR_2		# load capsule colour of second half
	lw $t9, ADDR_DSPL				# t9 = display address

	
	# calculate the x and y offset of first half to delete
	sll $t7, $t1, 2				
	sll $t8, $t2, 7
	# calculated the correct address to delete
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $zero, 0($t9) 			# colour the address black

	# calculate the x and y offset of second half to delete
	sll $t7, $t3, 2				
	sll $t8, $t4, 7
	# calculated the correct address to delete
	lw $t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $zero, 0($t9) 			# colour the address black
	
	# calculate the new x and y offset of first half to paint
	addi $t2, $t2, 1
	la $t7, CAPSULE_X1
	la $t8, CAPSULE_Y1
	sw $t1, 0($t7)				# update the X coord of first half
	sw $t2, 0($t8)				# update the Y coord of first half
	sll $t7, $t1, 2				
	sll $t8, $t2, 7
	
	# calculated the correct address to paint
	lw 	$t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $t5, 0($t9) 			# colour the address appropriately (with colour 1)

	# calculate the new x and y offset of second half to paint
	addi $t4, $t4, 1
	la $t7, CAPSULE_X2
	la $t8, CAPSULE_Y2
	sw $t3, 0($t7)				# update the X coord of second half
	sw $t4, 0($t8)				# update the Y coord of second half
	sll $t7, $t3, 2				
	sll $t8, $t4, 7
	
	# calculated the correct address to paint
	lw 	$t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $t6, 0($t9) 			# colour the address appropriately (with colour 2)

end_respond_to_S:
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.
	jr $ra

#------------------------------------------------------------
# Handle right movement
respond_to_D:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	jal check_collision_D			# Check for collision to the right of the pill

	lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
	lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
	lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

	lw $t5, CAPSULE_COLOUR_1		# load capsule colour of first half
	lw $t6, CAPSULE_COLOUR_2		# load capsule colour of second half
	lw $t9, ADDR_DSPL				# t9 = display address

	# calculate the x and y offset of first half to delete
	sll $t7, $t1, 2				
	sll $t8, $t2, 7
	# calculated the correct address to delete
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $zero, 0($t9) 			# colour the address black

	# calculate the x and y offset of second half to delete
	sll $t7, $t3, 2				
	sll $t8, $t4, 7
	# calculated the correct address to delete
	lw $t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $zero, 0($t9) 			# colour the address black
	

	# calculate the new x and y offset of first half to paint
	addi $t1, $t1, 1
	la $t7, CAPSULE_X1
	la $t8, CAPSULE_Y1
	sw $t1, 0($t7)				# update the X coord of first half
	sw $t2, 0($t8)				# update the Y coord of first half
	sll $t7, $t1, 2				
	sll $t8, $t2, 7
	
	# calculated the correct address to paint
	lw 	$t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $t5, 0($t9) 			# colour the address appropriately (with colour 1)

	# calculate the new x and y offset of second half to paint
	addi $t3, $t3, 1
	la $t7, CAPSULE_X2
	la $t8, CAPSULE_Y2
	sw $t3, 0($t7)				# update the X coord of second half
	sw $t4, 0($t8)				# update the Y coord of second half
	sll $t7, $t3, 2				
	sll $t8, $t4, 7
	
	# calculated the correct address to paint
	lw 	$t9, ADDR_DSPL
	add $t9, $t9, $t7
	add $t9, $t9, $t8
	sw $t6, 0($t9) 			# colour the address appropriately (with colour 2)

end_respond_to_D:
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.	
	jr $ra


##############################################################################
# Collision Check Functions
##############################################################################
#-------------------------------------------------------------------------
# This function does not work!!! We tried :()
# Drop pixels immediately upon horizontal deletion
# a0 - The number of blocks that were elimenated
# a1 - The X coordinate of the last matching pixel
# a2 - The Y coordinate of the last matching pixel
drop_blocks_horizontal:
    addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping. 
    
    addi $t0, $a1, 2                 # move to the right of the deleted block
    addi $a0, $a0, 2                 # check two more than the number of blocks that were deleted (the left and right side)
    li $t4, 0                        # number of cols we have checked so far (outer loop variable)
    lw $t5, BOTTLE_Y_OFFSET          # top of the bottle (inner loop stop condition)
    
    drop_blocks_horizontal_outer_loop:
        addi, $t0, $t0, -1           # move left 
        move $t1, $a2                # Y-coord (inner loop variable)

        addi $t4, $t4, 1             # increment outer loop variable
        beq $t4, $a0, end_drop_blocks_horizontal    # after checking $a0 + 2 columns, end
        
        drop_blocks_horizontal_inner_loop:
            addi $t1, $t1, -1                                      # move up (decrement inner loop variable)
            beq $t1, $t5, drop_blocks_horizontal_outer_loop        # if we reached the top of the bottle, go the the next column
            j drop_blocks_horizontal_inner_loop

            
        
        end_drop_blocks_horizontal_inner_loop:
                    
end_drop_blocks_horizontal:
    lw $ra, 0($sp)          	# Restore $ra from the stack.
	addi $sp, $sp, 4       		# move the stack pointer to the current top of the stack.
    jr $ra       


#------------------------------------------------------------
# Check if there is a colour (other than black) already at the given location.
# - a0: x coordinate of the pixel we want to check
# - a1: y coordinate of the pixel we want to check
check_collision:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.
	
	lw $t0, ADDR_DSPL	# Load display address
	sll $t1, $a0, 2 	# Calculate X-coordinate
    sll $t2, $a1, 7		# Calculate Y-coordinate
	add $t0, $t0, $t1
	add $t0, $t0, $t2
	lw $t3, 0($t0)

	bne $t3, $zero, game_loop  	# If the spot is not empty (not black), jump to the beginning of the game loop
	
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.	
	jr $ra

#------------------------------------------------------------
# This function should ONLY be called if there is downward motion
# If there is a collision with an object from below, load the next pill to play
# - a0: x coordinate of the pixel we want to check
# - a1: y coordinate of the pixel we want to check
check_downward_collision:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.
	
	lw $t0, ADDR_DSPL	# Load display address
	sll $t1, $a0, 2 	# Calculate X-coordinate
    sll $t2, $a1, 7		# Calculate Y-coordinate
	add $t0, $t0, $t1
	add $t0, $t0, $t2
	lw $t3, 0($t0)

	bne $t3, $zero, downward_collision  	# If the spot is not empty (not black), handle the downward_collision
	jr $ra
	
	downward_collision:
		# Set the current capsule colours to the next capsule colours
		la $t1, CAPSULE_COLOUR_1
		lw $t2, NEXT_CAPSULE_COLOUR_1
		sw $t2 0($t1)

		la $t1, CAPSULE_COLOUR_2
		lw $t2, NEXT_CAPSULE_COLOUR_2
		sw $t2 0($t1)
		
		jal draw_current_pill		# draw the new pill in the bottle

		# randomly set the next pills colour
		la $a0, NEXT_CAPSULE_COLOUR_1
		la $a1, NEXT_CAPSULE_COLOUR_2
		jal set_colour
	
		jal draw_next_pill				# draw the pill thats outside the bottle
        jal eliminate_matching_blocks   # eliminate any four in a rows you find

		j game_loop						# Jump to the top of the game loop, ready to control the next pill

#------------------------------------------------------------
# Check for collisions when rotating, depending on its current orientation 
# Uses check_collision as a helper function
check_collision_W:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
	lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
	lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

	beq $t0, 0, collision_W_1		# If case 1
	beq $t0, 1, collision_W_2		# If case 2
	beq $t0, 2, collision_W_3		# If case 3
	beq $t0, 3, collision_W_4		# If case 4

	# Orientation 0
	collision_W_1:
		move $a0, $t1
		addi $a1, $t2, 1
		jal check_collision
		j end_check_collision_W

	# Orientation 1
	collision_W_2:
		addi $a0, $t1, 1
		move $a1, $t2
		jal check_collision
		j end_check_collision_W

	# Orientation 2
	collision_W_3:
		move $a0, $t3
		addi $a1, $t4, 1
		jal check_collision
		j end_check_collision_W

	# Orientation 3
	collision_W_4:
		addi $a0, $t3, 1
		move $a1, $t4
		jal check_collision
		j end_check_collision_W

end_check_collision_W:
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.	
	jr $ra

#------------------------------------------------------------
# Check for collisions to the left of the pill based on the orientation
# Uses check_collision as a helper function
check_collision_A:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
	lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
	lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

	beq $t0, 0, collision_A_1		# If case 1
	beq $t0, 2, collision_A_2		# If case 2
	b collision_A_3					# Else

	# Part 1 is on the left
	collision_A_1:
		addi $a0, $t1, -1
		move $a1, $t2
		add $a2, $zero, $zero
		jal check_collision
		j end_check_collision_A

	# Part 2 is on the left
	collision_A_2:
		addi $a0, $t3, -1
		move $a1, $t4
		add $a2, $zero, $zero
		jal check_collision
		j end_check_collision_A

	# Capsule is vertical
	collision_A_3:
		addi $a0, $t1, -1
		move $a1, $t2
		add $a2, $zero, $zero
		jal check_collision

		lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
		lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    	lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
		lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    	lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

		addi $a0, $t3, -1
		move $a1, $t4
		jal check_collision
		j end_check_collision_A

end_check_collision_A:
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.	
	jr $ra

#------------------------------------------------------------
# Check for collisions below the pill based on the orientation
# Load the next pill to play into the bottle if there is a collision
check_collision_S:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
	lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
	lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

	beq $t0, 1, collision_S_1		# If case 1
	beq $t0, 3, collision_S_2		# If case 2
	b collision_S_3					# Else

	# Part 2 is on the bottom
	collision_S_1:
		move $a0, $t3
		addi $a1, $t4, 1
		jal check_downward_collision
		j end_check_collision_S

	# Part 1 is on the bottom
	collision_S_2:
		move $a0, $t1
		addi $a1, $t2, 1
		jal check_downward_collision
		j end_check_collision_S

	# Capsule is horizontal
	collision_S_3:
		move $a0, $t3
		addi $a1, $t4, 1
		jal check_downward_collision

		lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
		lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    	lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
		lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    	lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

		move $a0, $t1
		addi $a1, $t2, 1
		jal check_downward_collision
		j end_check_collision_S

end_check_collision_S:
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.	
	jr $ra

#------------------------------------------------------------
# Check for collisions to the right of the pill based on the orientation
# Uses check_collision as a helper function
check_collision_D:
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping.

	lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
	lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
	lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

	beq $t0, 0, collision_D_1		# If case 1
	beq $t0, 2, collision_D_2		# If case 2
	b collision_D_3					# Else

	# Part 2 is on the right
	collision_D_1:
		addi $a0, $t3, 1
		move $a1, $t4
		jal check_collision
		j end_check_collision_D

	# Part 1 is on the left
	collision_D_2:
		addi $a0, $t1, 1
		move $a1, $t2
		jal check_collision
		j end_check_collision_D

	# Capsule is vertical
	collision_D_3:
		addi $a0, $t1, 1
		move $a1, $t2
		jal check_collision

		lw $t0, PILL_ROTATION		# load the current rotation state (0 to 3)
		lw $t1, CAPSULE_X1				# load X coordinate of the capsule (first half)
    	lw $t2, CAPSULE_Y1				# load Y coordinate of the capsule (first half)
		lw $t3, CAPSULE_X2				# load X coordinate of the capsule (second half)
    	lw $t4, CAPSULE_Y2				# load Y coordinate of the capsule (second half)

		addi $a0, $t3, 1
		move $a1, $t4
		jal check_collision
		j end_check_collision_D

end_check_collision_D:
	lw $ra, 0($sp)                  # Restore $ra from the stack.
	addi $sp, $sp, 4                # move the stack pointer to the current top of the stack.	
	jr $ra

#-------------------------------------------------------------------------
# Iterate through each row and column to find sequences of 4 or more
# consecutive pixels of the same color. If any such sequence is found,
# remove the matching blocks by replacing them with black pixels.
eliminate_matching_blocks:	
	addi $sp, $sp, -4               # Move the stack pointer to an empty location
	sw $ra, 0($sp)                  # Store $ra on the stack for safe keeping. 


    #---------------------------------------------Start of checking for horizontal matches---------------------------------------------
    li $t9, 1                       # Counter for the number of pixels (of the same colour) in a row
    lw $t1, BOTTLE_X_OFFSET
    lw $t2, BOTTLE_WIDTH
    lw $t3, BOTTLE_Y_OFFSET
    lw $t4, BOTTLE_HEIGHT

    addi $s4, $t1, 1                # X position (inner loop variable)
    add $s5, $t3, $zero             # Y position (outer loop variable)

    add $s6, $s4, $t2
    addi $s6, $s6, -2               # The right side of our bottle (inner stop variable)
    
    add $s7, $s5, $t4      
    addi $s7, $s7, -1               # The bottom of the bottle (outer stop variable)

    check_row_outer_loop:
        lw $t1, BOTTLE_X_OFFSET
        addi $s4, $t1, 1            # reset X position (inner loop variable)
        addi $s5, $s5, 1            # add 1 to the Y position
        li $t9, 1                   # reset number of pixels (of the same colour) in a row counter back to 1 
        li $t2, 0                   # $t2 = prev_colour = black
        li $t3, 0                   # $t3 = curr_colour = black
        
        beq $s5, $s7, end_check_row_outer_loop        # outer for loop variable reached end of the bottle. Exit out of the for loop.
        
        check_row_inner_loop:

            # Calculate the position of the current pixel we want to check
            sll $t4, $s4, 2 	    # Calculate X-offset
            sll $t5, $s5, 7		    # Calculate Y-offset
            lw $t0, ADDR_DSPL	    # Load display address
            add $t0, $t0, $t4
            add $t0, $t0, $t5
            lw $t3, 0($t0)          # Store its colour in $t3 (current colour)


            # Checking if the colours match with a margin of 1 (since viruses and capsules of the same colour differ by 1) 
            beq $t3, 0, check_black_horizontal       # if the current colour is black skip this section
            addi $t8, $t2, -1 
            beq $t8, $t3, same_colour_horizontal
            addi $t8, $t2, 1 
            beq $t8, $t3, same_colour_horizontal
            

            check_black_horizontal:
                bne $t2, $t3, check_four_or_more           # if the previous colour is NOT the same as the current colour, check if four or more
                beq $t3, 0, end_check_row_inner_loop       # if the current colour is the same as previous colour, make sure it's not black (if it is jump to next iteration)

            same_colour_horizontal:
            addi $t9, $t9, 1                           # otherwise, increment same colour counter before going to next iteration of the inner loop
    
            
            j end_check_row_inner_loop

            # Check if there are 4 or more pixels of the same colour in a row
            check_four_or_more:
                bgt $t9, 3, delete_horizontal
                j end_delete_horizontal
                
                delete_horizontal:
                    # Draw a black horizontal line
                    sub $a0, $s4, $t9                # - a0: X coordinate of the start of the line
                    move $a1, $s5                    # - a1: Y coordinate of the start of the line
                    move $a2, $t9                    # - a2: Length of the line
                    move $a3, $zero                  # - a3: Colour of the line
                    jal draw_horizontal
                    
                end_delete_horizontal:
                    li $t9, 1
                    beq $s4, $s6 check_row_outer_loop          # if we reached the right side of the wall, go to outer loop
                    j end_check_row_inner_loop                 # if the colours were not the same jump to the inner loop and continue with the same row   

            end_check_row_inner_loop:
                add $t2, $t3, $zero                            # update previous colour
                addi $s4, $s4, 1                               # increment the x position (inner loop variable)
                
                beq $s4, $s6 check_four_or_more                # check for right side wall (go to outer for loop)
                j check_row_inner_loop

    end_check_row_outer_loop:

    #---------------------------------------------Start of checking for vertical matches---------------------------------------------
    li $t9, 1                          # Counter for the number of pixels (of the same colour) in a row
    lw $t1, BOTTLE_X_OFFSET
    lw $t2, BOTTLE_WIDTH
    lw $t3, BOTTLE_Y_OFFSET
    lw $t4, BOTTLE_HEIGHT

    addi $s5, $t3, 1                   # Y position (inner loop variable)
    add $s4, $t1, $zero                # X position (outer loop variable)
    
    add $s7, $s5, $t4      
    addi $s7, $s7, -2               # The bottom of the bottle (inner stop variable)

    add $s6, $s4, $t2
    addi $s6, $s6, -1               # The right side of our bottle (outer stop variable)

    check_col_outer_loop:
        lw $t3, BOTTLE_Y_OFFSET
        addi $s5, $t3, 1            # reset Y position (inner loop variable)
        addi $s4, $s4, 1            # add 1 to the X position
        li $t9, 1                   # reset number of pixels (of the same colour) in a row counter to back to 1
        li $t2, 0                   # $t2 = prev_colour = black
        li $t3, 0                   # $t3 = curr_colour = black
        
        beq $s4, $s6, end_check_col_outer_loop        # outer for loop variable reached end of the bottle. Exit out of the for loop.
        
        check_col_inner_loop:

            # Calculate the position of the current pixel we want to check
            sll $t4, $s4, 2 	    # Calculate X-offset
            sll $t5, $s5, 7		    # Calculate Y-offset
            lw $t0, ADDR_DSPL	    # Load display address
            add $t0, $t0, $t4
            add $t0, $t0, $t5
            lw $t3, 0($t0)          # Store its colour in $t3 (current colour)

            # Checking if the colours match with a margin of 1 (since viruses and capsules of the same colour differ by 1)     
            beq $t3, 0, check_black_vertical      # if the current colour is black skip this section
            addi $t8, $t2, -1 
            beq $t8, $t3, same_colour_vertical 
            addi $t8, $t2, 1 
            beq $t8, $t3, same_colour_vertical 
            

            check_black_vertical:
                bne $t2, $t3, check_four_or_more2           # if the previous colour is NOT the same as the current colour, check if four or more
                beq $t3, 0, end_check_col_inner_loop       # if the current colour is the same as previous colour, make sure it's not black (if it is jump to next iteration)

            same_colour_vertical:
            addi $t9, $t9, 1                           # otherwise, increment same colour counter before going to next iteration of the inner loop
    
            
            j end_check_col_inner_loop
            
            # Check if there are 4 or more pixels of the same colour in a column
            check_four_or_more2:
                bgt $t9, 3, delete_vertical
                j end_delete_vertical
                
                delete_vertical:
                    # Draw a black vertical line
                    move $a0, $s4                    # - a0: X coordinate of the start of the line
                    sub $a1, $s5, $t9                # - a1: Y coordinate of the start of the line
                    move $a2, $t9                    # - a2: Length of the line
                    move $a3, $zero                  # - a3: Colour of the line
                    jal draw_vertical
                
                end_delete_vertical:
                    li $t9, 1
                    beq $s5, $s7 check_col_outer_loop          # if we reached the bottom bottle, go to outer loop
                    j end_check_col_inner_loop                 # if the colours were not the same jump to the inner loop and continue with the same col   

            end_check_col_inner_loop:
                add $t2, $t3, $zero                            # update previous colour
                addi $s5, $s5, 1                               # increment the y position (inner loop variable)
                
                beq $s5, $s7 check_four_or_more2                # check for  bottom of the bottle (go to outer for loop)
                j check_col_inner_loop
    
    end_check_col_outer_loop:

end_eliminate_matching_blocks:
    lw $ra, 0($sp)          	# Restore $ra from the stack.
	addi $sp, $sp, 4       		# move the stack pointer to the current top of the stack.
    jr $ra 
                


##############################################################################
# System Call Functions
##############################################################################
#------------------------------------------------------------
# sleep for 17 ms, so we refresh the screen 60 times per second
sleep:
    li $v0, 32       # Syscall for sleep
    li $a0, 17       # Sleep time in milliseconds 
    syscall
    jr $ra           # Return to caller

quit:
	li $v0, 10                      # Quit gracefully
	syscall

#------------------------------------------------------------
# Returns a random number in the range [0, a0]  
# - a0: Upper bound (inclusive)  
# - v0: Randomly generated number within the range (return value)  
random_value:
	# Calculate upper bound
	addi $t0, $a0, 1
	
	# Call random generator 
	li $v0, 42
	li $a0, 0
	move $a1, $t0
	syscall

	# Store returned value in $v0 and return
	move $v0, $a0
	jr $ra
