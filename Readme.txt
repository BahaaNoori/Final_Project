# Python script for substring analysis of Genomic Data: DSP39_Final Exam
Analyzing the number of substrings in a longer string of genomic data is a vital step in genomic analysis. When an experiment is run, the output is genomic data. This genomic data is made up of “T”, “C”, “G”, and “A”, thus the string is made up of 4 letters. Most of this data is huge and it can’t be analyzed by humans. So we need a machine to do it for us. For this purpose, we can use Python to create functions that can run through our data and output the files that will be readable to humans. In this repository will be a testing file and a script to test the string of genomic data and output files that will provide some information about that string. 

# Testing the python script 
This repository includes a python file (test_exam_4.py) for the exam_4.py. These tests are used to verify that the code is working fine and there are no possible error that might rise from human neglect. This file also include assertions within each function to notify the user of any errors when incorrect k-vale is entered (a fraction or negative) or the string contain letters that are not part of the genomic letter (“T”, “C”, “G”, and “A”). 

# Running the script
In this repository, there is a python script (exam_4.py) made to analyze the number of substrings in a longer string of genomic data.  If this is used to read a .txt file containing one or more string of letter, the code will give files that contains data frames for each of those strings. Each data frame will contain a k-values, observed substrings values, and substrings possible values. K-value is the k-mar which is the length of the substrings. The ranges of those k-values can be from 1 to the entire length of the string.  The code will also print the linguistic complexity of each string. 

#Definitions: 
Substrings possible: is the minimum number of substrings possible for a given k value.
Observed substrings is a count of the number of unique substrings that are observed out of those possible.
Linguistic complexity is the sum of the observed substrings for each value k divided by the sum of the possible substrings.

#To run this script: 
In the Terminal use:  python3 exam_4.py string_of_letters_1.txt
If a .txt file contained one string, the user can expect the terminal output to appear as follows: 
1-	string1 name
2-	Data frame for string1
3-	Linguistic complexity for string1

The command to run the test: 
Command to run tests: py.test test_exam4.py

# Sample text file provided 
A sample text file has been provided to run the script on (string_of_letters_1.txt). The text file contains three strings:
1-	ATTTGGATT
2-	ACTGCAGCGCGATGATGAGAGAGATTTCAGGACACACATTGCCAAATTGAGGCAT
3-	ATATATATATATATATA;

Those three should output two data frames for the first two and an error for the third one (contain a character that is not in the genomic letters). The names of those two files are: ATTTGGATT.csv and ACTGCAGCGCGATGATGAGAGAGATTTCAGGACACACATTGCCAAATTGAGGCAT.csv

