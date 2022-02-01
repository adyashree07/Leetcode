# https://leetcode.com/problems/best-time-to-buy-and-sell-stock/

# You are given an array prices where prices[i] is the price of a given stock on the ith day.
# You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.
# Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

# My Solution
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        n = len(prices)
        buy = [0]*n
        sell = [0]*n
        
        buy[0] = prices[0]
        sell[n-1] = prices[n-1]
        
        for i in range(1,n):
            buy[i] = min(buy[i-1],prices[i])
        
        for i in range(n-2,-1,-1):
            sell[i] = max(sell[i+1],prices[i])
        
        profit = 0
        for i in range(n):
            if sell[i]-buy[i]> profit:
                profit = sell[i]-buy[i]
                
        return profit
            
        
# Optimal Solution
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        if len(prices) == 1:
            return 0
        
        lowest = prices[0]
        highest = 0
        local_max = 0
        global_max = 0
        for price in prices:
            if price < lowest:
                lowest = price
                highest = 0
                local_max = 0
            elif price > highest:
                highest = price
                local_max = highest - lowest
                global_max = max(global_max, local_max)
                
        return global_max
      
      
