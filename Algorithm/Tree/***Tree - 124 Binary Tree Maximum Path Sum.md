### [124\. Binary Tree Maximum Path Sum](https://leetcode.com/problems/binary-tree-maximum-path-sum/)

Difficulty: **Hard**


Given a **non-empty** binary tree, find the maximum path sum.

For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The path must contain **at least one node** and does not need to go through the root.

**Example 1:**

```
Input: [1,2,3]

       1
      / \
     2   3

Output: 6
```

**Example 2:**

```
Input: [-10,9,20,null,null,15,7]

   -10
   / \
  9  20
    /  \
   15   7

Output: 42
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
    func maxPathSum(_ root: TreeNode?) -> Int {
        var ans = Int.min
        pathSum(root, &ans)
        return ans
    }
    
    
    private func pathSum(_ root: TreeNode?, _ ans: inout Int) -> Int { // only return the sum from one child
        
        if root == nil { return Int.min }
        
        let left = pathSum(root!.left, &ans)
        let right = pathSum(root!.right, &ans)
        
        // update the ans here
        // if left and right are smaller than 0, not add to the sum
        ans = max(ans, root!.val + max(0, left) + max(0, right))
        
        return root!.val + max(0, left, right) // choose one child or choose nothing if both children are < 0
    }
}
```