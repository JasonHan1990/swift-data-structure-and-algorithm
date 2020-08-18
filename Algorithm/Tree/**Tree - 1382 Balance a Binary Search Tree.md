### [1382\. Balance a Binary Search Tree](https://leetcode.com/problems/balance-a-binary-search-tree/)

Difficulty: **Medium**  

Related Topics: [Binary Search Tree](https://leetcode.com/tag/binary-search-tree/)


Given a binary search tree, return a **balanced** binary search tree with the same node values.

A binary search tree is _balanced_ if and only if the depth of the two subtrees of every node never differ by more than 1.

If there is more than one answer, return any of them.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2019/08/22/1515_ex1.png)![](https://assets.leetcode.com/uploads/2019/08/22/1515_ex1_out.png)**

```
Input: root = [1,null,2,null,3,null,4,null,null]
Output: [2,1,3,null,null,null,4]
Explanation: This is not the only correct answer, [3,1,4,null,2,null,null] is also correct.
```

**Constraints:**

*   The number of nodes in the tree is between `1` and `10^4`.
*   The tree nodes will have distinct values between `1` and `10^5`.


#### Solution
 思路： 利用BST在inorder的遍历后能得到一个有序数列，然后在将有序数列重组成一个balanced BST(二分思想).

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
    func balanceBST(_ root: TreeNode?) -> TreeNode? {
        var sortedArray = [Int]()
        getSortedArray(root, &sortedArray)
        return custructSortedArrayToBST(sortedArray, 0, sortedArray.count - 1)
    }
    
    private func getSortedArray(_ root: TreeNode?, _ res: inout [Int]) { // inorder
        if root == nil { return }
        getSortedArray(root!.left, &res)
        res.append(root!.val)
        getSortedArray(root!.right, &res)
    }
    
    private func custructSortedArrayToBST(_ array: [Int], _ l: Int, _ r: Int) -> TreeNode? {
        if l > r { return nil }
        let mid = l + (r - l) / 2
        var node = TreeNode(array[mid], nil, nil)
        node.left = custructSortedArrayToBST(array, l, mid - 1)
        node.right = custructSortedArrayToBST(array, mid + 1, r)
        return node
    }
}
```