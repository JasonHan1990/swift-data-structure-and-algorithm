### [669\. Trim a Binary Search Tree](https://leetcode.com/problems/trim-a-binary-search-tree/)

Difficulty: **Easy**


Given a binary search tree and the lowest and highest boundaries as `L` and `R`, trim the tree so that all its elements lies in `[L, R]` (R >= L). You might need to change the root of the tree, so the result should return the new root of the trimmed binary search tree.

**Example 1:**  

```
Input: 
    1
   / \
  0   2

  L = 1
  R = 2

Output: 
    1
      \
       2
```

**Example 2:**  

```
Input: 
    3
   / \
  0   4
   \
    2
   /
  1

  L = 1
  R = 3

Output: 
      3
     / 
   2   
  /
 1
```


#### Solution
熟悉二叉搜索树的特性

#### 需要注意内存释放，

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
    func trimBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> TreeNode? {
        if root == nil {
            return root
        }
        if root!.val > R {
            root!.right = nil
            return trimBST(root!.left, L, R)
        } 
        
        if root!.val < L {
            return trimBST(root!.right, L, R)
        }
    
    
        root!.left = trimBST(root!.left, L, R)
        root!.right = trimBST(root!.right, L, R)
        return root
    }
}
```