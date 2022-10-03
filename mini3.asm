.data 
	msg1: .asciiz "Please input an integer value greater than or equal to 0: "
	msg2: .asciiz "The value you entered is less than zero. This program only works with values greater than or equal to zero."
	answerMsg1: .asciiz "Your input: "
	answerMsg2: .asciiz "\nThe factorial is: "
	redoMsg: .asciiz "\nInput Y to find another factorial! Any other input wil exit the program: "
	yes: .byte 'Y'
	newLine: .asciiz "\n"


##########################################TEXT########################################################################################
.text

	main: 
	
		#Starts the program with a blank line for readability
		la $a0, newLine
		li $v0, 4
		syscall
	
	
		#Displays a message asking the user to input a number and saves the number
		la $a0, msg1
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $s0,$v0
		

		#Checks input number is greater than or equal to 0
		blt $v0, $0,  exit 
		
		
		#Calls factorial helper 
		move $a0, $v0 
 		jal factorial
 		move $a1, $v0
 		
		#Prints out the users input
		li $v0, 4
 		la $a0, answerMsg1
 		syscall
 		li $v0, 1 
   		move $a0, $s0 
    		syscall
		
		#Prints out the factorial of the users input
 		li $v0, 4
 		la $a0, answerMsg2
 		syscall
 		move $a0, $a1
 		add $v0,$0,1
 		syscall
 		
 		
		#Asks the user if they want to find another factorial and saves answer 
		la $a0, redoMsg
		li $v0, 4
		syscall
		li $v0,12
		syscall
		move $s0, $v0
		
		#Loads the Y character that would indicate the user wants another factorial
		lb $s1, yes
		
		#Branches to main if the users input matches Y
		beq $s0,$s1, main 
		
		#End of main	
   		li $v0, 10
   		syscall
   	

	#Factorial helper 
 	factorial:
 
 		#Uses the stack for the subroutines
 		addi $sp, $sp-4
       		sw $ra, ($sp)
       		add $v0,$0,1
 	
 		#Performs the multiplication needed for factorial
       		multiply:
        		beq $a0, $zero, done
       			mul $v0, $v0, $a0
        		addi $a0, $a0, -1
        		j multiply
        	 
      		#Jumps back when base case is reached 		
    		done:
    		lw $ra, ($sp)
    		jr $ra
    	
    	
    	#Exit helper function						
	exit:
	
		la $a0, msg2
		li $v0, 4
		syscall
	
		li $v0, 10
		syscall
		
  
    		
		
	

