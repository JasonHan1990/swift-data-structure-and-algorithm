### [456\. 132 Pattern](https://leetcode.com/problems/132-pattern/)

Difficulty: **Medium**  

Related Topics: [Stack](https://leetcode.com/tag/stack/)


Given a sequence of n integers a<sub style="display: inline;">1</sub>, a<sub style="display: inline;">2</sub>, ..., a<sub style="display: inline;">n</sub>, a 132 pattern is a subsequence a<sub style="display: inline;">**i**</sub>, a<sub style="display: inline;">**j**</sub>, a<sub style="display: inline;">**k**</sub> such that **i** < **j** < **k** and a<sub style="display: inline;">**i**</sub> < a<sub style="display: inline;">**k**</sub> < a<sub style="display: inline;">**j**</sub>. Design an algorithm that takes a list of n numbers as input and checks whether there is a 132 pattern in the list.

**Note:** n will be less than 15,000.

**Example 1:**  

```
Input: [1, 2, 3, 4]

Output: False

Explanation: There is no 132 pattern in the sequence.
```

**Example 2:**  

```
Input: [3, 1, 4, 2]

Output: True

Explanation: There is a 132 pattern in the sequence: [1, 4, 2].
```

**Example 3:**  

```
Input: [-1, 3, 2, 0]

Output: True

Explanation: There are three 132 patterns in the sequence: [-1, 3, 2], [-1, 3, 0] and [-1, 2, 0].
```


#### Solution

BF1: O(n^3) Fix i, j, k. 对i，j，k的每一种可能都比较一下Ai < Ak < Aj.
BF2: O(n^2) Fix j, k. 如果我们要把时间复杂度降低到n^2，那么就只能fix两个变量。因为Ai是三个值中最小的，所以，如果已知在坐标j前0 ~ j-1中的最小值MINi，那么我们就能比较MINi < Ak < Aj。这个不能实现，我们只需要O(n)的时间就能得到一个MIN数组。

BEST: O(nlogn). 在上面的那个基础上，我们希望只fix一个相，这里一半最好都是选择中间相。那么如何确定Ak？我们知道Ak < Aj，那么我们可以从后往前遍历Aj，用一个stack保存过去遍历过的数字，也就是可能的Ak，因为Ak在Aj后面，如果我们发现当前的Aj大于stack顶端的值，那么我们就验证当前Aj，和stack中所有小于Aj的值是否满足MINi < Stack.top k < Aj

Language: **Swift**

```swift
class Solution {
    func find132pattern(_ nums: [Int]) -> Bool {
        if nums.count < 3 { return false }
        
        var min = nums
        // 计算出0 ~ i的最小值 O(n)
        for i in 1..<min.count {
            if min[i] > min[i - 1] {
                min[i] = min[i - 1]
            }
        }
​
        // 从后往前遍历，用stack记录j + 1 ~ n中小于num[j]的最大值，
        // 如果找到 min[j - 1] < stack.peek < num[j]，返回true
        var max_stack = [nums[nums.count - 1]]
        var j = nums.count - 2
        while j > 0 {
            
            while !max_stack.isEmpty && nums[j] > max_stack.last! {
                if min[j - 1] < max_stack.last! {
                    return true
                }
                max_stack.removeLast()
            }
            max_stack.append(nums[j])
            j -= 1
        }
        
        return false
    }
}
```