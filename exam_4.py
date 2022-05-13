#!/usr/bin/env python3

#import to be able to make dataframe at the end
import pandas as pd  


#Define a function for possible substrings: 
def substring_poss_f(string_of_letters,k):
    '''input is a string of letters (containing only A,G,T,C) and a k-value (the length of new substrings wanted)
    returns the minimum possible number of substrings'''
    assert k > 0, 'Use a k-value that is not negative' # This will give an error if negative k values are entered
    for letter in string_of_letters:
        assert letter in ["A","G","T","C"], 'string includes characters are not possible: characters must be A,G,T,C only' #This will give an error if the any letter is entered that is not  A,G,T, or C.
    assert type(k) is int, 'k must be a whole number' #If k is not an integer this will give an error message
    substring_possible= len(string_of_letters) - k + 1
    combo_possible= 4**k
    return(min(substring_possible, combo_possible)) #there are two options for possible k-mers above. We only want to return the lesser of the two. 



#Define a function for observed substrings: 
def observed_substring_f(string_of_letters,k):
    '''input is a string of letters (containing only A,G,T,C) and a k-value (the length of new substrings wanted)
    returns the number unique observed substrings'''
    newlst=[] #we make a blank list to add the unique values onto as the k-value increases the value will be added to this list.
    assert k > 0, 'k cannot be negative'
    for letter in string_of_letters:
        assert letter in ["A","G","T","C"], 'string includes characters are not possible: characters must be A,G,T,C only'
    assert type(k) is int, 'k must be a whole number'
    observed_substrings= [string_of_letters[i:i+k] for i in range(0,len(string_of_letters),1)] #1 allows the loop to move character by character
    for i in range(0,len(observed_substrings)):
        if(len(observed_substrings) == k):
            observed_substrings.pop()
        for item in observed_substrings:
            if len(item) == k:
                newlst.append(item) #adds unique items to the file
    new_set=set(newlst)
    unique_list=list([new_set]) #Give an output in a list format so that the length can be determined, and therefore the amount of unique observed k-mers. 
    for x in unique_list:
        return(len(x))   


#Define a function for creating a dataframe: 
def create_df(string_of_letters): 
    '''input is a string of letters (containing only A,G,T,C)
    returns data frame containing the range of possible k-values, and the number of possible and observed substrings for each k value'''
    obslist=[] #we make a blank lists to append onto as we loop through the string. The output of the functions will be added to this list as as k increases. 
    poslist=[]
    kvalues=[] 
    for k in range(1,len(string_of_letters)+1): #looping through full length of the string 
        obskmers= observed_substring_f(string_of_letters, k)
        obslist.append(obskmers)
    for k in range(1,len(string_of_letters)+1):    
        poskmers= substring_poss_f(string_of_letters, k)
        poslist.append(poskmers)
    for k in range(1,len(string_of_letters)+1):
        kvalues.append(k)
    data=({'k' : kvalues,
          'observedkmers': obslist,
          'possiblekmers': poslist }) #Collecting the data for the dataframe
    df=pd.DataFrame(data) #using panda to make the data frame
    df.to_csv((string_of_letters)+'.csv') #outputting the data frames to csv files named after each string (ex. TATA exported as TATA.csv). They may take a some time to load. 
    return(df) 

#Define function for linguistic complexity: 
def ling_comp(string_of_letters):
    '''input is a string of letters (containing only A,G,T,C)
    returns the linguistic complexity: the sum of the number of substrings observed for each k divided by the sum of the substrings possible for each k'''
    obslist_ling=[] #just like in the df function, we start with blank lists to append onto as the loops progress
    poslist_ling=[]
    for k in range(1,len(string_of_letters)+1):  
        obskmers_ling= observed_substring_f(string_of_letters, k)
        obslist_ling.append(obskmers_ling) #creating list of observable k-mers ouput 
    for k in range(1,len(string_of_letters)+1):    
        poskmers_ling= substring_poss_f(string_of_letters, k)
        poslist_ling.append(poskmers_ling) #creating list of possible k-mers ouput 
    return((sum(obslist_ling))/(sum(poslist_ling))) #Dividing the sum of observed by the sum of the possible 



#The following code will be run if the script itself is being run. This code will not run when the .py is being tested 

if __name__ == '__main__':
    string_of_letters_full= 'string_of_letters_1.txt'
    with open(string_of_letters_full, "r") as f:
        for eachline in f:   
            eachline = eachline.strip() #Removing any "new line" characters in the strings
            print(eachline) #Print each line to keep the datframes organized when they print to the terminal 
            print(create_df(eachline)) #Prints the data frame to the terminal 
            print(ling_comp(eachline)) #Prints the linguistic complexity
            
