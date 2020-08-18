### [145\. Binary Tree Postorder Traversal](https://leetcode.com/problems/binary-tree-postorder-traversal/)

Difficulty: **Hard**


Given a binary tree, return the _postorder_ traversal of its nodes' values.

**Example:**

```
Input: [1,null,2,3]
   1
    \
     2
    /
   3

Output: [3,2,1]
```

**Follow up:** Recursive solution is trivial, could you do it iteratively?


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
    
     func postorderTraversal(_ root: TreeNode?) -> [Int] {
         //直接用stack来模拟postorder是很难的，但是我们可以模拟reversed_postorder
         // reversed_postorder的顺序是
         // print(root.val)
         // travel(root.right)
         // travel(root.left)
         // 这样得到的结果刚好是反过来的postorder的结果，
         // 所以最后只需要把结果reverse一下就好了
     }
         
         
    func postorderTraversal_Recursive(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        helper(root, &res)
        return res
    }
    
    func helper(_ root: TreeNode?, _ res: inout [Int]) {
        if root == nil { return }
        helper(root!.left, &res)
        helper(root!.right, &res)
        res.append(root!.val)
    }
}
         }
```