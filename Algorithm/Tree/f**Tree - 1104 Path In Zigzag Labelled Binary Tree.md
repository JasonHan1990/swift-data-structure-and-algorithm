### [1104\. Path In Zigzag Labelled Binary Tree](https://leetcode.com/problems/path-in-zigzag-labelled-binary-tree/)

Difficulty: **Medium**  

Related Topics: [Math](https://leetcode.com/tag/math/), [Tree](https://leetcode.com/tag/tree/)


In an infinite binary tree where every node has two children, the nodes are labelled in row order.

In the odd numbered rows (ie., the first, third, fifth,...), the labelling is left to right, while in the even numbered rows (second, fourth, sixth,...), the labelling is right to left.

![](https://assets.leetcode.com/uploads/2019/06/24/tree.png)

Given the `label` of a node in this tree, return the labels in the path from the root of the tree to the node with that `label`.

**Example 1:**

```
Input: label = 14
Output: [1,3,4,14]
```

**Example 2:**

```
Input: label = 26
Output: [1,2,6,10,26]
```

**Constraints:**

*   `1 <= label <= 10^6`


#### Solution

Language: **Swift**

```swift
class Solution {
    func pathInZigZagTree(_ label: Int) -> [Int] {
        // for each level, where level is from 1 ~ n,
        // the lower bound == 2^(n - 1), the upper bound is 2^n - 1
        
        // Get the level
        var level = 1
        var lower = Int(pow(2.0, Double(level - 1))), upper = Int(pow(2.0,  Double(level))) - 1
        while !(label >= lower && label <= upper) {
            level += 1
            lower = Int(pow(2.0, Double(level - 1)))
            upper = Int(pow(2.0,  Double(level))) - 1
        }
        
        var res = Array(repeating: 0, count: level)
        res[level - 1] = label
        
        var label = label
        let evenOrOdd = (level % 2 == 0) ? 1 : 0
        level -= 1
        while level >= 1 {
            label /= 2
            if level % 2 == evenOrOdd {
                // need flip
                lower = Int(pow(2.0, Double(level - 1)))
                upper = Int(pow(2.0,  Double(level))) - 1
                res[level - 1] = lower + (upper - label)
            } else {
                res[level - 1] = label
            }
            level -= 1
        }
        
        return res
    }
}
```