### [18\. 4Sum](https://leetcode.com/problems/4sum/)

Difficulty: **Medium**  

Related Topics: [Array](https://leetcode.com/tag/array/), [Hash Table](https://leetcode.com/tag/hash-table/), [Two Pointers](https://leetcode.com/tag/two-pointers/)


Given an array `nums` of _n_ integers and an integer `target`, are there elements _a_, _b_, _c_, and _d_ in `nums` such that _a_ + _b_ + _c_ + _d_ = `target`? Find all unique quadruplets in the array which gives the sum of `target`.

**Note:**

The solution set must not contain duplicate quadruplets.

**Example:**

```
Given array nums = [1, 0, -1, 0, -2, 2], and target = 0.

A solution set is:
[
  [-1,  0, 0, 1],
  [-2, -1, 1, 2],
  [-2,  0, 0, 2]
]
```


#### Solution

Language: **Swift**

```swift
class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count < 4 { return [[Int]]() }
        let nums = nums.sorted()
        var ans = Set<[Int]>()
        for a in 0..<nums.count - 3 {
            for b in a + 1..<nums.count - 2 {
                var l = b + 1, r = nums.count - 1
                while l < r {
                    let sum = nums[a] + nums[b] + nums[l] + nums[r]
                    if sum < target {
                        l += 1
                    } else if sum > target {
                        r -= 1
                    } else {
                        ans.insert([nums[a], nums[b], nums[l], nums[r]])
                        l += 1
                        r -= 1
                    }
                }
            }
        }
        return Array(ans)
    }
}
```