### [1373\. Maximum Sum BST in Binary Tree](https://leetcode.com/problems/maximum-sum-bst-in-binary-tree/)

Difficulty: **Hard**  

Related Topics: [Dynamic Programming](https://leetcode.com/tag/dynamic-programming/), [Binary Search Tree](https://leetcode.com/tag/binary-search-tree/)


Given a **binary tree** `root`, the task is to return the maximum sum of all keys of **any** sub-tree which is also a Binary Search Tree (BST).

Assume a BST is defined as follows:

*   The left subtree of a node contains only nodes with keys **less than** the node's key.
*   The right subtree of a node contains only nodes with keys **greater than** the node's key.
*   Both the left and right subtrees must also be binary search trees.

**Example 1:**

![](https://assets.leetcode.com/uploads/2020/01/30/sample_1_1709.png)

```
Input: root = [1,4,3,2,4,2,5,null,null,null,null,null,null,4,6]
Output: 20
Explanation: Maximum sum in a valid Binary search tree is obtained in root node with key equal to 3.
```

**Example 2:**

![](https://assets.leetcode.com/uploads/2020/01/30/sample_2_1709.png)

```
Input: root = [4,3,null,1,2]
Output: 2
Explanation: Maximum sum in a valid Binary search tree is obtained in a single root node with key equal to 2.
```

**Example 3:**

```
Input: root = [-4,-2,-5]
Output: 0
Explanation: All values are negatives. Return an empty BST.
```

**Example 4:**

```
Input: root = [2,1,3]
Output: 6
```

**Example 5:**

```
Input: root = [5,4,8,3,null,6,3]
Output: 7
```

**Constraints:**

*   The given binary tree will have between `1` and `40000` nodes.
*   Each node's value is between `[-4 * 10^4 , 4 * 10^4]`.


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
    // SubRes is the Result for current Node of subtree
    // isBST: For this node, is the subtree a bst
    // sum: The sum of current subtree
    // minVal: the min val in current subtree
    // maxVal: the max val in current subtree
    struct SubRes {
        var isBST: Bool
        var sum: Int
        var minVal: Int
        var maxVal: Int
        init(_ isBST: Bool, _ sum: Int, _ minVal: Int, _ maxVal: Int) {
            self.isBST = isBST
            self.sum = sum
            self.minVal = minVal
            self.maxVal = maxVal
        }
    }
    
    func maxSumBST(_ root: TreeNode?) -> Int {
        var res = 0
        _ = btsAndSum(root, &res)
        return res
    }
    
    // Tuple (isBST, sum)
    private func btsAndSum(_ root: TreeNode?, _ res: inout Int) -> SubRes {
        if root == nil { return SubRes(true, 0, Int.max, Int.min) }
        if root!.left == nil && root!.right == nil { 
            res = max(res, root!.val)
            return SubRes(true, root!.val, root!.val, root!.val)
        }
        // get left and right
        let left = btsAndSum(root!.left, &res)
        let right = btsAndSum(root!.right, &res)
        // if any of them is not a bst, return false
        if !left.isBST || !right.isBST { 
            return SubRes(false, 0, 0, 0)
        }
        // check current root isBST, 
        // current root val must be larger than the max val in left subtree,
        // and smaller than the minVal in the right subtree
        if root!.val <= left.maxVal || root!.val >= right.minVal {
            return SubRes(false, 0, 0, 0)
        }
        
        // passed the BST check, update the res
        let s = root!.val + left.sum + right.sum
        res = max(res, s)
        return SubRes(true, s, min(root!.val, left.minVal), max(root!.val, right.maxVal))
    }
}
```