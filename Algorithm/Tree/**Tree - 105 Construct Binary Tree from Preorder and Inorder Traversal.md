### [105\. Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)

Difficulty: **Medium**  

Related Topics: [Array](https://leetcode.com/tag/array/), [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given preorder and inorder traversal of a tree, construct the binary tree.

**Note:**  
You may assume that duplicates do not exist in the tree.

For example, given

```
preorder = [3,9,20,15,7]
inorder = [9,3,15,20,7]
```

Return the following binary tree:

```
    3
   / \
  9  20
    /  \
   15   7
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
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        return buildTree(preorder, 0, preorder.count - 1, inorder, 0, inorder.count - 1)
    }
    
    private func buildTree(_ preorder: [Int], _ pre_s: Int, _ pre_e: Int, _ inorder: [Int], _ in_s: Int, _ in_e: Int) -> TreeNode? {
        if pre_s > pre_e || in_s > in_e {
            return nil
        }
        
        // pre_s is the head
        let root = TreeNode(preorder[pre_s], nil, nil)
        
        var r_idx = in_s
        while r_idx <= in_e {
            if preorder[pre_s] == inorder[r_idx] {
                break
            }
            r_idx += 1
        }
        
        root.left = buildTree(preorder, pre_s + 1, pre_s + 1 + r_idx - in_s, inorder, in_s, r_idx - 1)
        root.right = buildTree(preorder, pre_s + 1 + r_idx - in_s, pre_e, inorder, r_idx + 1, in_e)
        return root
    }
}
```