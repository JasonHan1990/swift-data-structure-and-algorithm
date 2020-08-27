### [15\. 3Sum](https://leetcode.com/problems/3sum/)

Difficulty: **Medium**  

Related Topics: [Array](https://leetcode.com/tag/array/), [Two Pointers](https://leetcode.com/tag/two-pointers/)


Given an array `nums` of _n_ integers, are there elements _a_, _b_, _c_ in `nums` such that _a_ + _b_ + _c_ = 0? Find all unique triplets in the array which gives the sum of zero.

**Note:**

The solution set must not contain duplicate triplets.

**Example:**

```
Given array nums = [-1, 0, 1, 2, -1, -4],

A solution set is:
[
  [-1, 0, 1],
  [-1, -1, 2]
]
```

#### Solution 1, Use a set to remove duplicates

Language: **Swift**

```swift
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
         if nums.count < 3 { return [[Int]]() }
        // SORT
        let nums = nums.sorted()
        print(nums)
        var ans = Set<[Int]>()
        for a in 0..<nums.count - 2 {
            var b = a + 1, c = nums.count - 1
            while b < c {
                if nums[a] + nums[b] + nums[c] > 0 {
                    c -= 1
                } else if nums[a] + nums[b] + nums[c] < 0 {
                    b += 1
                } else {
                    ans.insert([nums[a], nums[b], nums[c]])
                    b += 1
                    c -= 1
                }
            }
        }
        return Array(ans)
    }
}
```

#### Solution 2, Take advantage of sorting to remove duplicates

Language: **Swift**

```swift
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let nums = nums.sorted()
        var res = [[Int]]()
        
        var i = 0
        while i < nums.count - 2 {
            var j = i + 1, k = nums.count - 1
            while j < k {
                let sum = nums[i] + nums[j] + nums[k]
                
                if sum == 0 {
                    res.append([nums[i], nums[j], nums[k]])
                    j += 1
                    k -= 1
                    // remove duplicates for j and k
                    while j < k, nums[j] == nums[j - 1] { j += 1 }
                    while j < k, nums[k] == nums[k + 1] { k -= 1 }
                } else if sum < 0 {
                    j += 1
                } else {
                    k -= 1
                }
            }
            // remove duplicates for i
            while i < nums.count - 2, nums[i] == nums[i + 1] {
                i += 1
            }
            i += 1
        }
        
        return res
    }
}
```