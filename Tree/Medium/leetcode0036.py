#https://leetcode.com/problems/valid-sudoku/

# Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:
# 1. Each row must contain the digits 1-9 without repetition.
# 2. Each column must contain the digits 1-9 without repetition.
# 3. Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.
# Note:
# 1. A Sudoku board (partially filled) could be valid but is not necessarily solvable.
# 2. Only the filled cells need to be validated according to the mentioned rules.

#My Solution
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        
        #Check Rows
        for i in range(9):
            d = dict()
            for j in range(9):
                if board[i][j] == ".":
                    pass
                elif board[i][j] not in d:
                    d[board[i][j]] = 1
                else:
                    return False
                
        #Check columns
        for j in range(9):
            d = dict()
            for i in range(9):
                if board[i][j] == ".":
                    pass
                elif board[i][j] not in d:
                    d[board[i][j]] = 1
                else:
                    return False
                
        #Check 3x3 sub-boxes
        for r in range(0,9,3):
            for c in range(0,9,3):
                d = dict()
                for i in range(r,r+3):
                    for j in range(c,c+3):
                        if board[i][j] == ".":
                            pass
                        elif board[i][j] not in d:
                            d[board[i][j]] = 1
                        else:
                            return False 
                        
        return True
        
        
#Optimal Solution
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:

        for row in board:
            arr= []
            for elem in row:
                if elem != ".":
                    if elem in arr:
                        return False
                    arr.append(elem)
      
    
        for i in range(len(board[0])):
            arr= []
            for j in range(len(board)):
                if board[j][i] != ".":
                    if board[j][i] in arr:
            
                        return False
                    arr.append(board[j][i])
        r = 0
        c = 0
    
        for i in range(1,10):
            arr= []
            for j in range(3):
                for k in range(3):
                    if board[r+j][c+k] != ".":
                        if board[r+j][c+k] in arr:
                            print("ya")
                            return False
                        arr.append(board[r+j][c+k])
            
            if i%3 == 0:
                r+=3
                c=0
                
            else:
                c+=3
        return True
    
    
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        N = 9
        rows = [set() for _ in range(N)]
        cols = [set() for _ in range(N)]
        boxes = [set() for _ in range(N)]
        for r in range(N):
            for c in range(N):
                val = board[r][c]
                if val == ".":
                    continue
                if val in rows[r]: return False
                rows[r].add(val)
                if val in cols[c]: return False
                cols[c].add(val)
                idx = (r // 3) * 3 + c // 3
                if val in boxes[idx]: return False
                boxes[idx].add(val)
        return True
    
    
    
