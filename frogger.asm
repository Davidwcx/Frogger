#####################################################################
#
# CSC258H5S Fall 2021 Assembly Final Project
# University of Toronto, St. George
#
# Student: Chenxu Wang StudentNumber: 1006690270
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 5  
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. display the number of lives remaining 
# 2. Have objects in different rows move at different speeds.
# 3. add a third row in road and water sections 
# 4. display a death animation every time a player losses a frog 
# 5. After final player death, display game over/retry screen. Restart the game if the “retry” option is chosen.
# 6. display the player's score on top of screen
# Any additional information that the TA needs to know:
# - for the game over/ retry screen, the key that I set for restart the game is the number "1" key and the key to 
#   exit the game is the number "0" key. 
# - the score approach that I used for the game is that whenever the frog reaches a distinct goal region the score
#   goes up by 100 and the max score is reached once all 8 region is filled(800). 
#####################################################################
.data
displayAddress: .word 0x10008000
maxaddress: .word 0x1000A000
gameoveraddress: .word 0x10008C00
frogaddress: .word 0X10009FC4
roadspace1: .space 512
roadspace2: .space 512
roadspace3: .space 512
roadspace4: .space 512
riverspace1: .space 512
riverspace2: .space 512
riverspace3: .space 512
riverspace4: .space 512
winspace: .space 512
.text
lw $t0, displayAddress # $t0 stores the base address for display
lw $s5, frogaddress 
la $s0, roadspace1 # store the road space to $s0
la $s1, roadspace2 # store the road space2 to $s1 
la $s2, riverspace1
la $s3, riverspace2 
li $s4, 3 
addi $s6, $zero, 2
# the code that fill in the space for cars and logs 
DrawFirstCar: 
sw $zero, 0($sp) 
la $s0, roadspace1
li $t1, 0xff0000 # $t1 stores the red colour code 
addi $t4, $zero, 0
addi $t5 , $zero, 32
LOOP1: 
bge $t4, $t5, Drawbackground
add $t9, $s0, $t4  #  fill all the needed pixels for first road 
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP1 
Drawbackground: 
addi $t5 , $t5, 32
drawbackground: 
bge $t4, $t5, DrawSecondCar 
add $t9, $s0, $t4  #  fill all the needed pixels for first road 
sw $zero, 0($t9)
sw $zero, 128($t9)
sw $zero, 256($t9)
sw $zero, 384($t9)
addi $t4, $t4, 4
j drawbackground
DrawSecondCar: 
addi $t5 , $t5, 32 
LOOP2: 
bge $t4, $t5, Drawback2
add $t9, $s0, $t4  #  fill all the needed pixels for first road 
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP2
Drawback2: 
addi $t5 , $t5, 32
drawback2: 
bge $t4, $t5, DrawNextRow1
add $t9, $s0, $t4  #  fill all the needed pixels for first road 
sw $zero, 0($t9)
sw $zero, 128($t9)
sw $zero, 256($t9)
sw $zero, 384($t9)
addi $t4, $t4, 4
j drawback2 

#  fill all the needed pixels for the second road row 
DrawNextRow1: 
addi $t4, $zero, 0
addi $t5 , $zero, 16
la $s1, roadspace2
LOOP3: 
bge $t4, $t5, Drawback3
add $t9, $s1, $t4  #  fill all the needed pixels for first road 
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP3 
Drawback3: 
addi $t5 , $t5, 32
drawback3: bge $t4, $t5, DrawNextRow2
add $t9, $s1, $t4  #  fill all the needed pixels for first road 
sw $zero, 0($t9)
sw $zero, 128($t9)
sw $zero, 256($t9)
sw $zero, 384($t9)
addi $t4, $t4, 4
j drawback3
DrawNextRow2: 
addi $t5 , $t5, 32
LOOP4: bge $t4, $t5, Drawback4
add $t9, $s1, $t4  
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP4
Drawback4: 
addi $t5 , $t5, 32
drawback4: bge $t4, $t5, DrawNextRow3
add $t9, $s1, $t4  #  fill all the needed pixels for first road 
sw $zero, 0($t9)
sw $zero, 128($t9)
sw $zero, 256($t9)
sw $zero, 384($t9)
addi $t4, $t4, 4
j drawback4
DrawNextRow3: 
addi $t5 , $t5, 16
LOOP5: 
bge $t4, $t5, Drawnextrow4
add $t9, $s1, $t4  
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP5

Drawnextrow4: 
la $s0, roadspace3
li $t1, 0xff0000 # $t1 stores the red colour code 
addi $t4, $zero, 0
addi $t5 , $zero, 32
LOOP6: bge $t4, $t5, Drawback5
add $t9, $s0, $t4  #  fill all the needed pixels for first road 
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP6 
Drawback5: 
addi $t5 , $t5, 32
drawback5: bge $t4, $t5, Drawnextrow5
add $t9, $s0, $t4  #  fill all the needed pixels for first road 
sw $zero, 0($t9)
sw $zero, 128($t9)
sw $zero, 256($t9)
sw $zero, 384($t9)
addi $t4, $t4, 4
j drawback5
Drawnextrow5: 
addi $t5 , $t5, 32
LOOP7: bge $t4, $t5, Drawback6
add $t9, $s0, $t4  #  fill all the needed pixels for first road 
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP7
Drawback6: 
addi $t5 , $t5, 32
drawback6: bge $t4, $t5, DrawNextRow6
add $t9, $s0, $t4  #  fill all the needed pixels for first road 
sw $zero, 0($t9)
sw $zero, 128($t9)
sw $zero, 256($t9)
sw $zero, 384($t9)
addi $t4, $t4, 4
j drawback6

