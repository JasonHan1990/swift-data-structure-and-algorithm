### [998\. Maximum Binary Tree II](https://leetcode.com/problems/maximum-binary-tree-ii/)

Difficulty: **Medium**


We are given the `root` node of a _maximum tree:_ a tree where every node has a value greater than any other value in its subtree.

Just as in the , the given tree was constructed from an list `A` (`root = Construct(A)`) recursively with the following `Construct(A)` routine:

*   If `A` is empty, return `null`.
*   Otherwise, let `A[i]` be the largest element of `A`.  Create a `root` node with value `A[i]`.
*   The left child of `root` will be `Construct([A[0], A[1], ..., A[i-1]])`
*   The right child of `root` will be `Construct([A[i+1], A[i+2], ..., A[A.length - 1]])`
*   Return `root`.

Note that we were not given A directly, only a root node `root = Construct(A)`.

Suppose `B` is a copy of `A` with the value `val` appended to it.  It is guaranteed that `B` has unique values.

Return `Construct(B)`.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2019/02/21/maximum-binary-tree-1-1.png)![](https://assets.leetcode.com/uploads/2019/02/21/maximum-binary-tree-1-2.png)**

```
Input: root = [4,1,3,null,null,2], val = 5
Output: [5,4,null,1,3,null,null,2]
Explanation: A = [1,4,2,3], B = [1,4,2,3,5]
```


**Example 2:  
![](https://assets.leetcode.com/uploads/2019/02/21/maximum-binary-tree-2-1.png)![](https://assets.leetcode.com/uploads/2019/02/21/maximum-binary-tree-2-2.png)**

```
Input: root = [5,2,4,null,1], val = 3
Output: [5,2,4,null,1,null,3]
Explanation: A = [2,1,5,4], B = [2,1,5,4,3]
```


**Example 3:  
![](https://assets.leetcode.com/uploads/2019/02/21/maximum-binary-tree-3-1.png)![](https://assets.leetcode.com/uploads/2019/02/21/maximum-binary-tree-3-2.png)**

```
Input: root = [5,2,3,null,1], val = 4
Output: [5,2,4,null,1,3]
Explanation: A = [2,1,5,3], B = [2,1,5,3,4]
```


**Note:**

1.  `1 <= B.length <= 100`


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
    func insertIntoMaxTree(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        // because the new val is at the last position of the array, so, if the new value is smaller than the current root value, go the right, until find one node > than the value, than this node will be the left child of Node(val)
        
        if root == nil { return TreeNode(val, nil, nil) }
        
        // root.val > val, recursive check the right part
        if root!.val > val {
            root!.right = insertIntoMaxTree(root!.right, val)
            return root
        } else { // root.val < val
            var newRoot = TreeNode(val, nil, nil)
            newRoot.left = root
            return newRoot
        } 
    }
}
```