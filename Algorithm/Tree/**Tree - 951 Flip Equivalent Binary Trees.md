### [951\. Flip Equivalent Binary Trees](https://leetcode.com/problems/flip-equivalent-binary-trees/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/)


For a binary tree T, we can define a flip operation as follows: choose any node, and swap the left and right child subtrees.

A binary tree X is _flip equivalent_ to a binary tree Y if and only if we can make X equal to Y after some number of flip operations.

Write a function that determines whether two binary trees are _flip equivalent_.  The trees are given by root nodes `root1` and `root2`.

**Example 1:**

```
Input: root1 = [1,2,3,4,5,6,null,null,null,7,8], root2 = [1,3,2,null,6,4,5,null,null,null,null,8,7]
Output: true
Explanation: We flipped at nodes with values 1, 3, and 5.

```

**Note:**

1.  Each tree will have at most `100` nodes.
2.  Each value in each tree will be a unique integer in the range `[0, 99]`.


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
    func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        
        if root1 == nil && root2 == nil { return true }
        if root1 == nil || root2 == nil { return false }
        if root1!.val != root2!.val { return false }
        
        // check the lefts, if they are not equal, swap left and right from root1
        if (root1!.left == nil && root2!.left != nil) || (root1!.left != nil && root2!.left == nil) || (root1!.left != nil && root2!.left != nil && root1!.left!.val != root2!.left!.val) {
            let right = root1!.right
            root1!.right = root1!.left
            root1!.left = right
        }
        
        return flipEquiv(root1!.left, root2!.left) && flipEquiv(root1!.right, root2!.right)
    }
}
```