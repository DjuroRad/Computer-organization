.data 
	buffer_itoa: .space 32
	str2: .asciiz "Element of this array: "
	newline: .asciiz "\n"
	subsequence_with_paranthesis: .asciiz "subsequence {"
	subsequence_after_paranthesis: .asciiz "}\n"
	length_: .asciiz "} length: "
	size_str: .asciiz ", size = "
	filename: .asciiz "inputFile.txt"
	filenameoutput: .asciiz "outputFile.txt"
	space_write: .asciiz " "
	arr: .word 400 # max size is 100 integer values-> 4*100 bytes
	character: .byte 1 #character read
	fileBuffer: .byte 1000
	
	.text
	.globl main
main:

	#open the file
	li $v0, 13 #open file syscall code = 13
	la $a0, filename #load the address of the file name as the first argument
	li $a1, 0 # file flag = read (0)
	li $a2, 0 # file flag = read (0)
	syscall
	move $s0, $v0 #file descriptor saved in $s0 now
	
	li $v0, 14 #read_file syscall = 14
	move $a0, $s0 #pass the file descriptor as the argument
	la $a1, fileBuffer
	li $a2, 25600
	syscall
	

	la $s0, fileBuffer   #storing the pointer to the file in $s0 now
	#la $s3, arr #store the array here
	addi $sp, $sp, -400
	move $s3, $sp
	la $s6, ($sp) #keep starting address of this array in here
	move $s7, $zero # $s7 will contain the number of elements in the array
	#read from file
	readChar:
		move $s4, $zero # $s4 represents the flag in order to control the negative numbers
		move $s1, $zero # $s1 will store the new number
		
		readDigit:
			lb $s2, 0($s0) # $s2 will store the current character
			beq $s2, ' ', exitReadDigit
			beq $s2, $zero, exitReadDigit
			beq $s2, '-', setFlagNegative
			#otherwise it has to be a number in that file ( assuming there is no errors )
			mul $s1, $s1, 10
			
			subi $s2, $s2, '0'
			add $s1, $s1, $s2
			
			
			addi $s0, $s0, 1
			j readDigit
			
			setFlagNegative:
				addi $s4, $zero, 1
				addi $s0, $s0, 1
				j readDigit
				
		exitReadDigit:

		#check the flag
		beq $s4, $zero, continueNonNegative
		#make the number negative otherwise
		li $s5, -1
		xor $s1, $s1, $s5
		addi $s1, $s1, 1
		continueNonNegative:
		
		#li $v0, 1
		#move $a0, $s1
		#syscall
		
		sw $s1, 0($s3)
		addi $s7, $s7, 1 #increase the number of elements
		beq $s2, $zero, exitReadChar
		addi $s0, $s0, 1
		addi $s3, $s3, 4

		j readChar
		
	exitReadChar:
	#make space for the array to be returned
	sll $s5, $s7, 2 # bytes = 4*length
	sub $sp, $sp, $s5
	move $s5, $sp
	#our elements are after this placed inside the arr global address
	move $a0, $s6 # passs the array as our argument
	move $a1, $s7 # number of elements to be passed in $a1
	move $a2, $s5 # return array = a2 / s5
	#program will return the address of the new array in $v0
	#program will return the length of the found array in $v1
	
	jal maxSubsequent
	
	#move $a0, $v0
	#move $a1, $v1
	#jal printArr
	
	move $a0, $v0
	move $a1, $v1 
	jal writeToFile
	
	li $v0, 10
	syscall
	
#this function find and returns the ascending subarray with maximum number of elements
# a1 -> number of elements
# a0 -> address of the array

