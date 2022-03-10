# https://leetcode.com/problems/minimum-number-of-operations-to-move-all-balls-to-each-box/

# You have n boxes. You are given a binary string boxes of length n, where boxes[i] is '0' if the ith box is empty, and '1' if it contains one ball.
# In one operation, you can move one ball from a box to an adjacent box. Box i is adjacent to box j if abs(i - j) == 1. Note that after doing so, there may be more than one ball in some boxes.
# Return an array answer of size n, where answer[i] is the minimum number of operations needed to move all the balls to the ith box.
# Each answer[i] is calculated considering the initial state of the boxes.

# My Solution
class Solution:
    def minOperations(self, boxes: str) -> List[int]:
        index = []
        ans = []
        
        for i in range(len(boxes)):
            if boxes[i]=="1":
                index.append(i)
                
        for i in range(len(boxes)):
            sum = 0
            for j in range(len(index)):
                sum += abs(i-index[j])
            ans.append(sum)
            
        return ans
                

# Alternate Solution
class Solution:
    def minOperations(self, boxes: str) -> List[int]:
    # boxes      11010
    # leftCount  01223
    # leftCost   01358
    # rightCount 21100
    # rightCost  42100
    # ans        43458   
        leftCount = self.left_count(boxes)
        leftCost = self.left_add(leftCount)
            
        rightCount = self.left_count(boxes[::-1])
        rightCost = self.left_add(rightCount)
        rightCost.reverse()
        return [i+j for i,j in zip(leftCost, rightCost)]
            
    def left_count(self, boxes):
        leftCount = [0] * len(boxes)
        for i in range(1,len(boxes)):
            leftCount[i] = int(boxes[i-1]) + leftCount[i-1]
            #L[i] = nums[i - 1] * L[i - 1] # 1,2,3,4 -> 1,1,2,6
        return leftCount
    
    def left_add(self, leftCount):
        leftCost = [0] * len(leftCount)
        for i in range(1,len(leftCount)):
            leftCost[i] = leftCount[i] + leftCost[i-1]
        return leftCost 
    
    
