# https://leetcode.com/problems/reducing-dishes/

# A chef has collected data on the satisfaction level of his n dishes. Chef can cook any dish in 1 unit of time.
# Like-time coefficient of a dish is defined as the time taken to cook that dish including previous dishes multiplied by its satisfaction level i.e. time[i] * satisfaction[i].
# Return the maximum sum of like-time coefficient that the chef can obtain after dishes preparation.
# Dishes can be prepared in any order and the chef can discard some dishes to get this maximum value.


# My Solution
class Solution:
    def maxSatisfaction(self, satisfaction: List[int]) -> int:
        satisfaction.sort()
        n = len(satisfaction)

        neg = []
        pos = []
        for i in range(n):
            if satisfaction[i] < 0:
                neg.append(satisfaction[i])
            else:
                pos.append(satisfaction[i])
        
        if len(neg)==n:
            return 0

        res = 0
        if len(neg)==0:
            for i in range(len(pos)):
                res += pos[i]*(i+1)
            return res

        ans = 0
        max_ans = -1000
    
        for i in range(len(neg)):
            cnt = 1
            ans = 0
            
            for i in neg:
                ans += (i*cnt)
                cnt += 1

            for j in pos:
                ans += (j*cnt)
                cnt += 1
        
            if len(neg)>0:
                neg.pop(0)
            
            max_ans = max(ans, max_ans)

        return max_ans


# Optimized Solution
class Solution:
    def maxSatisfaction(self, satisfaction: List[int]) -> int:
        satisfaction.sort(reverse = True)
        
        ans = 0
        res = 0

        for i in satisfaction:
            res += i

            if res < 0:
                break
            
            ans += res

        return ans

      
