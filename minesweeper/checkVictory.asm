.include "macros.asm"

.globl checkVictory

checkVictory:
save_context

  li $v0, 0
  li $s3, 0	# i=0
  li $s4, SIZE	# SIZE
  
  for_do_i:
  bgt $s3, $s4, fim_for_do_i
  
  li $s5, 0	# j=0
  li $s6, SIZE	# SIZE
  
  for_do_j:
  bgt $s5, $s6, fim_for_do_j
  
  sll $t1, $s3, 5 #i*8*4
  sll $t2, $s5, 2 #j*4
  
  add $t0, $t1, $t2
  add $t0, $t0, $s0
  lw $s7, 0($t0)
  
  bge $s7, 0, continue
  
  addi $v0, $v0, 1
  
  continue:
  addi $s5, $s5, 1
  j for_do_j
  
  fim_for_do_j:
  addi $s3, $s3, 1
  j for_do_i
  
  fim_for_do_i:
  
  beq $v0, BOMB_COUNT, return1
  
  li $v0, 0
  restore_context
  jr $ra
  
  return1:
  li $v0, 1
  restore_context
  jr $ra
