### [954\. Array of Doubled Pairs](https://leetcode.com/problems/array-of-doubled-pairs/)

Difficulty: **Medium**  

Related Topics: [Array](https://leetcode.com/tag/array/), [Hash Table](https://leetcode.com/tag/hash-table/)


Given an array of integers `A` with even length, return `true` if and only if it is possible to reorder it such that `A[2 * i + 1] = 2 * A[2 * i]` for every `0 <= i < len(A) / 2`.


**Example 1:**

```
Input: [3,1,3,6]
Output: false
```


**Example 2:**

```
Input: [2,1,2,6]
Output: false
```


**Example 3:**

```
Input: [4,-2,2,-4]
Output: true
Explanation: We can take two groups, [-2,-4] and [2,4] to form [-2,-4,2,4] or [2,4,-2,-4].
```


**Example 4:**

```
Input: [1,2,4,16,8,4]
Output: false
```

**Note:**

1.  `0 <= A.length <= 30000`
2.  `A.length` is even
3.  `-100000 <= A[i] <= 100000`


#### Solution 1   

By sorting the absolute value of every value in A, I could avoid checking the (value / 2).

O(nlogn), the solution 1 is slower than solution 2 in multuple ways

Language: **Swift**

```swift
class Solution {
    func canReorderDoubled(_ A: [Int]) -> Bool {
        if A.count % 2 != 0 { return false }
        var sorted_A = A.sorted {
            return abs($0) < abs($1)
        }
        var count_dict = [Int : Int]()
        for i in A {
            count_dict[i, default: 0] += 1
        }
        
        if let zero = count_dict[0], zero % 2 == 1 {
            return false
        }
        var ans = false
        helper(sorted_A, 0, count_dict, &ans)
        return ans
    }
    
    func helper(_ A: [Int], _ idx: Int, _ dict: [Int : Int], _ ans: inout Bool) {
        if idx == A.count { 
            // update the res
            ans = ans || (dict.count == 0)
            return 
        }
        
        let num = A[idx]
​
        guard let num_count = dict[num], num_count > 0 else {
            helper(A, idx + 1, dict, &ans)
            return 
        }
        
        // num * 2
        let dble = num * 2
​
        guard let dble_num_count = dict[dble], dble_num_count > 0 else {
            helper(A, idx + 1, dict, &ans)
            return 
        }
        
        // found the pair
        var dict = dict
        if dict[num]! - 1 == 0 {
            dict[num] = nil
        } else {
            dict[num] = dict[num]! - 1
        }
        if dict[dble]! - 1 == 0 {
            dict[dble] = nil
        } else {
            dict[dble] = dict[dble]! - 1
        }
        
        
        helper(A, idx + 1, dict, &ans)
    }
}
```
#### Solution 2   
O(nlogn) 

```swift
class Solution {
    func canReorderDoubled(_ A: [Int]) -> Bool {
        if A.count % 2 != 0 { return false }
        var count_dict = [Int : Int]()
        for i in A {
            count_dict[i, default: 0] += 1
        }
        // if let zero = count_dict[0], zero % 2 == 1 {
        //     return false
        // }
        var sorted_keys = count_dict.keys.sorted {
            return abs($0) < abs($1)
        }
        
        for k in sorted_keys {
            let c1 = count_dict[k]!
            if c1 == 0 {
                continue
            } else {
                count_dict[k * 2, default: 0] -= c1
                if count_dict[k * 2]! < 0 {
                    return false
                }
            }
        }
        return true
    }
}
```