### [971\. Flip Binary Tree To Match Preorder Traversal](https://leetcode.com/problems/flip-binary-tree-to-match-preorder-traversal/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given a binary tree with `N` nodes, each node has a different value from `{1, ..., N}`.

A node in this binary tree can be _flipped_ by swapping the left child and the right child of that node.

Consider the sequence of `N` values reported by a preorder traversal starting from the root.  Call such a sequence of `N` values the _voyage_ of the tree.

(Recall that a _preorder traversal_ of a node means we report the current node's value, then preorder-traverse the left child, then preorder-traverse the right child.)

Our goal is to flip the **least number** of nodes in the tree so that the voyage of the tree matches the `voyage` we are given.

If we can do so, then return a list of the values of all nodes flipped.  You may return the answer in any order.

If we cannot do so, then return the list `[-1]`.


**Example 1:**

**![](https://assets.leetcode.com/uploads/2019/01/02/1219-01.png)**

```
Input: root = [1,2], voyage = [2,1]
Output: [-1]
```


**Example 2:**

**![](https://assets.leetcode.com/uploads/2019/01/02/1219-02.png)**

```
Input: root = [1,2,3], voyage = [1,3,2]
Output: [1]
```


**Example 3:**

**![](https://assets.leetcode.com/uploads/2019/01/02/1219-02.png)**

```
Input: root = [1,2,3], voyage = [1,2,3]
Output: []
```

**<span style="display: inline;">Note:</span>**

1.  `1 <= N <= 100`


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
    //Solution: Pre-order traversal
    // if root->val != v[pos] return [-1]
    // if root->left?->val != v[pos + 1], swap the nodes
 
    
    func flipMatchVoyage(_ root: TreeNode?, _ voyage: [Int]) -> [Int] {
        var idx = 0, ans = [Int]()
        preorder(root, voyage, &idx, &ans)
        return ans
    }
    
    private func preorder(_ root: TreeNode?, _ voyage: [Int], _ idx: inout Int, _ ans: inout [Int]) {
        if root == nil { return }
    
        if root!.val != voyage[idx] {
            ans.removeAll()
            ans.append(-1)
            return
        }
        
        if root!.left != nil && root!.left!.val != voyage[idx + 1] {
            
            // swap left and right
            let right = root!.right
            root!.right = root!.left
            root!.left = right
            
            ans.append(root!.val)
        }
        
        idx += 1
        
        preorder(root!.left, voyage, &idx, &ans)
        preorder(root!.right, voyage, &idx, &ans)
    }
}
```