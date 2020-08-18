### [110\. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree/)

Difficulty: **Easy**


Given a binary tree, determine if it is height-balanced.

For this problem, a height-balanced binary tree is defined as:

> a binary tree in which the left and right subtrees of _every_ node differ in height by no more than 1.

**Example 1:**

Given the following tree `[3,9,20,null,null,15,7]`:

```
    3
   / \
  9  20
    /  \
   15   7
```

Return true.  

**Example 2:**

Given the following tree `[1,2,2,3,3,null,null,4,4]`:

```
       1
      / \
     2   2
    / \
   3   3
  / \
 4   4
```

Return false.


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
    func isBalanced(_ root: TreeNode?) -> Bool {
        let h = height(root)
        return h == -1 ? false : true
    }
    
    private func height(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        let left = height(root!.left)
        let right = height(root!.right)
        if left == -1 || right == -1 { return -1 }
        if abs(left - right) > 1 { return -1 }
        return max(left, right) + 1
    }
}
```