DrawNextRow6: 
la $s1, roadspace4
addi $t4, $zero, 0
addi $t5 , $zero, 16
LOOP8: bge $t4, $t5, Drawback7
add $t9, $s1, $t4  #  fill all the needed pixels for first road 
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP8 
Drawback7: 
addi $t5 , $t5, 32
drawback7: bge $t4, $t5, DrawNextRow7
add $t9, $s1, $t4  #  fill all the needed pixels for first road 
sw $zero, 0($t9)
sw $zero, 128($t9)
sw $zero, 256($t9)
sw $zero, 384($t9)
addi $t4, $t4, 4
j drawback7
DrawNextRow7: 
addi $t5 , $t5, 32
LOOP9: bge $t4, $t5, Drawback8
add $t9, $s1, $t4  
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP9
Drawback8: 
addi $t5 , $t5, 32
drawback8: bge $t4, $t5, DrawNextRow8
add $t9, $s1, $t4  #  fill all the needed pixels for first road 
sw $zero, 0($t9)
sw $zero, 128($t9)
sw $zero, 256($t9)
sw $zero, 384($t9)
addi $t4, $t4, 4
j drawback8
DrawNextRow8: 
addi $t5 , $t5, 16
LOOP10: 
bge $t4, $t5, DrawLogs
add $t9, $s1, $t4  
sw $t1, 0($t9)
sw $t1, 128($t9)
sw $t1, 256($t9)
sw $t1, 384($t9)
addi $t4, $t4, 4
j LOOP10

#  fill all the needed pixels for first water row 
DrawLogs: 
li $t6, 0x964B00
li $t3, 0x448ee4 # $t3 stores the blue colour code for the river 
addi $t4, $zero, 0 
addi $t5 , $zero, 16 
water1: bge $t4, $t5, DrawLogs1
add $t9, $s2, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water1 
DrawLogs1:
addi $t4, $zero, 16
addi $t5 , $zero, 48
Log1: bge $t4, $t5, Water2
add $t9, $s2, $t4  
sw $t6, 0($t9)
sw $t6, 128($t9)
sw $t6, 256($t9)
sw $t6, 384($t9)
addi $t4, $t4, 4
j Log1
Water2: 
addi $t5 , $t5, 32 
water2:
bge $t4, $t5, DrawLogs2
add $t9, $s2, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water2
DrawLogs2: 
addi $t5 , $t5, 32
Log2: bge $t4, $t5, Water3
add $t9, $s2, $t4  
sw $t6, 0($t9)
sw $t6, 128($t9)
sw $t6, 256($t9)
sw $t6, 384($t9)
addi $t4, $t4, 4
j Log2
Water3: 
addi $t5 , $t5, 16
water3: bge $t4, $t5, DrawLogs3
add $t9, $s2, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water3 
#  fill all the needed pixels for the second water row 
DrawLogs3: 
addi $t4, $zero, 0 
addi $t5 , $zero, 32
water4: 
bge $t4, $t5, DrawLogs4
add $t9, $s3, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water4
DrawLogs4:
addi $t5 , $t5, 32
Log3: bge $t4, $t5, Water5
add $t9, $s3, $t4  
sw $t6, 0($t9)
sw $t6, 128($t9)
sw $t6, 256($t9)
sw $t6, 384($t9)
addi $t4, $t4, 4
j Log3
Water5: 
addi $t5 , $t5, 32 
water5:
bge $t4, $t5, DrawLogs5
add $t9, $s3, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water5
DrawLogs5:
addi $t5 , $t5, 32
Log4: 
bge $t4, $t5, DrawLogs6
add $t9, $s3, $t4  
sw $t6, 0($t9)
sw $t6, 128($t9)
sw $t6, 256($t9)
sw $t6, 384($t9)
addi $t4, $t4, 4
j Log4

DrawLogs6: 
li $t6, 0x964B00
li $t3, 0x448ee4 # $t3 stores the blue colour code for the river 
la $s2, riverspace3
addi $t4, $zero, 0 
addi $t5 , $zero, 16 
water6: bge $t4, $t5, DrawLogs7
add $t9, $s2, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water6 
DrawLogs7:
addi $t4, $zero, 16
addi $t5 , $zero, 48
Log7: bge $t4, $t5, Water7
add $t9, $s2, $t4  
sw $t6, 0($t9)
sw $t6, 128($t9)
sw $t6, 256($t9)
sw $t6, 384($t9)
addi $t4, $t4, 4
j Log7
Water7: 
addi $t5 , $t5, 32 
water7:
bge $t4, $t5, DrawLogs8
add $t9, $s2, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water7
DrawLogs8: 
addi $t5 , $t5, 32
Log8: bge $t4, $t5, Water8
add $t9, $s2, $t4  
sw $t6, 0($t9)
sw $t6, 128($t9)
sw $t6, 256($t9)
sw $t6, 384($t9)
addi $t4, $t4, 4
j Log8
Water8: 
addi $t5 , $t5, 16
water8: bge $t4, $t5, DrawLogs9
add $t9, $s2, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water8
#  fill all the needed pixels for the fourth water row 
DrawLogs9: 
addi $t4, $zero, 0 
addi $t5 , $zero, 32
la $s3, riverspace4
water9: 
bge $t4, $t5, DrawLogs10
add $t9, $s3, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water9
DrawLogs10:
addi $t5 , $t5, 32
Log10: bge $t4, $t5, Water10
add $t9, $s3, $t4  
sw $t6, 0($t9)
sw $t6, 128($t9)
sw $t6, 256($t9)
sw $t6, 384($t9)
addi $t4, $t4, 4
j Log10
Water10: 
addi $t5 , $t5, 32 
water10:
bge $t4, $t5, DrawLogs11
add $t9, $s3, $t4 
sw $t3, 0($t9)
sw $t3, 128($t9)
sw $t3, 256($t9)
sw $t3, 384($t9)
addi $t4, $t4, 4
j water10
DrawLogs11:
addi $t5 , $t5, 32
Log11: 
bge $t4, $t5, Fillsafe
add $t9, $s3, $t4  
sw $t6, 0($t9)
sw $t6, 128($t9)
sw $t6, 256($t9)
sw $t6, 384($t9)
addi $t4, $t4, 4
j Log11

Fillsafe: 
addi $t4, $zero, 0 
addi $t5 , $zero, 512
Fill: 
la $s2, winspace 
li $t2, 0x00ff00 
bge $t4, $t5, main
add $t9, $s2, $t4 
sw $t2, 0($t9)
addi $t4, $t4, 4
j Fill

