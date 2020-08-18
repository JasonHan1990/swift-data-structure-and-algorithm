### [1008\. Construct Binary Search Tree from Preorder Traversal](https://leetcode.com/problems/construct-binary-search-tree-from-preorder-traversal/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/)


Return the root node of a binary **search** tree that matches the given `preorder` traversal.

_(Recall that a binary search tree is a binary tree where for every <font face="monospace" style="display: inline;">node</font>, any descendant of `node.left` has a value `<` `node.val`, and any descendant of `node.right` has a value `>` `node.val`.  Also recall that a preorder traversal displays the value of the `node` first, then traverses `node.left`, then traverses `node.right`.)_

It's guaranteed that for the given test cases there is always possible to find a binary search tree with the given requirements.

**Example 1:**

```
Input: [8,5,1,7,10,12]
Output: [8,5,10,1,7,null,12]

```
![](1008.png)

**Constraints:**

*   `1 <= preorder.length <= 100`
*   `1 <= preorder[i] <= 10^8`
*   The values of `preorder` are distinct.


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
    func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
        return bstFromPreorder(preorder, 0, preorder.count - 1)
    }
    
    private func bstFromPreorder(_ preorder: [Int], _ s: Int, _ e: Int) -> TreeNode? {
        if s > e { return nil }
        var root = TreeNode(preorder[s], nil, nil)
        let l_idx = getLargeIndex(preorder, s)
        root.left = bstFromPreorder(preorder, s + 1, l_idx - 1)
        root.right = bstFromPreorder(preorder, l_idx, e)
        return root
    }
    
    private func getLargeIndex(_ preorder: [Int], _ root_idx: Int) -> Int {
        var ans = root_idx
        while ans < preorder.count && preorder[root_idx] >= preorder[ans] {
            ans += 1
        }
        return ans
    }
}
```