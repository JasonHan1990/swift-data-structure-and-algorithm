### [543\. Diameter of Binary Tree](https://leetcode.com/problems/diameter-of-binary-tree/)

Difficulty: **Easy**


Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the **longest** path between any two nodes in a tree. This path may or may not pass through the root.

**Example:**  
Given a binary tree  

```
          1
         / \
        2   3
       / \     
      4   5    
```

Return **3**, which is the length of the path [4,2,1,3] or [5,2,1,3].

**Note:** The length of path between two nodes is represented by the number of edges between them.


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
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var ans = 0
        _ = getHeight(root, &ans)
        return ans
    }
    
    private func getHeight(_ root: TreeNode?, _ ans: inout Int) -> Int {
        if root == nil { return 0 }
        let l = getHeight(root!.left, &ans)
        let r = getHeight(root!.right, &ans)
        ans = max(ans, l + r)
        return max(l, r) + 1
    }
}
```