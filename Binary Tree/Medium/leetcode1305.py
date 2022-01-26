# https://leetcode.com/problems/all-elements-in-two-binary-search-trees/

# Given two binary search trees root1 and root2, return a list containing all the integers from both trees sorted in ascending order.

# My Solution
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def inorder(self, root, ans):
        if root==None:
            return None
        self.inorder(root.left,ans)
        ans.append(root.val)
        self.inorder(root.right, ans)
        
        return ans
    def getAllElements(self, root1: TreeNode, root2: TreeNode) -> List[int]:
        ans1 = []
        ans2 = []
        res = []
        ans1= self.inorder(root1,ans1)
        ans2 = self.inorder(root2,ans2)
        
        i = 0
        j = 0
        
        while ans1 and ans2 and i<len(ans1) and j<len(ans2):
            if ans1[i]<ans2[j]:
                res.append(ans1[i])
                i += 1
            else:
                res.append(ans2[j])
                j += 1
                
        while ans1 and i<len(ans1):
            res.append(ans1[i])
            i += 1
        while ans2 and j<len(ans2):
            res.append(ans2[j])
            j += 1
        return res
        
        
# Optimal Solution
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def getAllElements(self, root1: TreeNode, root2: TreeNode) -> List[int]:
        valueList = []
        def traverse(node):
            if node:
                traverse(node.left)
                valueList.append(node.val)
                traverse(node.right)
        traverse(root1)
        traverse(root2)
        return sorted(valueList)
    
    
