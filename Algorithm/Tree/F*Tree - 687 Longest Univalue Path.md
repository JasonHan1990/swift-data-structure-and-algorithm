### [687\. Longest Univalue Path](https://leetcode.com/problems/longest-univalue-path/)

Difficulty: **Easy**


Given a binary tree, find the length of the longest path where each node in the path has the same value. This path may or may not pass through the root.

The length of path between two nodes is represented by the number of edges between them.

**Example 1:**

**Input:**

```
              5
             / \
            4   5
           / \   \
          1   1   5
```

**Output:** 2   

**Example 2:**

**Input:**

```
              1
             / \
            4   5
           / \   \
          4   4   5
```

**Output:** 2

**Note:** The given binary tree has not more than 10000 nodes. The height of the tree is not more than 1000.


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
    func longestUnivaluePath(_ root: TreeNode?) -> Int {
        var ans = 0
        univaluePath(root, &ans)
        return ans
    }
    
    private func univaluePath(_ root: TreeNode?, _ ans: inout Int) -> Int {
        if root == nil { return 0 }
        // left child longestUnivaluePath
        let l = univaluePath(root!.left, &ans)
        // left child longestUnivaluePath
        let r = univaluePath(root!.right, &ans)
        
        // for current root
        var rootl = 0, rootr = 0
        if root!.left != nil && root!.left!.val == root!.val {
            rootl = l + 1 
        }
        if root!.right != nil && root!.right!.val == root!.val {
            rootr = r + 1 
        }
        
        // update the ans
        ans = max(ans, rootl + rootr)  // when left and right children are both equal to the root, rootl + rootr will be the largest path
        
        return max(rootl, rootr)  // only return one side
    }
}

```