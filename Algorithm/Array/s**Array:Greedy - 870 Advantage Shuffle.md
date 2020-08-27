### [870\. Advantage Shuffle](https://leetcode.com/problems/advantage-shuffle/)

Difficulty: **Medium**  

Related Topics: [Array](https://leetcode.com/tag/array/), [Greedy](https://leetcode.com/tag/greedy/)


Given two arrays `A` and `B` of equal size, the _advantage of `A` with respect to `B`_ is the number of indices `i` for which `A[i] > B[i]`.

Return **any** permutation of `A` that maximizes its advantage with respect to `B`.


**Example 1:**

```
Input: A = [2,7,11,15], B = [1,10,4,11]
Output: [2,11,7,15]
```


**Example 2:**

```
Input: A = [12,24,8,32], B = [13,25,32,11]
Output: [24,32,8,12]
```

**Note:**

1.  `1 <= A.length = B.length <= 10000`
2.  `0 <= A[i] <= 10^9`
3.  `0 <= B[i] <= 10^9`


#### Solution

Language: **Swift**

```swift
class Solution {
    func advantageCount(_ A: [Int], _ B: [Int]) -> [Int] {
       // Greedy, Sort the A, for each i, choose the smallest item in A that is greater than B[i]，if counldn't found one, just use the smallest one
        
        var A = A.sorted()
        let n = A.count
        var ans = Array(repeating: 0, count: n)
        for i in 0..<n {
            var j = 0
            while j < A.count && A[j] <= B[i] {
                j += 1
            }
            if j < A.count {  // found one
                ans[i] = A[j]
                A.remove(at: j)
            } else { // not found, so just place the smallest one into ans
                ans[i] = A[0]
                A.remove(at: 0)
            }
        }
        return ans
    }
}
```