writeToFile:
	addi $sp, $sp, -36 #nine items to be stored, $s0 ... $s7 and $ra
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	
	move $s1, $a1 # s1 = n
	move $s2, $a0 # s2 = arr
	# Open (for writing) a file that does not exist
  	li   $v0, 13       # system call for open file
  	la   $a0, filenameoutput     # output file name
  	li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  	li   $a2, 0        # mode is ignored
  	syscall            # open a file (file descriptor returned in $v0)
  	move $s6, $v0      # save the file descriptor 
	
	move $s0, $zero# i = 0
	loopWriteFile:
		beq $s0, $s1, exitLoopWriteFile # i<n
		sll $s3, $s0, 2 # s3 = i*4
		add $s3, $s3, $s2
		lw $s3, 0($s3)
		
		#li $v0, 1
		#move $a0, $s3
		#syscall
		
		move $a0, $s3
		jal itoa
		
		#li $v0, 1
		#move $a0, $v1
		#syscall
		# now the string is in $v0!
		move $a0, $v0 # arg1 = string
		move $a1, $v1 # arg2 = number_of_characters
		move $a2, $s6 # arg3 = file descriptor
		jal writeStringToFile
		
		addi $s0, $s0, 1
		j loopWriteFile
	exitLoopWriteFile:
	
	#print size:
	la $a0, size_str # arg1 = string
	li $a1, 9 # arg2 = number_of_characters
	move $a2, $s6 # arg3 = file descriptor
	jal writeStringToFile
	#print size value
	move $a0, $s1
	jal itoa
	# now the string is in $v0!
	move $a0, $v0 # arg1 = string
	move $a1, $v1 # arg2 = number_of_characters
	move $a2, $s6 # arg3 = file descriptor
	jal writeStringToFile
	# Close the file 
  	li $v0, 16       # system call for close file
  	move $a0, $s6      # file descriptor to close
  	syscall            # close file
  
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36 #nine items to be stored, $s0 ... $s7 and $ra
		
	jr $ra

writeStringToFile:
	addi $sp, $sp, -36 #nine items to be stored, $s0 ... $s7 and $ra
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	#make space for the output also, it will be of length of at most N items!
	
			
	# s will correspond to the arguments
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
  	li   $v0, 15       # system call for write to file
  	move $a0, $s2      # file descriptor 
  	move $a1, $s0   # address of buffer from which to write
  	move $a2, $s1       # hardcoded buffer length
  	syscall            # write to file

	li $v0, 15       # system call for write to file
  	move $a0, $s2      # file descriptor 
  	la $a1, space_write   # address of buffer from which to write
  	li $a2, 1       # hardcoded buffer length
  	syscall            # write to file

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36 #nine items to be stored, $s0 ... $s7 and $ra
		
	jr $ra


maxSubsequent:

	# store s0 ... s7
	# store ra
	addi $sp, $sp, -36 #nine items to be stored, $s0 ... $s7 and $ra
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)

	move $t0, $a0 # arr address in #t0
	move $t1, $a1 # n value in $t1
	move $s0, $a1 # initialize the array of indexes with 1s
	sll $s0, $s0, 2 # 10 * 4 -> 40 for 10 elements for example since every element is 4 bytes
	sub $sp, $sp, $s0 #now we have space for the new array we will use
	move $s2, $sp # address of the array in s2, saved in sp
	move $t2, $sp # STORE LIT_I in T2
	move $s1, $zero #simple loop to initialize all the elements to 1
	loopInit:
		
		li $s3,1 
		beq $s1, $a1, exitLoopInit
		sw $s3, 0($s2)
		addi $s2, $s2, 4
		addi $s1, $s1, 1
		j loopInit
	exitLoopInit:
	# array for dynamic programming in $s2 
	# stores the lenght of possible subarrays
	
	li $s7, 1 #max_length will be stored in $s7
	
	li $s0, 1# i = 1 -> $s0

	loop1:
	
		beq $s0, $a1, exitLoop1 # i<n -> if satisfies execute otherwise break the loop
		move $s1, $zero # j= 0 -> $s1
		li $s2, 1 # length = 1 -> $s2
		
		loop2:
			beq $s1, $s0, exitLoop2 # j < i
			
			sll $s3, $s0, 2 # s3 = i*4 -> to get to address place
			add $s3, $s3, $t0 # s3 = arr + i*4
			lw $s3, 0($s3)#s3 -> arr[i]
			
			sll $s4, $s1, 2 # s4 = j*4 -> to get to address place
			add $s4, $s4, $t0 # s4 = arr + j*4
			lw $s4, 0($s4)#s4 -> arr[j]
	
			sll $s5, $s0, 2 # s5 = i*4 -> to get to address place
			add $s5, $s5, $t2 # s5 = lis_i + i*4
			lw $s5, 0($s5)#s5 -> lis_i[i]
			
			sll $s6, $s1, 2 # s5 = j*4 -> to get to address place
			add $s6, $s6, $t2 # s5 = lis_i + j*4
			lw $s6, 0($s6)#s6 -> lis_i[j]
				
			slt $t4, $s4, $s3
			beq $t4, 1, checkLIS_I
			j endCheckLIS_I	
				
			checkLIS_I:
			slt $t4, $s5, $s6
			beq $t4, 1, updateLIS
			beq $s5, $s6, updateLIS
			
			j endUpdateLIS
				updateLIS:
					addi $t5, $s6, 1 # s4 -> lis_i[j] + 1
					sll $s5, $s0, 2 # s5 = i*4 -> to get to address place
					add $s5, $s5, $t2 # s5 = i*4 + lis_i
					sw $t5, 0($s5) # *(lis_i + i*4) = lis_i[j] + 1
					
					addi $s2, $s2, 1 # length = length + 1
					
				endUpdateLIS:
				
				slt $t4, $s7,$s2# if( length > max_length )
				beq $t4, 1, updateMaxLength
				j endUpdateMaxLenght
				updateMaxLength:
					move $s7, $s2
				endUpdateMaxLenght:
			endCheckLIS_I:
			addi $s1, $s1, 1
			j loop2
		exitLoop2:
		
		addi $s0, $s0, 1 # i = i + 1
		j loop1
	exitLoop1:
	
	#restore the $sp
	move $s0, $a1 # initialize the array of indexes with 1s
	sll $s0, $s0, 2 # 10 * 4 -> 40 for 10 elements for example since every element is 4 bytes
	add $sp, $sp, $s0 #now we have space for the new array we will use
	
	
	#prepare to return the results in here
	#length * 4 -> memory size for the return array
	#sll $s0, $s7, 2 # s0 = length*4
	#sub $sp, $sp, $s0 # open length*4 spaces in memory
	move $t5, $a2 #t5 is now pointing to the beginning of our array
	
	# t5 = int new_array[length] ---> its address is t5
	# int curr_el_index = max_length;
	move $s0, $s7 # s0 = max_length   =  curr_el_index
	addi $s1, $t1, -1 # i = n - 1
	
	loopResult:
	beq $s1, -1, exitLoopResult
		#get lis_i[i]
		sll $s2, $s1, 2
		add $s2, $s2, $t2 # i*4 + &lis_i
		lw $s2, 0($s2) # s2 = lis_i[i]
		beq $s2, $s0, addElementToResult
		
		j exitAddElementToResult
		addElementToResult:
			addi $s0, $s0, -1 # --curr_el_index
			#get arr[i]
			sll $s2, $s1, 2
			add $s2, $s2, $t0 # i*4 + &arr
			lw $s2, 0($s2) # s2 = arr[i]
			
			#return_arr[curr_el_index] = arr[i];
			move $s3, $s0
			sll $s3, $s3, 2 # s3 = curr_el_index*4
			add $s3, $s3, $t5 # $s3 = curr_el_index*4 + return_arr
			sw $s2, 0($s3)
		exitAddElementToResult:
	addi $s1, $s1, -1
	j loopResult
	exitLoopResult:
	
	#results
	move $v0, $t5
	move $v1, $s7
	#restore $sp!
	#sll $s0, $s7, 2 # s0 = length*4
	#add $sp, $sp, $s0 # open length*4 spaces in memory
	#reload stored
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36 #nine items to be stored, $s0 ... $s7 and $ra
		
	jr $ra