Checkcollisioncar:
li $t1, 0xff0000
li $t3, 0x448ee4
beq $s7, $t1 dead 
beq $s7, $t3 dead
bne $s7, $t3 Checkkey
dead: 
lw $s5, frogaddress 
addi $s4, $s4, -1 
j updatecar1 
Checkkey: 
lw $t8, 0xffff0000
beq $t8, 1, keyboard_input
bne $t8, 1, updatecar1
keyboard_input: 
lw $t2, 0xffff0004
beq $t2, 0x77, Checkfrogup
beq $t2, 0x61, Checkfrogleft 
beq $t2, 0x73, Checkfrogdown
beq $t2, 0x64, Checkfrogright
bne $t2, 0x64, updatecar1
Checkfrogup: 
addi $t7, $s5, -512
slt $t7, $t7, $t0
beq $t7, 0, movefrogup
bne $t7, 0, updatecar1
Checkfrogdown: 
addi $t7, $s5, 512
lw $t9, maxaddress 
slt $t7, $t7, $t9
beq $t7, 1,  movefrogdown
bne $t7, 1, updatecar1
Checkfrogright:
addi $t7, $s5, 12 
sub $t7, $t7, $t0
addi $t9, $zero, 128
div $t7, $t9 
mfhi $t7
beq $t7, 0, updatecar1
beq $t7, 124, updatecar1
beq $t7, 120, updatecar1
beq $t7, 116, updatecar1
bne $t7, 0, movefrogright
Checkfrogleft: 
addi $t7, $s5, -4
sub $t7, $t7, $t0
addi $t9, $zero, 128
div $t7, $t9 
mfhi $t7
beq $t7, 0, updatecar1
beq $t7, 4, updatecar1
beq $t7, 8, updatecar1
beq $t7, 12, updatecar1
bne $t7, 0, movefrogleft
movefrogup: 
addi $s5, $s5, -512
j updatecar1
movefrogleft: 
addi $s5, $s5, -16
j updatecar1
movefrogright: 
addi $s5, $s5, 16
j updatecar1
movefrogdown: 
addi $s5, $s5, 512
j updatecar1

### update car locations 
updatecar1: 
la $s0, roadspace1
addi $t4, $zero, 0
addi $t5 , $zero, 128
addi $t6, $zero, 1 
startupdate: 
bge $t4, $t5, Checkupdatecar2
addi $t9, $t4, -4 
slti $t7, $t9, 0
beq $t6, $t7, edgecase 
bne $t6, $t7, othercase
othercase: 
add $t9, $s0, $t4
lw $t7, 0($t9) 
sw $t1, 0($t9)
addi $t1, $t7, 0 
lw $t7, 128($t9) 
sw $t2, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 256($t9) 
sw $t3, 256($t9)
addi $t3, $t7, 0 
lw $t7, 384($t9)
sw $t8, 384($t9)
addi $t8, $t7, 0 
addi $t4, $t4, 4 
j startupdate 
edgecase: 
add $t9, $s0, $t4
lw $t7, 0($t9) 
addi $t1, $t7, 0 
lw $t7, 124($t9)
sw $t7, 0($t9)

lw $t7, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 252($t9) 
sw $t7, 128($t9)

lw $t7, 256($t9) 
addi $t3, $t7, 0 
lw $t7, 380($t9)
sw $t7, 256($t9)

lw $t7, 384($t9)
addi $t8, $t7, 0 
lw $t7, 508($t9)
sw $t7, 384($t9)

addi $t4, $t4, 4 
j startupdate 

Checkupdatecar2: 
addi $t4, $zero, 0
beq $s6, $t4, updatecar2
bne $s6, $t4, updatecar3

updatecar2: 
la $s1, roadspace2
addi $t4, $zero, 128
addi $t5 , $zero, 0
addi $t6, $zero, 1 
startupdate1: 
bge $t5, $t4, updatecar3
slti $t7, $t4, 128
beq $t6, $t7, othercase1
bne $t6, $t7, edgecase1
othercase1: 
addi $t9, $t4, -4 
add $t9, $s1, $t9 
lw $t7, 0($t9) 
sw $t1, 0($t9)
addi $t1, $t7, 0 
lw $t7, 128($t9) 
sw $t2, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 256($t9) 
sw $t3, 256($t9)
addi $t3, $t7, 0 
lw $t7, 384($t9)
sw $t8, 384($t9)
addi $t8, $t7, 0 
addi $t4, $t4, -4 
j startupdate1 
edgecase1: 
addi $t9, $t4, -4 
add $t9, $s1, $t9 
lw $t7, 0($t9) 
addi $t1, $t7, 0 
lw $t7, -124($t9)
sw $t7, 0($t9)

lw $t7, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 4($t9) 
sw $t7, 128($t9)

lw $t7, 256($t9) 
addi $t3, $t7, 0 
lw $t7, 132($t9)
sw $t7, 256($t9)

lw $t7, 384($t9)
addi $t8, $t7, 0 
lw $t7, 260($t9)
sw $t7, 384($t9)

addi $t4, $t4, -4 
j startupdate1 

updatecar3: 
la $s0, roadspace3
addi $t4, $zero, 0
addi $t5 , $zero, 128
addi $t6, $zero, 1 
Startupdate: 
bge $t4, $t5, Checkupdatecar4
addi $t9, $t4, -4 
slti $t7, $t9, 0
beq $t6, $t7, Edgecase 
bne $t6, $t7, Othercase
Othercase: 
add $t9, $s0, $t4
lw $t7, 0($t9) 
sw $t1, 0($t9)
addi $t1, $t7, 0 
lw $t7, 128($t9) 
sw $t2, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 256($t9) 
sw $t3, 256($t9)
addi $t3, $t7, 0 
lw $t7, 384($t9)
sw $t8, 384($t9)
addi $t8, $t7, 0 
addi $t4, $t4, 4 
j Startupdate
Edgecase: 
add $t9, $s0, $t4
lw $t7, 0($t9) 
addi $t1, $t7, 0 
lw $t7, 124($t9)
sw $t7, 0($t9)

lw $t7, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 252($t9) 
sw $t7, 128($t9)

lw $t7, 256($t9) 
addi $t3, $t7, 0 
lw $t7, 380($t9)
sw $t7, 256($t9)

lw $t7, 384($t9)
addi $t8, $t7, 0 
lw $t7, 508($t9)
sw $t7, 384($t9)

addi $t4, $t4, 4 
j Startupdate 

Checkupdatecar4: 
beq $s6, $zero, updatecar4
bne $s6, $zero, updateriver 

