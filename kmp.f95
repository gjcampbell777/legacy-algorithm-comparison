!Program Created by Gregory Campbell
!For class CIS*3190's Assignment 3
!Last updated: April 7th, 2017

program kmp

    implicit none

    ! Declaration of variables
    character(len=100) :: fileName
    character(len=100) :: word
    character(len=9999) :: line
    character :: wordC, lineC
    logical :: lexist
    real :: start, finish, total
    integer :: wordLen, lineLen, correct, wordCount, i, j, eof, found, fileLen
    
    found = 0
    eof = 0
    fileLen = 0
    
    !Asking user for file name and pattern string
    write(*,*) 'Input the file you want to read from: '
    read(*,'(A)') fileName
    
    write(*,*) 'Input the word or pattern you want to search for: '
    read(*,'(A)') word
    
    !Timing of program begins
    call cpu_time(start)
    
    !Grab length of pattern string
    wordLen = len(trim(word))
    
    !Check if file exists, if not notify user and end program
    inquire(file=fileName, exist=lexist)
    
    if(lexist) then
    
        !open file
        open(unit=9, status='old', file=fileName)
        
        write(*,*)'Match(s) found at character position: '
        
        !Loop through all lines of the file checking for matches
        !If a direct match is found the character position is printed
        do
        
            read(9,'(A)', iostat=eof) line
            
            lineLen = len(trim(line))
            fileLen = fileLen + lineLen
            
            
            !Each file line is loopeed through to see if an exact character match
            !happens when compared to the pattern string
            do i = 1, (lineLen+1)
                wordCount = wordCount + 1
                correct = 0
                
                if(line(i:i) == word(1:1) .and. i+wordLen <= lineLen+1) then
            
                    do j = 0, wordLen
                    
                        if(line((i+j):(i+j)) == word(j+1:j+1)) then
                        
                            correct = correct + 1
                        
                        end if
                        
                    end do
                    
                    if(correct >= wordLen .and. eof == 0) then
                    
                        write(*,*) wordCount
                        found = 1
                    
                    end if
                
                end if
            
            end do
            
            if(eof /= 0) exit

        end do

        close (9, status='keep')
            
    else 
        write(*,*) 'Error: File not found.'
    end if
    
    !Prints if no matches are found
    if(found == 0) then
    
        write(*,*) 'No Match Found'
    
    end if
    
    !File is closed and a second clock time is ran to
    !calculate and display the full program run time in seconds
    call cpu_time(finish)
    
    total = (finish-start)
    
    write(*,*) 'Total Time (seconds): ', total

end
