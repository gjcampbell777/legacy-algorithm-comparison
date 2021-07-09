--Program Created by Gregory Campbell
--For class CIS*3190's Assignment 3
--Last updated: April 7th, 2017

with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with Ada.Calendar; use Ada.Calendar;

procedure kmp is 

    -- Declaration of variables
    fp : file_type;
    line : unbounded_string;
    fileName, word : string(1..100);
    wordLen, lineLen, correct, wordCount, fileLen, found : integer;
    StartTime, FinTime : Time;
    milli : Duration;
    
begin
    
    wordCount := 0;
    found := 0;
    
    -- Asking user for file name and pattern string
    put_line("Input the file you want to read from: ");
    get_line(fileName, fileLen);
    
    put_line("Input the word or pattern you want to search for: ");
    get_line(word, wordLen);
    
    -- Timing of program begins
    StartTime := Clock;
    
    -- open file
    open(fp, in_file, fileName);

    put_line("Match(s) found at character position: ");
    
    
    -- Loop through all lines of the file checking for matches
    -- If a direct match is found the character position is printed
    loop
        exit when end_of_file(fp);
        get_line(fp, line);
        
        lineLen := length(line);
        
        -- Each file line is loopeed through to see if an exact character match
        -- happens when compared to the pattern string
        for i in 1..lineLen loop
            wordCount := wordCount + 1;
            correct := 0;
            
            if (Element(line, i)) = word(1) and (i+wordLen) <= lineLen then
        
                for j in 1..wordLen loop
                
                    if (Element(line, (i+j-1))) = word(j) then
                        
                            correct := correct + 1;
                        
                    end if;
                
                end loop;
                
                if(correct = wordLen) then
                    
                    put(wordCount); new_line;
                    found := 1;
                    
                end if;
            
            end if;
        
        end loop;
        wordCount := wordCount + 1;
        
    end loop;
    
    close(fp);
    
    -- Prints if no matches are found
    if(found = 0)then
        put_line("No Match Found");
    end if;
    
    FinTime := Clock;
    milli := (finTime-StartTime);
    
    -- File is closed and a second clock time is ran to
    -- calculate and display the full program run time in seconds
    put_line("Total Time (seconds): " & Duration'Image(FinTime - StartTime)); 
    
    -- Exception if file  doesn't exist, user is notified end program ends
    exception
        when name_error =>
            put_line("Error: File not found.");

end kmp;
