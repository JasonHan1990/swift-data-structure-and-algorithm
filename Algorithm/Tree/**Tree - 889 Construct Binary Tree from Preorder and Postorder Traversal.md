### [889\. Construct Binary Tree from Preorder and Postorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-postorder-traversal/)

Difficulty: **Medium**


Return any binary tree that matches the given preorder and postorder traversals.

Values in the traversals `pre` and `post` are distinct positive integers.


**Example 1:**

```
Input: pre = [1,2,4,5,3,6,7], post = [4,5,2,6,7,3,1]
Output: [1,2,3,4,5,6,7]
```

**<span style="display: inline;">Note:</span>**

*   `1 <= pre.length == post.length <= 30`
*   `pre[]` and `post[]` are both permutations of `1, 2, ..., pre.length`.
*   It is guaranteed an answer exists. If there exists multiple answers, you can return any of them.


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
    func constructFromPrePost(_ pre: [Int], _ post: [Int]) -> TreeNode? {
        return constructFromPrePost(pre, post, 0, pre.count - 1, 0, post.count - 1)
    }
    
    private func constructFromPrePost(_ pre: [Int], _ post: [Int], 
                                      _ preS: Int, _ preE: Int, 
                                      _ postS: Int, _ postE: Int
                                     ) -> TreeNode? {
        if preE < preS { return nil }
        var root = TreeNode(pre[preS])
        if preE == preS { return root }
        
        var leftNodesCount = 0
        for i in postS...postE {
            leftNodesCount += 1
            if post[i] == pre[preS + 1] {
                break
            }
        }
        
        root.left = constructFromPrePost(pre, post, preS + 1, preS + leftNodesCount, postS, postS + leftNodesCount - 1)
        root.right = constructFromPrePost(pre, post, preS + 1 + leftNodesCount, preE, postS + leftNodesCount, postE - 1)
        return root
    }
}
```