updatecar4: 
la $s1, roadspace4
addi $t4, $zero, 128
addi $t5 , $zero, 0
addi $t6, $zero, 1 
Startupdate2: 
bge $t5, $t4, updateriver
slti $t7, $t4, 128
beq $t6, $t7, Othercase2
bne $t6, $t7, Edgecase2
Othercase2: 
addi $t9, $t4, -4 
add $t9, $s1, $t9 
lw $t7, 0($t9) 
sw $t1, 0($t9)
addi $t1, $t7, 0 
lw $t7, 128($t9) 
sw $t2, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 256($t9) 
sw $t3, 256($t9)
addi $t3, $t7, 0 
lw $t7, 384($t9)
sw $t8, 384($t9)
addi $t8, $t7, 0 
addi $t4, $t4, -4 
j Startupdate2
Edgecase2: 
addi $t9, $t4, -4 
add $t9, $s1, $t9 
lw $t7, 0($t9) 
addi $t1, $t7, 0 
lw $t7, -124($t9)
sw $t7, 0($t9)

lw $t7, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 4($t9) 
sw $t7, 128($t9)

lw $t7, 256($t9) 
addi $t3, $t7, 0 
lw $t7, 132($t9)
sw $t7, 256($t9)

lw $t7, 384($t9)
addi $t8, $t7, 0 
lw $t7, 260($t9)
sw $t7, 384($t9)

addi $t4, $t4, -4 
j Startupdate2



updateriver: 
addi $t4, $zero, 128
addi $t5 , $zero, 0
addi $t6, $zero, 1 
la $s2, riverspace1
startupdate2: 
bge $t5, $t4, Checkfrogmovelog
slti $t7, $t4, 128
beq $t6, $t7, othercase2
bne $t6, $t7, edgecase2
othercase2: 
addi $t9, $t4, -4 
add $t9, $s2, $t9 
lw $t7, 0($t9) 
sw $t1, 0($t9)
addi $t1, $t7, 0 
lw $t7, 128($t9) 
sw $t2, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 256($t9) 
sw $t3, 256($t9)
addi $t3, $t7, 0 
lw $t7, 384($t9)
sw $t8, 384($t9)
addi $t8, $t7, 0 
addi $t4, $t4, -4 
j startupdate2
edgecase2: 
addi $t9, $t4, -4 
add $t9, $s2, $t9 
lw $t7, 0($t9) 
addi $t1, $t7, 0 
lw $t7, -124($t9)
sw $t7, 0($t9)

lw $t7, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 4($t9) 
sw $t7, 128($t9)

lw $t7, 256($t9) 
addi $t3, $t7, 0 
lw $t7, 132($t9)
sw $t7, 256($t9)

lw $t7, 384($t9)
addi $t8, $t7, 0 
lw $t7, 260($t9)
sw $t7, 384($t9)

addi $t4, $t4, -4 
j startupdate2

Checkfrogmovelog:
sub $t7, $s5, $t0
slti $t5, $t7, 2560
beq $t5, $zero, Checkupdateriver1
bne $t5, $zero, checkfrogmovelog
checkfrogmovelog: 
slti $t5, $t7, 2048
beq $t5, $zero, frogmovelog
bne $t5, $zero, Checkupdateriver1
frogmovelog: 
addi $t7, $s5, -4
sub $t7, $t7, $t0
addi $t9, $zero, 128
div $t7, $t9 
mfhi $t7
beq $t7, 0, Checkupdateriver1
bne $t7, 0, frogmovelog1
frogmovelog1:
addi $s5, $s5, -4 

Checkupdateriver1: 
bne $s6, $zero, updateriver3
beq $s6, $zero, updateriver1

updateriver1: 
addi $t4, $zero, 0
addi $t5 , $zero, 128
addi $t6, $zero, 1 
la $s3, riverspace2
startupdate3: 
bge $t4, $t5, Checkfrogmovelog2
addi $t9, $t4, -4 
slti $t7, $t9, 0
beq $t6, $t7, edgecase3
bne $t6, $t7, othercase3
othercase3: 
add $t9, $s3, $t4
lw $t7, 0($t9) 
sw $t1, 0($t9)
addi $t1, $t7, 0 
lw $t7, 128($t9) 
sw $t2, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 256($t9) 
sw $t3, 256($t9)
addi $t3, $t7, 0 
lw $t7, 384($t9)
sw $t8, 384($t9)
addi $t8, $t7, 0 
addi $t4, $t4, 4 
j startupdate3
edgecase3: 
add $t9, $s3, $t4
lw $t7, 0($t9) 
addi $t1, $t7, 0 
lw $t7, 124($t9)
sw $t7, 0($t9)

lw $t7, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 252($t9) 
sw $t7, 128($t9)

lw $t7, 256($t9) 
addi $t3, $t7, 0 
lw $t7, 380($t9)
sw $t7, 256($t9)

lw $t7, 384($t9)
addi $t8, $t7, 0 
lw $t7, 508($t9)
sw $t7, 384($t9)

addi $t4, $t4, 4 
j startupdate3 

Checkfrogmovelog2:
sub $t7, $s5, $t0
slti $t5, $t7, 3072
beq $t5, $zero, updateriver3
bne $t5, $zero, checkfrogmovelog2
checkfrogmovelog2: 
slti $t5, $t7, 2560
beq $t5, $zero, frogmovelog2
bne $t5, $zero, updateriver3
frogmovelog2: 
addi $t7, $s5, 12
sub $t7, $t7, $t0
addi $t9, $zero, 128
div $t7, $t9 
mfhi $t7
beq $t7, 0, updateriver3
bne $t7, 0, frogmovelog3
frogmovelog3:
addi $s5, $s5, 4 

updateriver3: 
addi $t4, $zero, 128
addi $t5 , $zero, 0
addi $t6, $zero, 1 
la $s2, riverspace3
startupdate4: 
bge $t5, $t4, Checkfrogmovelog5
slti $t7, $t4, 128
beq $t6, $t7, othercase4
bne $t6, $t7, edgecase4
othercase4: 
addi $t9, $t4, -4 
add $t9, $s2, $t9 
lw $t7, 0($t9) 
sw $t1, 0($t9)
addi $t1, $t7, 0 
lw $t7, 128($t9) 
sw $t2, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 256($t9) 
sw $t3, 256($t9)
addi $t3, $t7, 0 
lw $t7, 384($t9)
sw $t8, 384($t9)
addi $t8, $t7, 0 
addi $t4, $t4, -4 
j startupdate4
edgecase4: 
addi $t9, $t4, -4 
add $t9, $s2, $t9 
lw $t7, 0($t9) 
addi $t1, $t7, 0 
lw $t7, -124($t9)
sw $t7, 0($t9)

