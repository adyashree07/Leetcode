# https://leetcode.com/problems/unique-morse-code-words/

# International Morse Code defines a standard encoding where each letter is mapped to a series of dots and dashes, as follows:
# 1. 'a' maps to ".-",
# 2. 'b' maps to "-...",
# 3. 'c' maps to "-.-.", and so on.
# For convenience, the full table for the 26 letters of the English alphabet is given below:

# [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
# Given an array of strings words where each word can be written as a concatenation of the Morse code of each letter.
# - For example, "cab" can be written as "-.-..--...", which is the concatenation of "-.-.", ".-", and "-...". We will call such a concatenation the transformation of a word.
# Return the number of different transformations among all words we have.

# My Solution
class Solution:
    def uniqueMorseRepresentations(self, words: List[str]) -> int:
        morse_code = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        
        encoded = []
        
        for i in words:
            s = ""
            for j in i:
                s+=morse_code[ord(j)-97]
                
            encoded.append(s)
            
        return len(set(encoded))
            
        
# Optimal Solution
morse  = { 'a':'.-', 'b':'-...', 
                'c':'-.-.', 'd':'-..', 'e':'.', 
                'f':'..-.', 'g':'--.', 'h':'....', 
                'i':'..', 'j':'.---', 'k':'-.-', 
                'l':'.-..', 'm':'--', 'n':'-.', 
                'o':'---', 'p':'.--.', 'q':'--.-', 
                'r':'.-.', 's':'...', 't':'-', 
                'u':'..-', 'v':'...-', 'w':'.--', 
                'x':'-..-', 'y':'-.--', 'z':'--..'}
class Solution:
    def uniqueMorseRepresentations(self, words: List[str]) -> int:
        return len(set(["".join(map(lambda i: morse[i], word)) for word in words]))
      
      
