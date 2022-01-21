# https://leetcode.com/problems/merge-two-sorted-lists/

# You are given the heads of two sorted linked lists list1 and list2.
# Merge the two lists in a one sorted list. The list should be made by splicing together the nodes of the first two lists.
# Return the head of the merged linked list.

# My Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        list3 = ListNode(0,None)
        head = list3
        while list1 and list2:
            if list1.val < list2.val:
                list3.next = ListNode(list1.val)
                list3 = list3.next
                list1 = list1.next
            else:
                list3.next = ListNode(list2.val)
                list3 = list3.next
                list2 = list2.next
                
        while list2:
            list3.next = ListNode(list2.val)
            list3 = list3.next
            list2 = list2.next
                
        while list1:
            list3.next = ListNode(list1.val)
            list3 = list3.next
            list1 = list1.next

        return head.next
      
      
# Optimal Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        if not list1 and not list2:
            return None
        dummy = ListNode(-1)
        curr = dummy
        i = list1
        j = list2
        while i and j:
            if i.val <= j.val:
                curr.next = i
                i = i.next
            else:
                curr.next = j
                j = j.next
            curr = curr.next
        while i:
            curr.next = i
            curr = curr.next
            i = i.next
        while j:
            curr.next = j
            curr = curr.next
            j = j.next
        return dummy.next
      
      
