### [98\. Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/)

Difficulty: **Medium**


Given a binary tree, determine if it is a valid binary search tree (BST).

Assume a BST is defined as follows:

*   The left subtree of a node contains only nodes with keys **less than** the node's key.
*   The right subtree of a node contains only nodes with keys **greater than** the node's key.
*   Both the left and right subtrees must also be binary search trees.

**Example 1:**

```
    2
   / \
  1   3

Input: [2,1,3]
Output: true
```

**Example 2:**

```
    5
   / \
  1   4
     / \
    3   6

Input: [5,1,4,null,null,3,6]
Output: false
Explanation: The root node's value is 5 but its right child's value is 4.
```


#### Solution 1

Track the current lower and upper bound!

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
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, Int.min, Int.max)
    }
    
    private func isValidBST(_ root: TreeNode?, _ lower: Int, _ upper: Int) -> Bool {
        if root == nil { return true }
        // Note: can not be equal
        if root!.val <= lower || root!.val >= upper { 
            return false 
        }
        
        let left = isValidBST(root!.left, lower, root!.val)
        let right = isValidBST(root!.right, root!.val, upper)
        
        return left && right
    }
}
```

#### Solution 2

Improve the hardcoded upper bound and lower bound using nil pointer

```swift
class Solution {
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, nil, nil)
    }
    
    private func isValidBST(_ root: TreeNode?, _ lower: Int?, _ upper: Int?) -> Bool {
        if root == nil { return true }
        // Note: can not be equal
        if (lower != nil && root!.val <= lower!) || (upper != nil && root!.val >= upper!) { 
            return false 
        }
        
        let left = isValidBST(root!.left, lower, root!.val)
        let right = isValidBST(root!.right, root!.val, upper)
        
        return left && right
    }
}
```