# v0 = str address
# v1 = char num in str
itoa:
	addi $sp, $sp, -36 #nine items to be stored, $s0 ... $s7 and $ra
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	
	la $s0, buffer_itoa+30  # pointer to almost-end of buffer
      	sb $0, 1($s0)      # null-terminated str
      	
      	move $s6, $zero #length of the string
      	#li $s1, '0'  
      	#sb $s1, ($s0)     # init. with ascii 0
      	li $s3, 10        # preload 10

      	#slt $s2, $a0, $zero   # keep the sign
      	#beq $a0, $zero, iend  # end if 
      	
      	slt $s7, $a0, $zero #s7 flag for negative number
      	
      	beq $s7, 0, loop
      	neg $a0, $a0       # absolute value (unsigned)
	
	loop:
	
      	div  $a0, $s3       # a /= 10
      	mflo $a0
      	mfhi $s4            # get remainder
      	add  $s4, $s4, '0'  # convert to ASCII digit
      	sb   $s4, ($s0)     # store it
      	addi $s0, $s0, -1    # dec. buf ptr
      	addi $s6, $s6, 1    # increase num of char
      	bne  $a0, $zero, loop  # if not zero, loop
      	addi $s0, $s0, 1    # adjust buf ptr
	iend:
	
	# t7 holds the if negative check
	# if t7 is 1 than the number is negative!
      	beq  $s7, 0, endFunction  # was < 0!
      	addi $s0, $s0, -1
      	li   $s1, '-'
      	addi $s6, $s6, 1 # add to the number of characters
      	sb   $s1, ($s0)
	endFunction:
	
      	move $v0, $s0      # return the addr.
      	move $v1, $s6      # return number of characters		
      	
      	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36 #nine items to be stored, $s0 ... $s7 and $ra
	jr   $ra           # of the string





	
