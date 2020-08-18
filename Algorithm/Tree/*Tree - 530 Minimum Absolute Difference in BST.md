### [530\. Minimum Absolute Difference in BST](https://leetcode.com/problems/minimum-absolute-difference-in-bst/)

Difficulty: **Easy**


Given a binary search tree with non-negative values, find the minimum between values of any two nodes.

**Example:**

```
Input:

   1
    \
     3
    /
   2

Output:
1

Explanation:
The minimum absolute difference is 1, which is the difference between 2 and 1 (or between 2 and 3).
```

**Note:**

*   There are at least two nodes in this BST.
*   This question is the same as 783: 


#### Solution 1

BTS 的特点就是对于任意一个node，它的左边最后一个右节点是小于这个节点的最大值，
它的右边最后一个左节点是大于这个节点的最小值。那么对于每一个节点，min diff就是
在它和这两个节点之间做比较产生的。

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
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        var ans = Int.max
        getMinDiff(root, &ans)
        return ans
    }
    
    private func getMinDiff(_ root: TreeNode?, _ ans: inout Int) {
        if root == nil { return }
        var left = Int.max, right = Int.max
        var cur = root!.left
        while cur != nil && cur!.right != nil {
            cur = cur!.right
        }
        if cur != nil {
            left = abs(root!.val - cur!.val)
        }
        cur = root!.right
        while cur != nil && cur!.left != nil {
            cur = cur!.left
        }
        if cur != nil {
            right = abs(root!.val - cur!.val)
        }
        ans = min(left, right, ans)
        
        if root!.left != nil {
            getMinDiff(root!.left, &ans)
        }
        if root!.right != nil {
            getMinDiff(root!.right, &ans)
        }
    }
}
```

#### Solution 2

BST的中序遍历就是一个有序数列，我们只需要记录每一次中序遍历的前一个数，然后和现在这个数求绝对值，在这些值中就有min diff



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
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        var ans = Int.max
        var prev: Int? = nil
        getMinDiff(root, &prev, &ans)
        return ans
    }
    
    private func getMinDiff(_ root: TreeNode?, _ prev: inout Int?, _ ans: inout Int) {
        if root == nil { return }
        
        getMinDiff(root!.left, &prev, &ans)
        if prev != nil { ans = min(ans, abs(prev! - root!.val)) }
        prev = root!.val
        getMinDiff(root!.right, &prev, &ans)
    }
}
```