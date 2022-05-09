# https://leetcode.com/problems/letter-combinations-of-a-phone-number/

# Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.
# A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

# My Solution
class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        mapping = dict()
        count = 2
        
        i = 97
        while count<=9:
            if count!=9 and count!=7:
                mapping[count] = list(map(chr,[*range(i,i+3,1)]))
                i +=3
            else:
                mapping[count] = list(map(chr,[*range(i,i+4,1)]))
                i += 4
            count += 1
            
        if len(digits)==0:
            return ""
            
        ans = mapping[int(digits[0])]
        for i in digits[1:]:
            ans = ["".join(p) for p in product(ans, mapping[int(i)])]
            
        return ans
            
        
# Optimal Solution
digits_to_letters_map = { '2': 'abc',
                          '3': 'def',
                          '4': 'ghi',
                          '5': 'jkl',
                          '6': 'mno',
                          '7': 'pqrs',
                          '8': 'tuv',
                          '9': 'wxyz',
                          }

class Solution:
    @staticmethod
    def letter_combinations_helper(digits: str, i_digits: int, curr_str: str, result_list: List[str]) -> None:
        letters_to_add = digits_to_letters_map[digits[i_digits]]

        for char in letters_to_add:
            new_str = curr_str + char

            if i_digits + 1 == len(digits):
                result_list.append(new_str)

            else:
                Solution.letter_combinations_helper(digits, i_digits + 1, new_str, result_list)

    def letterCombinations(self, digits: str) -> List[str]:
        if len(digits) == 0:
            return []

        result_list = []

        Solution.letter_combinations_helper(digits, 0, "", result_list)

        return result_list
      
      
 # Optimal Solution-2
class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        if not digits:
            return []

        a = ord("a")
		# declare a dict for each digit that refers to letters as on real phone button
        d = {str(i): tuple(chr(a + 3 * (i - 2) + int(i >= 8) + j) for j in range(3 + int(i in (7, 9)))) for i in range(2, 10)}
        
		# generator for combinations
        def gen(prev: str = "", indice: int = 0):
            if len(prev) == len(digits):
                yield prev
            else:
                for c in d[digits[indice]]:
                    yield from gen(prev + c, indice + 1)
            
        return list(gen())
      
      
