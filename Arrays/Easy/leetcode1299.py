# https://leetcode.com/problems/replace-elements-with-greatest-element-on-right-side/
  
# Given an array arr, replace every element in that array with the greatest element among the elements to its right, and replace the last element with -1.
# After doing so, return the array.

#My Solution
class Solution:
    def replaceElements(self, arr: List[int]) -> List[int]:
        n = len(arr)
        
        out = [0]*n
        
        out[n-1] = -1
        
        for i in range(n-2,-1,-1):
            out[i] = max(out[i+1],arr[i+1])
            
        return out
        
        
#Optimal Solution
class Solution:
    def replaceElements(self, arr: List[int]) -> List[int]:
        max=arr[len(arr)-1]
        arr[len(arr)-1]=-1
        for i in range(len(arr)-2,-1,-1):
            temp=arr[i]
            arr[i]=max
            if temp>max:
                max=temp
            
            
        return arr
      
      
