#https://leetcode.com/problems/two-sum/
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:    
        sort_num = sorted(((v,i) for i,v in enumerate(nums)),reverse=False)
        
        print(sort_num)
        
        for i in range(len(sort_num)-1):
            num = target - sort_num[i][0]
            
            low = i+1
            high = len(nums)-1
            mid = int((low+high)/2)
            
            while low<=high:
                if num==sort_num[mid][0]:
                    end = sort_num[mid][1]
                    start = sort_num[i][1]
                    break
                elif num>sort_num[mid][0]:
                    low = mid+1
                elif num<sort_num[mid][0]:
                    high = mid-1
                    
                mid = int((low+high)/2)
    
        return [start,end]
