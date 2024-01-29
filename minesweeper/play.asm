.include "macros.asm"

.globl play

play:
  save_context	
  move $s0, $a0
  move $s1, $a1
  move $s2, $a2

  sll $t1, $s1, 5 #i*8*4
  sll $t2, $s2, 2 #j*4
  
  add $t0, $t1, $t2
  add $t0, $t0, $s0
  lw $t4, 0($t0)
  
  #Ifs aqui
  beq $t4, -1, return0 
  bne $t4, -2, return1 
  
  addi $sp, $sp, -4
  sw $s0, 0 ($sp)
  move $a3, $t0
  jal countAdjacentBombs
  addi $sp, $sp, 4
  sw $v0, 0($a3)
  
  bne $v0, $zero, return1
  addi $sp, $sp, -4
  sw $s0, 0 ($sp)
  jal revealNeighboringCells
  addi $sp, $sp, 4
  
  
return1:
	li $v0, 1
	restore_context
	jr $ra  
return0:
	li $v0, 0
	restore_context
	jr $ra  


