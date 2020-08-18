### [106\. Construct Binary Tree from Inorder and Postorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/)

Difficulty: **Medium**  

Related Topics: [Array](https://leetcode.com/tag/array/), [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given inorder and postorder traversal of a tree, construct the binary tree.

**Note:**  
You may assume that duplicates do not exist in the tree.

For example, given

```
inorder = [9,3,15,20,7]
postorder = [9,15,7,20,3]
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

思路：创建树需要优先知道root的信息。在postorder中，root的value就是最后一位。当我们有了root的value后，我们就在inorder中找到这个value的index，通过inorder就能知道整棵树中对于这个root的左边节点数量和右边节点数量。用这个信息就能分解inorder和postorder，来构建这个root的左子树和右子树。

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
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        return buildTree(inorder, 0, inorder.count - 1, postorder, 0, postorder.count - 1)
    }
    
    func buildTree(_ inorder: [Int], _ s1: Int, _ e1: Int, _ postorder: [Int], _ s2: Int, _ e2: Int) -> TreeNode? {
        if s1 > e1 || s2 > e2 { return nil }
        
        // The root is at the end of the postorder
        let root_val = postorder[e2]
        var root = TreeNode(root_val, nil, nil)
        
        // Use the root val to divide the inorder
        let root_idx = inorder.firstIndex(of: root_val)!
        let left_size = root_idx - s1, right_size = e1 - root_idx
         // Use the size to get new start end end index
        let l_s1 = s1, l_e1 = l_s1 + left_size - 1, r_s1 = root_idx + 1, r_e1 = r_s1 + right_size - 1
        var l_s2 = s2, l_e2 = l_s2 + left_size - 1, r_s2 = l_e2 + 1, r_e2 = r_s2 + right_size - 1
        
        root.left = buildTree(inorder, l_s1, l_e1, postorder, l_s2, l_e2)
        root.right = buildTree(inorder, r_s1, r_e1, postorder, r_s2, r_e2)
        return root
    }
}
```