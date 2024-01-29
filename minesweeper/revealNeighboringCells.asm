.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
  save_context
  move $s0, $a0
  move $s1, $a1
  move $s2, $a2
  
  li $v0, 0
  
  addi $s3, $s1, -1 # i = row - 1
  addi $s4, $s1, 1 # row + 1
  for_do_i:
  bgt $s3, $s4, fim_for_do_i
  
  addi $s5, $s2, -1 # j = column - 1
  addi $s6, $s2, 1 # column + 1
  for_do_j:
  bgt $s5, $s6, fim_for_do_j
  
  blt $s3, $zero, continue
  bge $s3, SIZE, continue
  blt $s5, $zero, continue
  bge $s5, SIZE, continue
  
  sll $t1, $s3, 5 #i*8*4
  sll $t2, $s5, 2 #j*4
  
  add $t0, $t1, $t2
  add $t0, $t0, $s0
  lw $s7, 0($t0)
  
  bne $s7, -2, continue
  
  #Funcao countAdjacentBombs
  move $a1, $s3
  move $a2, $s5
  
  addi $sp, $sp, -4
  sw $s0, 0 ($sp)
  move $a3, $t0
  jal countAdjacentBombs
  addi $sp, $sp, 4
  sw $v0, 0($a3)
  
  #Funcao de revelar as celulas
  move $a1, $s3
  move $a2, $s5
  
  bne $v0, $zero, continue
  addi $sp, $sp, -4
  sw $s0, 0 ($sp)
  jal revealNeighboringCells
  addi $sp, $sp, 4
  
  continue:
  addi $s5, $s5, 1
  j for_do_j
  
  fim_for_do_j:
  addi $s3, $s3, 1
  j for_do_i
  
  fim_for_do_i:
  restore_context
  jr $ra