lw $t7, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 4($t9) 
sw $t7, 128($t9)

lw $t7, 256($t9) 
addi $t3, $t7, 0 
lw $t7, 132($t9)
sw $t7, 256($t9)

lw $t7, 384($t9)
addi $t8, $t7, 0 
lw $t7, 260($t9)
sw $t7, 384($t9)

addi $t4, $t4, -4 
j startupdate4

Checkfrogmovelog5:
sub $t7, $s5, $t0
slti $t5, $t7, 3584
beq $t5, $zero, Checkupdateriver4
bne $t5, $zero, checkfrogmovelog5
checkfrogmovelog5: 
slti $t5, $t7, 3072
beq $t5, $zero, frogmovelog4
bne $t5, $zero, Checkupdateriver4
frogmovelog4: 
addi $t7, $s5, -4
sub $t7, $t7, $t0
addi $t9, $zero, 128
div $t7, $t9 
mfhi $t7
beq $t7, 0, Checkupdateriver4
bne $t7, 0, frogmovelog5
frogmovelog5:
addi $s5, $s5, -4 

Checkupdateriver4: 

bne $s6, $zero, main
beq $s6, $zero, updateriver4

updateriver4: 
addi $t4, $zero, 0
addi $t5 , $zero, 128
addi $t6, $zero, 1 
la $s3, riverspace4
startupdate5: 
bge $t4, $t5, Checkfrogmovelog4
addi $t9, $t4, -4 
slti $t7, $t9, 0
beq $t6, $t7, edgecase5
bne $t6, $t7, othercase5
othercase5: 
add $t9, $s3, $t4
lw $t7, 0($t9) 
sw $t1, 0($t9)
addi $t1, $t7, 0 
lw $t7, 128($t9) 
sw $t2, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 256($t9) 
sw $t3, 256($t9)
addi $t3, $t7, 0 
lw $t7, 384($t9)
sw $t8, 384($t9)
addi $t8, $t7, 0 
addi $t4, $t4, 4 
j startupdate5
edgecase5: 
add $t9, $s3, $t4
lw $t7, 0($t9) 
addi $t1, $t7, 0 
lw $t7, 124($t9)
sw $t7, 0($t9)

lw $t7, 128($t9) 
addi $t2, $t7, 0 
lw $t7, 252($t9) 
sw $t7, 128($t9)

lw $t7, 256($t9) 
addi $t3, $t7, 0 
lw $t7, 380($t9)
sw $t7, 256($t9)

lw $t7, 384($t9)
addi $t8, $t7, 0 
lw $t7, 508($t9)
sw $t7, 384($t9)

addi $t4, $t4, 4 
j startupdate5 

Checkfrogmovelog4:
sub $t7, $s5, $t0
slti $t5, $t7, 4096
beq $t5, $zero, main
bne $t5, $zero, checkfrogmovelog4
checkfrogmovelog4: 
slti $t5, $t7, 3584
beq $t5, $zero, frogmovelog6
bne $t5, $zero, main
frogmovelog6: 
addi $t7, $s5, 12
sub $t7, $t7, $t0
addi $t9, $zero, 128
div $t7, $t9 
mfhi $t7
beq $t7, 0, main
bne $t7, 0, frogmovelog7
frogmovelog7:
addi $s5, $s5, 4 

### start drawing the main part 
main: 
li $t1, 0xff0000 # $t1 stores the red colour code 
li $t2, 0x00ff00 # $t2 stores the green colour code
li $t3, 0x448ee4 # $t3 stores the blue colour code for the river 
# $t8 stores the orange colour code for intermediate zone 

addi $t4 , $zero, 0 # set $t4 to 0 
add $t6, $t0, $zero # set $t6 to $0 
addi $t5, $zero, 384 # set $t5 to 256
addi $t9, $zero, 256 # set $t7 to 128
Drawsafe: # draw the safe area 
beq $t5, $t4, Drawwin # while $t5 < $t4 
sw $t2, 0($t6) # paint the $t6 location green 
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 1 # $t4 + 1
j Drawsafe 
Drawwin:
addi $t4 , $zero, 0 
addi $t5 , $zero, 512
la $s1, winspace 
drawwin: 
beq $t4, $t5, DrawRiver# while $t4 < 512
add $t7, $s1, $t4 
lw $t7, 0($t7) 
sw $t7, 0($t6) # paint the $t6 location with color in s2
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j drawwin 
DrawRiver: 
addi $t4 , $zero, 0 
addi $t5 , $zero, 512
la $s2, riverspace1
logandriver1: 
beq $t4, $t5, DrawRiver2 # while $t4 < 512
add $t7, $s2, $t4 
lw $t7, 0($t7) 
sw $t7, 0($t6) # paint the $t6 location with color in s2
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j logandriver1
DrawRiver2: 
addi $t4 , $zero, 0
la $s3, riverspace2
logandriver2: 
beq $t4, $t5, DrawRiver3# while $t4 < 512 
add $t7, $s3, $t4 
lw $t7, 0($t7) 
sw $t7, 0($t6) # paint the $t6 location with color in s3 
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j logandriver2 
DrawRiver3: 
addi $t4 , $zero, 0 
addi $t5 , $zero, 512
la $s2, riverspace3
logandriver3: 
beq $t4, $t5, DrawRiver4# while $t4 < 512
add $t7, $s2, $t4 
lw $t7, 0($t7) 
sw $t7, 0($t6) # paint the $t6 location with color in s2
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j logandriver3
DrawRiver4: 
addi $t4 , $zero, 0
la $s3, riverspace4
logandriver4: 
beq $t4, $t5, DrawMiddle# while $t4 < 512 
add $t7, $s3, $t4 
lw $t7, 0($t7) 
sw $t7, 0($t6) # paint the $t6 location with color in s3 
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j logandriver4

DrawMiddle: 
li $t5, 0xFEDEBE 
addi $t4 , $zero, 0 
drawmiddle:
beq $t4, $t9, DrawRoad # while $t4 < 128
sw $t5, 0($t6) # paint the $t6 location orange 
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 1 # $t4 + 1
j drawmiddle 

