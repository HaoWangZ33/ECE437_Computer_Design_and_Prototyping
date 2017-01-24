#----------------------------------------------------------------------
#    QUICKSORT Function
#
#    # $a0 = array, $a1 = left, $a2 = right
#----------------------------------------------------------------------
QUICKSORT:
    addi $t0, $a1, 1         # t0 = i = left + 1
    add $t1, $a2, $zero      # t1 = j = right

    #----------------------------------------------------------------------
    # if(left > right)return;
    #----------------------------------------------------------------------
    sub $t2, $t1, $t0        # t2 = right - left
    slti $t3, $t2, 0         # t3 = ?(t2 < 0)
    beq $t3, $zero, Loop1    # if t3 >= 0 then goto Loop1
    jr $ra                   # return

#----------------------------------------------------------------------
#    while( 1 )
#----------------------------------------------------------------------
Loop1:                       # while(1)
    sll $t2, $a1, 2          # t2 = left * 4
    add $t2, $t2, $a0        # t2 = &array[left]
    lw $t3, 0($t2)           # t3 = array[left]

#----------------------------------------------------------------------
#    while( array[i] < array[left] && i < right+1)i++;
#----------------------------------------------------------------------
Loop2:                 
    sll $t2, $t0, 2          # t2 = i * 4
    add $t2, $t2, $a0        # t2 = &array[i]
    lw $t4, 0($t2)           # t4 = array[i]

    #----------------------------------------------------------------------
    # if( array[i] >= array[left] ) then goto Loop3
    #----------------------------------------------------------------------
    sub $t2, $t4, $t3        # t2 = arrat[i] - array[left]
    slti $t5, $t2, 0         # t5 = ?(t2 < 0)
    bne $t5, $zero, Loop3    # if t5 != 0 then goto Loop3

    #----------------------------------------------------------------------
    # if( i >= (right+1) ) then goto Loop3
    #----------------------------------------------------------------------
    addi $t5, $a2, 1         # t5 = right + 1
    sub $t2, $t0, $t5        # t2 = i - 5
    slti $t5, $t2, 0         # t5 = ?(t2 < 0)
    bne $t5, $zero, Loop3    # if t5 != 0 then goto Loop3
  
    addi $t0, $t0, 1         # i++
    j Loop2                  # goto Loop2

#----------------------------------------------------------------------
#    while( array[j] > array[left] && j > left-1)j--;
#----------------------------------------------------------------------
Loop3:
    sll $t2, $t1, 2          # t2 = j * 4
    add $t2, $t2, $a0        # t2 = &array[j]
    lw $t4, 0($t2)           # t4 = array[j]

    #----------------------------------------------------------------------
    # if( array[j] <= array[left] ) then goto Bloop
    #----------------------------------------------------------------------
    sub $t2, $t4, $t3        # t2 = arrat[j] - array[left]
    slti $t5, $t2, 0         # t5 = ?(t2 < 0)
    beq $t5, $zero, Bloop    # if t5 = 0 then goto Bloop

    #----------------------------------------------------------------------
    # if( j <= (left-1) ) then goto Bloop
    #----------------------------------------------------------------------
    addi $t5, $a1, -1         # t5 = left - 1
    sub $t2, $t1, $t5        # t2 = j - t5
    slti $t5, $t2, 0         # t5 = ?(t2 < 0)
    beq $t5, $zero, Bloop    # if t5 = 0 then goto Bloop
  
    addi $t1, $t1, -1        # j--
    j Loop3                  # goto Loop3

Bloop:
    #----------------------------------------------------------------------
    # Do Swap
    #----------------------------------------------------------------------
    addi $sp, $sp, -20       # Make 5 words STACK
    sw $ra, 16($sp)          #
    sw $a0, 12($sp)          #
    sw $a1, 8($sp)           #
    sw $t0, 4($sp)           #
    sw $t1, 0($sp)           #

    add $a1, $a0, $t1       # a1 = array + j
    add $a0, $a0, $t0       # a0 = array + i
    jal SWAP                 # Call SWAP

    lw $t1, 0($sp)           #
    lw $t0, 4($sp)           #
    lw $a1, 8($sp)           #
    lw $a0, 12($sp)          #
    lw $ra, 16($sp)          #
    addi $sp, $sp, 20        # Clear STACK


    j Loop1                  # goto Loop1

    #----------------------------------------------------------------------
    # Do Swap
    #----------------------------------------------------------------------
    addi $sp, $sp, -20       # Make 5 words STACK
    sw $ra, 16($sp)          #
    sw $a0, 12($sp)          #
    sw $a1, 8($sp)           #
    sw $t0, 4($sp)           #
    sw $t1, 0($sp)           #

    add $a1, $a0, $t1       # a1 = array + j
    add $a0, $a0, $a1       # a0 = array + left
    jal SWAP                 # Call SWAP

    lw $t1, 0($sp)           #
    lw $t0, 4($sp)           #
    lw $a1, 8($sp)           #
    lw $a0, 12($sp)          #
    lw $ra, 16($sp)          #
    addi $sp, $sp, 20        # Clear STACK

Recursive:
    #----------------------------------------------------------------------
    # Quicksort Left
    #----------------------------------------------------------------------
    addi $sp, $sp, -20       # Make 5 words STACK
    sw $ra, 16($sp)          #
    sw $a0, 12($sp)          #
    sw $a1, 8($sp)           #
    sw $a2, 4($sp)           #
    sw $t1, 0($sp)           #

    addi $a2, $t1, -1         # a2 = j - 1
    jal QUICKSORT            # Call QUICKSORT(array, left, j-1 )

    lw $t1, 0($sp)           #
    lw $a2, 4($sp)           #
    lw $a1, 8($sp)           #
    lw $a0, 12($sp)          #
    lw $ra, 16($sp)          #
    addi $sp, $sp, 20        # Clear STACK

    #----------------------------------------------------------------------
    # QuickSort Right
    #----------------------------------------------------------------------
    addi $sp, $sp, -20       # Make 5 words STACK
    sw $ra, 16($sp)          #
    sw $a0, 12($sp)          #
    sw $a1, 8($sp)           #
    sw $a2, 4($sp)           #
    sw $t1, 0($sp)           #

    addi $a1, $t1, 1          # a1 = j + 1
    jal QUICKSORT            # Call QUICKSORT(array, j+1, right )

    lw $t1, 0($sp)           #
    lw $a2, 4($sp)           #
    lw $a1, 8($sp)           #
    lw $a0, 12($sp)          #
    lw $ra, 16($sp)          #
    addi $sp, $sp, 20        # Clear STACK

    jr $ra                   # return

#----------------------------------------------------------------------
#    Swap Function
#
#    a0 = &a, a1 = &b
#----------------------------------------------------------------------
SWAP:
    lw $t0, 0($a0)           #
    lw $t1, 0($a1)           #
    sw $t1, 0($a0)           #
    sw $t0, 0($a1)           #
    jr $ra                   # return
