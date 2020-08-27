### [16\. 3Sum Closest](https://leetcode.com/problems/3sum-closest/)

Difficulty: **Medium**  

Related Topics: [Array](https://leetcode.com/tag/array/), [Two Pointers](https://leetcode.com/tag/two-pointers/)


Given an array `nums` of _n_ integers and an integer `target`, find three integers in `nums` such that the sum is closest to `target`. Return the sum of the three integers. You may assume that each input would have exactly one solution.

**Example 1:**

```
Input: nums = [-1,2,1,-4], target = 1
Output: 2
Explanation: The sum that is closest to the target is 2\. (-1 + 2 + 1 = 2).
```

**Constraints:**

*   `3 <= nums.length <= 10^3`
*   `-10^3 <= nums[i] <= 10^3`
*   `-10^4 <= target <= 10^4`


#### Solution

Language: **Swift**

```swift
class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count < 3 { return 0 }
        // SORT
        let nums = nums.sorted()
        var min_diff = Int.max
        var ans = 0
        for a in 0..<nums.count - 2 {
            var b = a + 1, c = nums.count - 1
            while b < c {
                let sum = nums[a] + nums[b] + nums[c]
                let diff = abs(sum - target)
                if sum > target {
                    c -= 1
                } else if sum < target {
                    b += 1
                } else {
                    return target
                }
                if diff < min_diff {
                    ans = sum
                    min_diff = diff
                }
            }
        }
        return ans
    }
}
```