DrawRoad: 
addi $t4 , $zero, 0 
addi $t5 , $zero, 512
la $s0, roadspace1
loop: 
beq $t4, $t5 DrawRoad2# while $t4 < $t5
add $t9, $s0, $t4 
lw $t9, 0($t9) 
sw $t9, 0($t6) # paint the $t6 location with colours in $s0 
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j loop 
DrawRoad2: 
addi $t4 , $zero, 0 
la $s1, roadspace2 
loop2: 
beq $t4, $t5, DrawRoad3 # while $t9 < $t5
add $t9, $s1, $t4 
lw $t9, 0($t9) 
sw $t9, 0($t6) # paint the $t6 location with colours in $s0 
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j loop2 
DrawRoad3: 
addi $t4 , $zero, 0 
addi $t5 , $zero, 512
la $s0, roadspace3
draw: 
beq $t4, $t5 DrawRoad4# while $t4 < $t5
add $t9, $s0, $t4 
lw $t9, 0($t9) 
sw $t9, 0($t6) # paint the $t6 location with colours in $s0 
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j draw 
DrawRoad4: 
addi $t4 , $zero, 0 
la $s1, roadspace4 
draw2: 
beq $t4, $t5, DrawStart # while $t9 < $t5
add $t9, $s1, $t4 
lw $t9, 0($t9) 
sw $t9, 0($t6) # paint the $t6 location with colours in $s0 
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 4 # $t4 + 4 
j draw2

DrawStart: 
addi $t9 , $zero, 256
loop3:
beq $t9, $zero, WinorFrog# while $t5 < $t4 
sw $t2, 0($t6) # paint the $t6 location blue
addi $t6, $t6, 4 # add $t6 by 4 
addi $t9, $t9, -1 # $t9 - 1
j loop3 
WinorFrog:
sub $t7, $s5, $t0
slti $t5, $t7, 2048
beq $t5, $zero, DrawFrog
bne $t5, $zero, ifwin
ifwin:
addi $t7, $s5, 12 
sub $t7, $t7, $t0
addi $t9, $zero, 16
div $t7, $t9 
mfhi $t7
beq $t7, $zero, Win
slti $t5, $t7, 8
beq $t5, $zero, handlewin
sub $s5, $s5, $t7
j Win 
handlewin:
sub $t7, $t9, $t7
add $s5, $s5, $t7
Win: 
li $t4, 0xD94496
la $s1, winspace 
sub $t7, $s5, $t0
addi $t7, $t7, -1536
add $t7, $s1, $t7
lw $t5, 0($t7) 
beq $t5, $t4, resetfrog 
sw $t4, 0($t7) # fill the pixels around the frogaddress
sw $t4, 4($t7)
sw $t4, -120($t7)
sw $t4, -132($t7)
lw $t4, 0($sp) 
addi $t4, $t4, 1
sw $t4, 0($sp) 
resetfrog:
lw $s5, frogaddress 
j Drawlives
DrawFrog: 
li $t4, 0xD94496 # $t4 stores colour pink 
lw $s7, 0($s5) 
beq $s7, $t1 Death
beq $s7, $t3 Death
sw $t4, 0($s5) # fill the pixels around the frogaddress
sw $t4, 4($s5)
sw $t4, 8($s5)
sw $t4, -4($s5)
sw $t4, -128($s5)
sw $t4, -124($s5)
sw $t4, -256($s5)
sw $t4, -252($s5)
sw $t4, -248($s5)
sw $t4, -260($s5)
sw $t4, -376($s5)
sw $t4, -388($s5)
Drawlives: 
li $t4, 0xD94496
li $t5, 3 
beq $s4, $t5 drawthreefrogs 
li $t5, 2
beq $s4, $t5 drawtwofrogs 
li $t5, 1
beq $s4, $t5 drawonefrog
li $t5, 0
beq $s4, $t5 Gameover
bne $s4, $t5 Checkscore
drawthreefrogs: 
lw $a0, displayAddress 
jal Drawlive 
addi $a0, $a0, -16
jal Drawlive 
addi $a0, $a0, -16
jal Drawlive
j Checkscore 
drawtwofrogs: 
lw $a0, displayAddress 
jal Drawlive 
addi $a0, $a0, -16
jal Drawlive 
j Checkscore
drawonefrog: 
lw $a0, displayAddress 
jal Drawlive 
j Checkscore
Checkscore: 
lw $t4, 0($sp)
beq $t4, $zero, drawzeroscore
addi $t5, $zero, 1 
beq $t4, $t5, drawonescore 
addi $t5, $zero, 2
beq $t4, $t5, drawtwoscore 
addi $t5, $zero, 3
beq $t4, $t5, drawthreescore 
addi $t5, $zero, 4
beq $t4, $t5, drawfourscore 
addi $t5, $zero, 5
beq $t4, $t5, drawfivescore 
addi $t5, $zero, 6
beq $t4, $t5, drawsixscore 
addi $t5, $zero, 7
beq $t4, $t5, drawsevenscore 
bne $t4, $t5, draweightscore 
drawzeroscore:
lw $a1, displayAddress
jal Drawzero
j Sleep
drawonescore: 
lw $a1, displayAddress
jal Drawone 
addi $a1, $a1, 20
jal Drawzero
addi $a1, $a1, 24
jal Drawzero
j Sleep
drawtwoscore: 
lw $a1, displayAddress
jal Drawtwo
addi $a1, $a1, 24
jal Drawzero
addi $a1, $a1, 24
jal Drawzero
j Sleep
drawthreescore: 
lw $a1, displayAddress
jal Drawthree
addi $a1, $a1, 24
jal Drawzero
addi $a1, $a1, 24
jal Drawzero
j Sleep
drawfourscore: 
lw $a1, displayAddress
jal Drawfour
addi $a1, $a1, 24
jal Drawzero
addi $a1, $a1, 24
jal Drawzero
j Sleep
drawfivescore: 
lw $a1, displayAddress
jal Drawfive
addi $a1, $a1, 24
jal Drawzero
addi $a1, $a1, 24
jal Drawzero
j Sleep
drawsixscore: 
lw $a1, displayAddress
jal Drawsix
addi $a1, $a1, 24
jal Drawzero
addi $a1, $a1, 24
jal Drawzero
j Sleep
drawsevenscore: 
lw $a1, displayAddress
jal Drawseven
addi $a1, $a1, 24
jal Drawzero
addi $a1, $a1, 24
jal Drawzero
j Sleep
draweightscore: 
lw $a1, displayAddress
jal Draweight
addi $a1, $a1, 24
jal Drawzero
addi $a1, $a1, 24
jal Drawzero
j Sleep

