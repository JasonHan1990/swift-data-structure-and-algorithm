### [1296\. Divide Array in Sets of K Consecutive Numbers](https://leetcode.com/problems/divide-array-in-sets-of-k-consecutive-numbers/)

Difficulty: **Medium**


Given an array of integers `nums` and a positive integer `k`, find whether it's possible to divide this array into sets of `k` consecutive numbers  
Return `True` if its possibleotherwise return `False`.

**Example 1:**

```
Input: nums = [1,2,3,3,4,4,5,6], k = 4
Output: true
Explanation: Array can be divided into [1,2,3,4] and [3,4,5,6].
```

**Example 2:**

```
Input: nums = [3,2,1,2,3,4,3,4,5,9,10,11], k = 3
Output: true
Explanation: Array can be divided into [1,2,3] , [2,3,4] , [3,4,5] and [9,10,11].
```

**Example 3:**

```
Input: nums = [3,3,2,2,1,1], k = 3
Output: true
```

**Example 4:**

```
Input: nums = [1,2,3,4], k = 3
Output: false
Explanation: Each array should be divided in subarrays of size 3.
```

**Constraints:**

*   `1 <= nums.length <= 10^5`
*   `1 <= nums[i] <= 10^9`
*   `1 <= k <= nums.length`

**Note:** This question is the same as 846: 

#### Solution

Language: **Swift**

```swift
class Solution {
    func isPossibleDivide(_ nums: [Int], _ k: Int) -> Bool {
        if nums.count % k != 0 { return false }
        var freq = [Int : Int]()
        for n in nums {
            if let f = freq[n] {
                freq[n] = f + 1
            } else {
                freq[n] = 1
            }
        }
        
        var s = Array(freq.keys).sorted(by: <)
        var i = 0
        
        while true {
            let curF = freq[s[i]]!
            if curF == 0 {
                i += 1
                if i == s.count {
                    break
                }
            } else {
                var start = s[i]
                for _ in 0..<k {
                    guard let curF = freq[start], curF > 0 else { return false }
                    freq[start] = curF - 1
                    start += 1
                }
            }
        }
        
        return true
    }
}
```