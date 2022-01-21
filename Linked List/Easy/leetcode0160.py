# https://leetcode.com/problems/intersection-of-two-linked-lists/

# Given the heads of two singly linked-lists headA and headB, return the node at which the two lists intersect. If the two linked lists have no intersection at all, return null.
# For example, the following two linked lists begin to intersect at node c1:
# The test cases are generated such that there are no cycles anywhere in the entire linked structure.
# Note that the linked lists must retain their original structure after the function returns.
# Custom Judge:
# The inputs to the judge are given as follows (your program is not given these inputs):
# intersectVal - The value of the node where the intersection occurs. This is 0 if there is no intersected node.
# 1. listA - The first linked list.
# 2. listB - The second linked list.
# 3. skipA - The number of nodes to skip ahead in listA (starting from the head) to get to the intersected node.
# 4. skipB - The number of nodes to skip ahead in listB (starting from the head) to get to the intersected node.
# The judge will then create the linked structure based on these inputs and pass the two heads, headA and headB to your program. If you correctly return the intersected node, then your solution will be accepted.

# My Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None
class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> Optional[ListNode]:
        visited = set()
        point1 = headA
        point2 = headB
        
        while point1:
            visited.add(point1)
            point1 = point1.next
            
        while point2:
            if point2 in visited:
                return point2
            
            point2 = point2.next
            
            
# Optimal Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None
class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> Optional[ListNode]:
        if not headA or not headB:
            return None
    
        curA = headA
        curB = headB
        switched = False
        
        while curA and curB:
            if curA == curB:
                return curA
            curA = curA.next
            curB = curB.next
            if not curA:
                curA = headB
            if not curB and not switched:
                curB = headA
                switched = True
        return None
            
           
