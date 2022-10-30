.data
    head: .asciiz "T H E   F I R S T   T E N   R E V E R S I B L E   P R I M E   S Q U A R E S\n"
    bye: .asciiz "\nB Y E !\n"

.text
    main:
        li $v0, 4
        la $a0, head
        syscall
        
        #assigning integer values to registers
        #$t0 = 0
        #$t1 = 1025000
        move $t0, $0
        addi $t1, $zero, 1025000
        addi, $s3, $0, 1
        
        #initial value in $s0 = 0 which will increase each at each iteration
        addi $s0, $zero, 0
        
        while:

            beq $t0, $t1, exit
            jal FindReverse
            beq $v1, $s0, exit
            
            jal SqrNum
            
            jal NumSqrOfPrime
            bne $a1, $s3, exit
            
            jal RevSqrOfPrime
            bne $a2, $s3, exit
            
            li $v0, 1
            move $a3, $s0
            syscall
            
            addi $s0, $s0, 1
            
            j while
            
            
        exit:
            
    
        li $v0, 4
        la $a0, bye
        syscall
        
    #call to terminte code
    li $v0, 10
    syscall
    
    #A function that works out the reverse of a number
    FindReverse:
    
       #initialising value of reverse
       move $t2, $0
       
       #allocating space in stack for a single integer
       addi $sp, $sp, -4
       
       #saving $s0 in the first position in stack
       sw $s0, 0($sp)
       
       while1:
           beq $s0, $0, end
           div $t3, $s0, 10    # remainder $t3 = $s0 divided by ten
           mul $t3, $t3, 10
           sub $t3, $s0, $t3
           
           #reverse = reverse*10 +remainder
           mul $t4, $t2, 10
           add $t2, $t4, $t3
           
           #$s0 = $s0 / 10
           div $s0, $s0, 10
           
           move $v1, $t2
           
           j while1
           
        end:
        #restoring old value of $s0
        lw $s0, 0($sp)
       
        #retore stack
        addi $sp, $sp, 4
       
       jr $ra
       
       
       
        #A function that checks whether number is a square number
        SqrNum:
            
           addi $sp, $sp, -4
           sw $s0, 0($sp)
           
           
           
           mtc1 $s0, $f1             #put int into floating point register
           cvt.s.w $f1, $f1          #convert int value to float
           
           sqrt.s $f2, $f1           #square root of the float value
           floor.w.s $f3, $f2        #floor-round float
           #cvt.w.s $f3, $f3
           mfc1 $t2, $f3            #convert the floor-rounded square root to int
           
           ceil.w.s $f11, $f2       #ceiling-rounding
           mfc1 $t3, $f11           #float to int
           
           sub $t4, $t3, $t2        #subtract flooring-rounded itn form of square root from ceiling-rounded int form
           
           bnez  $t4, end1           #if the result of subtracting floor. from ceil is not equal to o, execute end1
           mtc1 $t1, $f6             #put int (reverse) into floating point register
           cvt.s.w $f6, $f6          #convert int value to float
           
           sqrt.s $f7, $f6           #square root of the float value
           floor.w.s $f8, $f7        #round float to its integer equivalent
           mfc1 $t5, $f8             #foat to int
           
           ceil.w.s $f9, $f7         #ceiling-rounding
           mfc1 $t6, $f9             #convert to int
           sub $t7, $t6, $t5         #subtract floor. from ceil

           bnez $t7, end1            #if result of subtraction is not equal to 0, execute end2
           addi $a0, $zero, 1        #if result is equal to 0
           syscall
           
           lw $s0, 0($sp)
           addi $sp, $sp, 4
           
           jr $ra
             
           end1:
              addi $a0, $zero, 0
              syscall
             
           
      #A function that checks whether the square root of a number is a prime  
      NumSqrOfPrime:
         addi $s2, $0, 1
         
         addi $sp, $sp, -4
         sw $s0, 0($sp)
         
         mtc1 $s0, $f1             #put int into floating point register
         cvt.s.w $f1, $f1          #convert int value to float
         
         sqrt.s $f2, $f1           #square root of the float value
         cvt.w.s $f2, $f2
         mfc1 $s3, $f2
         
         bne $a0, $s2, end3        #if the result of SqrNum is not 1, execute end3
         
         addi $t8, $0, 2           #start value for the for loop iterations (int i)
        
         #start of for loop
         while2:
             beq $t8, $s3, end3       #when i in $t8 is equal to the square root, execute end4
             
             div  $s3, $t8            #divide square root by i
             
             mfhi $s4                 #remainder
             
             beq $s4, $0, end5
             
             addi, $t8, $t8, 1
             j while2
             
             
             
             
             
             
           
    
    jr $ra
    
    end3:
       move $a1, $s2
       syscall
    
    end5:
        move $a1, $0
        syscall
          
      #A function that checks whether the square root of the reverse of a number is a prime
      RevSqrOfPrime:
          addi $s2, $0, 1
         
         addi $sp, $sp, -4
         sw $v1, 0($sp)
         
         mtc1 $v1, $f1             #put int into floating point register
         cvt.s.w $f1, $f1          #convert int value to float
         
         sqrt.s $f2, $f1           #square root of the float value
         cvt.w.s $f2, $f2
         mfc1 $s3, $f2
         
         bne $a0, $s2, end3        #if the result of SqrNum is not 1, execute end3
         
         addi $t8, $0, 2           #start value for the for loop iterations (int i)
        
         #start of for loop
         while3:
             beq $t8, $s3, end4       #when i in $t8 is equal to the square root, execute end4
             
             div  $s3, $t8            #divide square root by i
             
             mfhi $s4                 #remainder
             
             beq $s4, $0, end8
             
             addi, $t8, $t8, 1
             j while3
             
            
      
    jr $ra
    
    end4:
         move $a2, $s2
         syscall

    end8:
        move $a2, $0

        jr $ra
