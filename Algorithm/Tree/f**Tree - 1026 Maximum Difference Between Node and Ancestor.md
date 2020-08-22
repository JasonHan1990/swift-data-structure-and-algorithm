### [1026\. Maximum Difference Between Node and Ancestor](https://leetcode.com/problems/maximum-difference-between-node-and-ancestor/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given the `root` of a binary tree, find the maximum value `V` for which there exists **different** nodes `A` and `B` where `V = |A.val - B.val|` and `A` is an ancestor of `B`.

(A node A is an ancestor of B if either: any child of A is equal to B, or any child of A is an ancestor of B.)

**Example 1:**

![](https://assets.leetcode.com/uploads/2019/09/09/2whqcep.jpg)

```
Input: [8,3,10,1,6,null,14,null,null,4,7,13]
Output: 7
Explanation: 
We have various ancestor-node differences, some of which are given below :
|8 - 3| = 5
|3 - 7| = 4
|8 - 1| = 7
|10 - 13| = 3
Among all possible differences, the maximum value of 7 is obtained by |8 - 1| = 7.
```

**Note:**

1.  The number of nodes in the tree is between `2` and `5000`.
2.  Each node will have value between `0` and `100000`.


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
    var res = 0
    func maxAncestorDiff(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        return maxDiff(root, root!.val, root!.val)
    }
    
    // (Int, Int) => (max, min)
    private func maxDiff(_ root: TreeNode?, _ curMin: Int, _ curMax: Int) -> Int {
        if root == nil { return 0 }
        var curMaxDiff = max(abs(root!.val - curMin), abs(root!.val - curMax))
        let nextMin = min(curMin, root!.val)
        let nextMax = max(curMax, root!.val)
        return max(curMaxDiff, maxDiff(root!.left, nextMin, nextMax), maxDiff(root!.right, nextMin, nextMax))
    }
}
```