//Program Created by Gregory Campbell
//For class CIS*3190's Assignment 3
//Last updated: April 7th, 2017

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(){
    //Declaration of variables
    FILE *fp;
    char file[100];
    char line[256];
    char word[100];
    int wordLen = 0, lineLen = 0, correct = 0, count = 0;
    int i,j, found = 0;
    
    //Asking user for file name and pattern string
    printf("Input the file you want to read from: \n");
    scanf("%s", file);
    
    printf("Input the word or pattern you want to search for: \n");
    scanf("%s", word);
    
    //Timing of program begins
    clock_t begin = clock();
    
    //Grab length of pattern string
    wordLen = strlen(word);

    //open file
    fp = fopen(file, "r");
    
    //Check if file exists, if not notify user and end program
    if(fp){
    
        printf("Match(s) found at character position: \n");
    
        //Loop through all lines of the file checking for matches
        //If a direct match is found the character position is printed
        while (fgets(line, sizeof(line), fp)) {
        
            if(strcmp(line, "\n") != 0){
                
                lineLen = strlen(line);
                
                //Each file line is loopeed through to see if an exact character match
                //happens when compared to the pattern string
                for(i = 0; i < lineLen; i++){
                    count++;
                    correct = 0;
                    
                    if(line[i] == word[0] && i+wordLen < lineLen){
                    
                        for(j = 0; j < wordLen; j++){
                        
                            if(line[i+j] == word[j]){
                            
                                correct++;
                            
                            }
                        
                        }
                        
                        if(correct == wordLen){
                        
                            printf("%d\n", count);
                            found = 1;
                        
                        }

                    }
                                     
                }
                
            } else {

                count++;
            
            }
        }

    } else {
    
        printf("Error: File not found.\n");
        return 1;
    
    }
    
    //Prints if no matches are found
    if(found == 0){
    
        printf("No Match Found\n");
    
    }

    //File is closed and a second clock time is ran to
    //calculate and display the full program run time in seconds
    fclose(fp);
    
    clock_t end = clock();
    
    double timeSpent = (double)(end - begin) / CLOCKS_PER_SEC;
    
    printf("Total Time (seconds): %f \n", timeSpent);
    
    return 0;
}
