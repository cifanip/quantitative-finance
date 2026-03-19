---
title: Sliding Window Maximum
layout: default
---

# Sliding Window Maximum

Original problem: [https://leetcode.com/problems/two-sum/](https://leetcode.com/problems/sliding-window-maximum/)

---

## My summary

Given an array of integers, return indices of two numbers such that they add up to a target.

---

## Approach

Use a hash map to store previously seen numbers.

For each number:
- compute complement
- check if it exists
- otherwise store current number

---

## Complexity

- Time: O(n)
- Space: O(n)

---

## Solution (Python)

```python
def twoSum(nums, target):
    seen = {}

    for i, num in enumerate(nums):
        need = target - num
        if need in seen:
            return [seen[need], i]
        seen[num] = i
