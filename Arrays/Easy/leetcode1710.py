# https://leetcode.com/problems/maximum-units-on-a-truck/

# You are assigned to put some amount of boxes onto one truck. You are given a 2D array boxTypes, where boxTypes[i] = [numberOfBoxesi, numberOfUnitsPerBoxi]:
# 1. numberOfBoxesi is the number of boxes of type i.
# 2. numberOfUnitsPerBoxi is the number of units in each box of the type i.
# You are also given an integer truckSize, which is the maximum number of boxes that can be put on the truck. You can choose any boxes to put on the truck as long as the number of boxes does not exceed truckSize.

# Return the maximum total number of units that can be put on the truck.

# My Solution
class Solution:
    def maximumUnits(self, boxTypes: List[List[int]], truckSize: int) -> int:
        box = sorted(boxTypes, key= lambda x: x[1], reverse=True)
        n = len(box)
        total = 0
        total_box = 0
        exist_box = 0
        
        for i in range(n):
            exist_box += box[i][0]
        
        for i in range(n):
            if total_box <= truckSize and truckSize>=box[i][0]:
                total += box[i][0]*box[i][1]
                total_box += box[i][0]
                truckSize -= box[i][0]
        
            else:
                if truckSize>0 and total_box<=exist_box:
                    total += min(truckSize,box[i][0])*box[i][1]
                    truckSize -= box[i][0]
                    total_box += box[i][0]
                
                
        return total
            
        
# Optimal Solution
class Solution:
    def maximumUnits(self, boxTypes: List[List[int]], truckSize: int) -> int:
       boxTypes.sort(key= lambda x:x[1], reverse=True)
        
        totalUnits = 0
        for boxes in boxTypes:
            amountToUse = min(boxes[0], truckSize)
            totalUnits = totalUnits + (amountToUse * boxes[1])
            truckSize -= amountToUse

            if truckSize == 0:
                break

        return totalUnits
      
      
