# https://leetcode.com/problems/final-prices-with-a-special-discount-in-a-shop/

# Given the array prices where prices[i] is the price of the ith item in a shop. There is a special discount for items in the shop, if you buy the ith item, then you will receive a discount equivalent to prices[j] where j is the minimum index such that j > i and prices[j] <= prices[i], otherwise, you will not receive any discount at all.
# Return an array where the ith element is the final price you will pay for the ith item of the shop considering the special discount.

# My Solution
class Solution:
    def finalPrices(self, prices: List[int]) -> List[int]:
        n = len(prices)
        ans = []
        
        for i in range(n-1):
            for j in range(i+1,n):
                if prices[j]<=prices[i] and j>i:
                    ans.append(abs(prices[i]-prices[j]))
                    break
            else:   
                ans.append(prices[i])
        
        ans.append(prices[n-1])
        return ans
        
        
# Optimal Solution
class Solution:
	def finalPrices(self, prices: List[int]) -> List[int]:
		ans=[i for i in prices]
		stack=[] #index stack

		# increasing stack
		for i in range(len(prices)):
			while stack and prices[stack[-1]]>=prices[i]:
				idx=stack.pop()
				ans[idx]=ans[idx]-prices[i]
			stack.append(i)

		return ans
  
  
