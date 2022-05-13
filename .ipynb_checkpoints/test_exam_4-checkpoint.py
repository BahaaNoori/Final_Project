#!/usr/bin/env python3

from exam_4 import *

#First thing is to make sure the length of read in the string is correct 

#observed k-mers: 

#When K and the length of the string are equal, the output should retun 1 for observed. 
def observed_k9():
    ob_substring = ob_substring_f('ATTTGGATT', 9)
    assert ob_substring == 1
    
#If K is bigger than the length of the string that should return 0 
def observed_k10(): 
    ob_substring = ob_substring_f('ATTTGGATT', 10)
    assert ob_substring == 0
    
def observed_k14():
    ob_substring = ob_substring_f('ATATATATATATATATA', 14)
    assert ob_substring == 2

#when k is 1, what the output should be is how many letters are in the string (in this case, there are only 3)
def observed_k1(): 
    ob_substring = ob_substring_f('ATTTGGATT', 1)
    assert ob_substring == 3
    

#Possible k-mers:

def possible_k2(): 
    substring_poss = substring_poss_f('ATTTGGATT', 2)
    assert substring_poss == 8
    
#Possible k-mers should not return any repetition
def possible_k7():  
    substring_poss = substring_poss_f('ATATATATATATATATA', 7)
    assert substring_poss == 11

#When K and the string length are equil, the return should be 1 for possible
def possible_k17(): 
    substring_poss = substring_poss_f('ATATATATATATATATA', 17)
    assert substring_poss == 1


#Linguistic Complexity 

def ling_complexity():
    linguistic_com = ling_comp('ATTTGGATT')
    assert linguistic_com == 0.875

#The outcome for a string that has many repeats should be small number. This will check for that as well as that there are no repetitions being included by the observed.  
def ling_complexity2(): 
    linguistic_com = ling_comp('ATATATATATATATATA')
    assert linguistic_com == 0.2357142857142857
    
def ling_complexity3():
    linguistic_com = ling_comp('ACTGCAGCGCGATGATGAGAGAGATTTCAGGACACACATTGCCAAATTGAGGCAT')
    assert linguistic_com == 0.9738111647139903