Sleep:
beq $s6, $zero, resets6
bne $s6, $zero, updates6
resets6: 
addi $s6, $zero, 2
j gosleep
updates6:
addi $s6, $s6, -1
j gosleep
gosleep: 
li $v0, 32
li $a0, 400
syscall 
j Checkcollisioncar 

Drawlive: 
sw $t4, 124($a0) 
sw $t4, 116($a0) 
sw $t4, 244($a0)
sw $t4, 248($a0)
sw $t4, 252($a0)
sw $t4, 376($a0) 
sw $t4, 504($a0)
sw $t4, 500($a0)
sw $t4, 508($a0)
jr $ra 

Death:
li $t4, 0xD94496
sw $t4, -4($s5) # fill the pixels around the frogaddress
sw $t4, 8($s5)
sw $t4, -128($s5)
sw $t4, -124($s5)
sw $t4, -256($s5)
sw $t4, -252($s5)
sw $t4, -388($s5)
sw $t4, -376($s5)
j Drawlives


Gameover: 
addi $t4 , $zero, 0 
addi $t5, $zero, 768
lw $t6, gameoveraddress
drawmenu: 
li $t1, 0xff0000
beq $t4, $t5, drawmessage 
sw $t1, 0($t6) # paint the $t6 location black
addi $t6, $t6, 4 # add $t6 by 4 
addi $t4, $t4, 1 
j drawmenu
drawmessage: 
li $t1, 0xffffff
lw $t6, gameoveraddress
sw $t1, 128($t6) # draw the G letter...
sw $t1, 132($t6)
sw $t1, 136($t6)
sw $t1, 140($t6)
sw $t1 , 256($t6) 
sw $t1 , 384($t6) 
sw $t1 , 512($t6) 
sw $t1 , 640($t6) 
sw $t1 , 644($t6) 
sw $t1 , 648($t6) 
sw $t1 , 652($t6)   
sw $t1, 524($t6) 
sw $t1, 396($t6) 
sw $t1, 392($t6) 

sw $t1, 148($t6) # draw the a letter 
sw $t1, 152($t6)
sw $t1, 156($t6)
sw $t1, 160($t6)
sw $t1 , 276($t6) 
sw $t1 , 404($t6) 
sw $t1 , 532($t6) 
sw $t1 , 660($t6)
sw $t1, 288($t6) 
sw $t1, 416($t6) 
sw $t1, 544($t6) 
sw $t1, 672($t6) 
sw $t1 , 408($t6) 
sw $t1 , 412($t6) 

sw $t1, 168($t6) # draw the m letter 
sw $t1, 172($t6)
sw $t1, 176($t6)
sw $t1, 180($t6)
sw $t1, 184($t6)
sw $t1, 296($t6)
sw $t1, 424($t6)
sw $t1, 552($t6)
sw $t1, 680($t6)
sw $t1, 304($t6)
sw $t1, 432($t6)
sw $t1, 560($t6)
sw $t1, 688($t6)
sw $t1, 312($t6)
sw $t1, 440($t6)
sw $t1, 568($t6)
sw $t1, 696($t6)

sw $t1, 192($t6) # draw the E letter 
sw $t1, 196($t6)
sw $t1, 200($t6)
sw $t1, 204($t6)
sw $t1, 320($t6)
sw $t1, 448($t6)
sw $t1, 452($t6)
sw $t1, 456($t6)
sw $t1, 576($t6)
sw $t1, 704($t6)
sw $t1, 708($t6)
sw $t1, 712($t6)
sw $t1, 716($t6)

sw $t1, 900($t6)
sw $t1, 904($t6)
sw $t1, 1024($t6)
sw $t1, 1152($t6)
sw $t1, 1280($t6)
sw $t1, 1412($t6)
sw $t1, 1416($t6)
sw $t1, 1036($t6)
sw $t1, 1164($t6)
sw $t1, 1292($t6)

sw $t1, 916($t6)
sw $t1, 928($t6)
sw $t1, 1044($t6)
sw $t1, 1172($t6)
sw $t1, 1300($t6)
sw $t1, 1432($t6)
sw $t1, 1436($t6)
sw $t1, 1056($t6)
sw $t1, 1184($t6)
sw $t1, 1312($t6)

sw $t1, 936($t6)
sw $t1, 940($t6)
sw $t1, 944($t6)
sw $t1, 948($t6)
sw $t1, 1064($t6)
sw $t1, 1192($t6)
sw $t1, 1196($t6)
sw $t1, 1200($t6)
sw $t1, 1320($t6)
sw $t1, 1448($t6)
sw $t1, 1452($t6)
sw $t1, 1456($t6)
sw $t1, 1460($t6)

sw $t1, 956($t6)
sw $t1, 960($t6)
sw $t1, 964($t6)
sw $t1, 968($t6)
sw $t1, 1084($t6)
sw $t1, 1212($t6)
sw $t1, 1340($t6)
sw $t1, 1468($t6)
sw $t1, 1096($t6)
sw $t1, 1224($t6)
sw $t1, 1220($t6)
sw $t1, 1216($t6)
sw $t1, 1348($t6)
sw $t1, 1480($t6)

lw $a2, gameoveraddress
addi $a2, $a2, 2176
jal DrawR

lw $a1, gameoveraddress
addi $a1, $a1, 2196
jal DrawE

sw $t1, 2216($t6)
sw $t1, 2220($t6)
sw $t1, 2224($t6)
sw $t1, 2228($t6)
sw $t1, 2232($t6)
sw $t1, 2352($t6)
sw $t1, 2480($t6)
sw $t1, 2608($t6)
sw $t1, 2736($t6)

lw $a2, gameoveraddress
addi $a2, $a2, 2240
jal DrawR

sw $t1, 2260($t6)
sw $t1, 2276($t6)
sw $t1, 2388($t6)
sw $t1, 2520($t6)
sw $t1, 2404($t6)
sw $t1, 2528($t6)
sw $t1, 2652($t6)
sw $t1, 2780($t6)

sw $t1, 2284($t6)
sw $t1, 2160($t6)
sw $t1, 2164($t6)
sw $t1, 2296($t6)
sw $t1, 2424($t6)
sw $t1, 2548($t6)
sw $t1, 2672($t6)
sw $t1, 2928($t6)

Checkresult:
lw $t2, 0xffff0004
beq $t2, 0x30, Exit 
beq $t2, 0x31, reseteverything
bne $t2, 0x30, Checkresult

