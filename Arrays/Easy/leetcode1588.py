#My submitted solution
class Solution:
    def sumOddLengthSubarrays(self, arr: List[int]) -> int:
        prefix_sum = [0]*len(arr)
        
        prefix_sum[0] = arr[0]
        
        sum = 0
        
        for i in range(1,len(arr)):
            prefix_sum[i] = prefix_sum[i-1]+arr[i]
        
        for i in range(1,len(arr)):
            for j in range(i,len(arr)):
                if (j-i+1)%2:
                    sum+=prefix_sum[j]-prefix_sum[i-1]
            
            if i%2==0:
                sum+=prefix_sum[i]
                
        sum+=prefix_sum[0]
                    
        return sum
    
    
#Optimal Solution
class Solution:
    def sumOddLengthSubarrays(self, A: List[int]) -> int:
        ans, n = 0, len(A)
        for i, v in enumerate(A):
            ans += ((i+1) * (n-i) + 1) // 2 * A[i]
        return ans
