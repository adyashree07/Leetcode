# https://leetcode.com/problems/design-hashset/

# Design a HashSet without using any built-in hash table libraries.
# Implement MyHashSet class:
# 1. void add(key) Inserts the value key into the HashSet.
# 2. bool contains(key) Returns whether the value key exists in the HashSet or not.
# 3. void remove(key) Removes the value key in the HashSet. If key does not exist in the HashSet, do nothing.

# My Solution
class MyHashSet:

    def __init__(self):
        self.S = [False]*(10**6+1)
        

    def add(self, key: int) -> None:
        self.S[key] = True
        

    def remove(self, key: int) -> None:
        self.S[key] = False
        

    def contains(self, key: int) -> bool:
        return self.S[key]
      
      
# Optimal Solution (Violates the question)
class MyHashSet:

    def __init__(self):
        self.my_set = set()
        

    def add(self, key: int) -> None:
        self.my_set.add(key)
        

    def remove(self, key: int) -> None:
        if key in self.my_set:
            self.my_set.remove(key)
        

    def contains(self, key: int) -> bool:
        return key in self.my_set
