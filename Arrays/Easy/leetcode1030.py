# https://leetcode.com/problems/matrix-cells-in-distance-order/

# You are given four integers row, cols, rCenter, and cCenter. There is a rows x cols matrix and you are on the cell with the coordinates (rCenter, cCenter).
# Return the coordinates of all cells in the matrix, sorted by their distance from (rCenter, cCenter) from the smallest distance to the largest distance. You may return the answer in any order that satisfies this condition.
# The distance between two cells (r1, c1) and (r2, c2) is |r1 - r2| + |c1 - c2|.

# My Solution
class Solution:
    def allCellsDistOrder(self, rows: int, cols: int, rCenter: int, cCenter: int) -> List[List[int]]:
        matrix = dict()
        ans = []
        
        for i in range(rows):
            for j in range(cols):
                matrix[i,j] = abs(i-rCenter) + abs(j-cCenter)
            
        matrix = {k: v for k, v in sorted(matrix.items(), key=lambda item: item[1])}
    
        for k in matrix.keys():
            k = list(k)
            ans.append(k)
    
        return ans
        
        
# Optimal Solution
class Solution:
    def allCellsDistOrder(self, rows: int, cols: int, rCenter: int, cCenter: int) -> List[List[int]]:
    
        matrix = [(x, y) for x in range(rows) for y in range(cols)]
        matrix.sort(key = lambda x : abs(x[0] - rCenter) + abs(x[1] - cCenter))
        return matrix
      
      
