### [508\. Most Frequent Subtree Sum](https://leetcode.com/problems/most-frequent-subtree-sum/)

Difficulty: **Medium**  

Related Topics: [Hash Table](https://leetcode.com/tag/hash-table/), [Tree](https://leetcode.com/tag/tree/)


Given the root of a tree, you are asked to find the most frequent subtree sum. The subtree sum of a node is defined as the sum of all the node values formed by the subtree rooted at that node (including the node itself). So what is the most frequent subtree sum value? If there is a tie, return all the values with the highest frequency in any order.

**Examples 1**  
Input:

```
  5
 /  \
2   -3
```

return [2, -3, 4], since all the values happen only once, return all of them in any order.

**Examples 2**  
Input:

```
  5
 /  \
2   -5
```

return [2], since 2 happens twice, however -5 only occur once.

**Note:** You may assume the sum of values in any subtree is in the range of 32-bit signed integer.


#### Solution

Language: **Swift**

```swift
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    var freq = [Int : Int]()
    func findFrequentTreeSum(_ root: TreeNode?) -> [Int] {
        if root == nil { return [Int]() }
        let s = sum(root!)
        freq[s, default: 0] += 1 
    
        // sort the freq
        let array_freq = freq.sorted { return $0.value > $1.value }
        var res = [Int]()
        var prev = -1 
        for (key, value) in array_freq {
            if prev == -1 {
                prev = value
                res.append(key)
            } else {
                if value == prev {
                    res.append(key)
                } else {
                    break
                }
            }
        }
    
        return res
    }
    
    private func sum(_ root: TreeNode) -> Int {
        
        if root.left == nil && root.right == nil { return root.val }
        
        var left = 0
        if root.left != nil {
            left = sum(root.left!)
            freq[left, default: 0] += 1
        }
        var right = 0
        if root.right != nil {
            right = sum(root.right!)
            freq[right, default: 0] += 1
        }
        
        // record, left, right, sum of this root
        let sum = left + right + root.val
        return sum
    }
}
```