reseteverything:# store the road space to $s0
lw $t0, displayAddress # $t0 stores the base address for display
lw $s5, frogaddress  # store the road space2 to $s1 
la $s0, roadspace1
la $s1, roadspace2 
la $s2, riverspace1
la $s3, riverspace2 
li $s4, 3 
addi $s6, $zero, 2
j DrawFirstCar 

DrawR: 
sw $t1, 0($a2)
sw $t1, 4($a2)
sw $t1, 8($a2)
sw $t1, 12($a2)
sw $t1, 128($a2)
sw $t1, 256($a2)
sw $t1, 384($a2)
sw $t1, 512($a2)
sw $t1, 140($a2)
sw $t1, 268($a2)
sw $t1, 264($a2)
sw $t1, 260($a2)
sw $t1, 392($a2)
sw $t1, 524($a2)
jr $ra

DrawE: 
sw $t1, 0($a1) # draw the E letter 
sw $t1, 4($a1)
sw $t1, 8($a1)
sw $t1, 12($a1)
sw $t1, 128($a1)
sw $t1, 256($a1)
sw $t1, 260($a1)
sw $t1, 264($a1)
sw $t1, 384($a1)
sw $t1, 512($a1)
sw $t1, 516($a1)
sw $t1, 520($a1)
sw $t1, 524($a1)
jr $ra


Exit:
li $v0, 10 # terminate the program gracefully
syscall

Drawzero: 
li $t4, 0xD94496
sw $t4, 4($a1)
sw $t4, 8($a1)
sw $t4, 12($a1)
sw $t4, 128($a1)
sw $t4, 256($a1)
sw $t4, 384($a1)
sw $t4, 512($a1)
sw $t4, 640($a1)
sw $t4, 772($a1)
sw $t4, 776($a1)
sw $t4, 780($a1)
sw $t4, 144($a1)
sw $t4, 272($a1)
sw $t4, 400($a1)
sw $t4, 528($a1)
sw $t4, 656($a1)
jr $ra 

Drawone: 
li $t4, 0xD94496
sw $t4, 128($a1)
sw $t4, 136($a1)
sw $t4, 132($a1)
sw $t4, 8($a1)
sw $t4, 264($a1)
sw $t4, 392($a1)
sw $t4, 520($a1)
sw $t4, 648($a1)
sw $t4, 776($a1)
sw $t4, 772($a1)
sw $t4, 768($a1)
sw $t4, 780($a1)
sw $t4, 784($a1)
jr $ra 

Drawtwo: 
li $t4, 0xD94496
sw $t4, 128($a1)
sw $t4, 4($a1)
sw $t4, 8($a1)
sw $t4, 12($a1)
sw $t4, 144($a1)
sw $t4, 272($a1)
sw $t4, 396($a1)
sw $t4, 392($a1)
sw $t4, 516($a1)
sw $t4, 640($a1)
sw $t4, 768($a1)
sw $t4, 772($a1)
sw $t4, 776($a1)
sw $t4, 780($a1)
sw $t4, 784($a1)
jr $ra 

Drawthree: 
li $t4, 0xD94496
sw $t4, 128($a1)
sw $t4, 4($a1)
sw $t4, 8($a1)
sw $t4, 12($a1)
sw $t4, 144($a1)
sw $t4, 272($a1)
sw $t4, 396($a1)
sw $t4, 392($a1)
sw $t4, 528($a1)
sw $t4, 656($a1)
sw $t4, 780($a1)
sw $t4, 776($a1)
sw $t4, 772($a1)
sw $t4, 640($a1)
jr $ra 

Drawfour: 
li $t4, 0xD94496
sw $t4, 12($a1)
sw $t4, 140($a1)
sw $t4, 136($a1)
sw $t4, 268($a1)
sw $t4, 260($a1)
sw $t4, 396($a1)
sw $t4, 384($a1)
sw $t4, 524($a1)
sw $t4, 528($a1)
sw $t4, 520($a1)
sw $t4, 516($a1)
sw $t4, 512($a1)
sw $t4, 652($a1)
sw $t4, 780($a1)
jr $ra 

Drawfive: 
li $t4, 0xD94496
sw $t4, 0($a1)
sw $t4, 4($a1)
sw $t4, 8($a1)
sw $t4, 12($a1)
sw $t4, 16($a1)
sw $t4, 128($a1)
sw $t4, 256($a1)
sw $t4, 384($a1)
sw $t4, 388($a1)
sw $t4, 392($a1)
sw $t4, 396($a1)
sw $t4, 528($a1)
sw $t4, 656($a1)
sw $t4, 780($a1)
sw $t4, 776($a1)
sw $t4, 772($a1)
sw $t4, 768($a1)
jr $ra

Drawsix: 
li $t4, 0xD94496
sw $t4, 4($a1)
sw $t4, 8($a1)
sw $t4, 12($a1)
sw $t4, 128($a1)
sw $t4, 144($a1)
sw $t4, 256($a1)
sw $t4, 384($a1)
sw $t4, 512($a1)
sw $t4, 640($a1)
sw $t4, 388($a1)
sw $t4, 392($a1)
sw $t4, 396($a1)
sw $t4, 528($a1)
sw $t4, 656($a1)
sw $t4, 780($a1)
sw $t4, 776($a1)
sw $t4, 772($a1)
jr $ra

Drawseven: 
li $t4, 0xD94496
sw $t4, 0($a1)
sw $t4, 4($a1)
sw $t4, 8($a1)
sw $t4, 12($a1)
sw $t4, 16($a1)
sw $t4, 144($a1)
sw $t4, 268($a1)
sw $t4, 392($a1)
sw $t4, 520($a1)
sw $t4, 648($a1)
sw $t4, 776($a1)
jr $ra

Draweight: 
li $t4, 0xD94496
sw $t4, 4($a1)
sw $t4, 8($a1)
sw $t4, 12($a1)
sw $t4, 128($a1)
sw $t4, 144($a1)
sw $t4, 256($a1)
sw $t4, 272($a1)
sw $t4, 512($a1)
sw $t4, 640($a1)
sw $t4, 388($a1)
sw $t4, 392($a1)
sw $t4, 396($a1)
sw $t4, 528($a1)
sw $t4, 656($a1)
sw $t4, 780($a1)
sw $t4, 776($a1)
sw $t4, 772($a1)
jr $ra
