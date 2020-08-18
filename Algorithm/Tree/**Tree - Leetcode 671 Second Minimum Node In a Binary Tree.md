### [671\. Second Minimum Node In a Binary Tree](https://leetcode.com/problems/second-minimum-node-in-a-binary-tree/)

Difficulty: **Easy**


Given a non-empty special binary tree consisting of nodes with the non-negative value, where each node in this tree has exactly `two` or `zero` sub-node. If the node has two sub-nodes, then this node's value is the smaller value among its two sub-nodes. More formally, the property `root.val = min(root.left.val, root.right.val)` always holds.

Given such a binary tree, you need to output the **second minimum** value in the set made of all the nodes' value in the whole tree.

If no such second minimum value exists, output -1 instead.

**Example 1:**

```
Input: 
    2
   / \
  2   5
     / \
    5   7

Output: 5
Explanation: The smallest value is 2, the second smallest value is 5.
```

**Example 2:**

```
Input: 
    2
   / \
  2   2

Output: -1
Explanation: The smallest value is 2, but there isn't any second smallest value.
```


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
    func findSecondMinimumValue(_ root: TreeNode?) -> Int {
        if root == nil { return -1 }
        // BFS
        var secondMin = -1
        var queue = [root]
        
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            if cur!.val > root!.val { // Stop looking down the tree because root.val = min(root.left.val, root.right.val) always holds.
                if secondMin == -1 {
                    secondMin = cur!.val
                } else {
                    secondMin = min(secondMin, cur!.val)
                }
            } else {
                if cur!.left != nil {
                    queue.append(cur!.left)
                }
                if cur!.right != nil {
                    queue.append(cur!.right)
                }
            }
        }
        return secondMin
    }
}
```