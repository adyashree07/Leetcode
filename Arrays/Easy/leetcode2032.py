# https://leetcode.com/problems/two-out-of-three/
  
# Given three integer arrays nums1, nums2, and nums3, return a distinct array containing all the values that are present in at least two out of the three arrays. 
# You may return the values in any order.

# My Solution
class Solution:
    def twoOutOfThree(self, nums1: List[int], nums2: List[int], nums3: List[int]) -> List[int]:
        
        freq = dict()
        
        nums1 = list(set(nums1))
        nums2 = list(set(nums2))
        nums3 = list(set(nums3))
        
        for i in range(len(nums1)):
            if nums1[i] not in freq:
                freq[nums1[i]] = 1
                
        for j in range(len(nums2)):
            if nums2[j] not in freq:
                freq[nums2[j]] = 1
            else:
                freq[nums2[j]] += 1
                
        for j in range(len(nums3)):
            if nums3[j] not in freq:
                freq[nums3[j]] = 1
            else:
                freq[nums3[j]] += 1
        
        ans = []
        for k,v in freq.items():
            if v>=2:
                ans.append(k)
                
        return ans
                
        
# Optimal Solution
class Solution:
    def twoOutOfThree(self, nums1: List[int], nums2: List[int], nums3: List[int]) -> List[int]:
        nums1 = set(nums1)
        nums2 = set(nums2)
        nums3 = set(nums3)
        return list((nums1&nums2)|(nums1&nums3)|(nums2&nums3))
              
