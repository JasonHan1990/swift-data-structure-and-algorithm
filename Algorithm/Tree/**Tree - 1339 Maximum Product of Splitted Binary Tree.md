### [1339\. Maximum Product of Splitted Binary Tree](https://leetcode.com/problems/maximum-product-of-splitted-binary-tree/)

Difficulty: **Medium**  

Related Topics: [Dynamic Programming](https://leetcode.com/tag/dynamic-programming/), [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given a binary tree `root`. Split the binary tree into two subtrees by removing 1 edge such that the product of the sums of the subtrees are maximized.

Since the answer may be too large, return it modulo 10^9 + 7.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2020/01/21/sample_1_1699.png)**

```
Input: root = [1,2,3,4,5,6]
Output: 110
Explanation: Remove the red edge and get 2 binary trees with sum 11 and 10\. Their product is 110 (11*10)
```

**Example 2:**

![](https://assets.leetcode.com/uploads/2020/01/21/sample_2_1699.png)

```
Input: root = [1,null,2,3,4,null,null,5,6]
Output: 90
Explanation:  Remove the red edge and get 2 binary trees with sum 15 and 6.Their product is 90 (15*6)
```

**Example 3:**

```
Input: root = [2,3,9,10,7,8,6,5,4,11,1]
Output: 1025
```

**Example 4:**

```
Input: root = [1,1]
Output: 1
```

**Constraints:**

*   Each tree has at most `50000` nodes and at least `2` nodes.
*   Each node's value is between `[1, 10000]`.


#### Solution
思路就是 先遍历一遍树，得到树的总和sum。 然后从每一个local节点看，他只能知道自己左边子树的和left 和 右边子树的和right，那么对于left来说，sum - left就是断开left这个边的剩余树的所有节点之和，那么left *（sum - left）就是一个解。右边同理。那么对每一个节点都这么做，每次更新结果。

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
    func maxProduct(_ root: TreeNode?) -> Int {
        var sum = 0
        sumOfTree(root, &sum)
        print(sum)
        var res = 0
        let mod = 1000000007
        maxProduct(root, &res, sum)
        return res % mod
    }
    
    private func maxProduct(_ root: TreeNode?, _ res: inout Int, _ sum: Int) -> Int {
        if root == nil { return 0 }
        let left = maxProduct(root!.left, &res, sum)
        let right = maxProduct(root!.right, &res, sum)
        res = max(res, max(left * (sum - left), right * (sum - right)))
        return root!.val + left + right
    }
    
    private func sumOfTree(_ root: TreeNode?, _ sum: inout Int) {
        if root == nil { return }
        sum += root!.val
        sumOfTree(root!.left, &sum)
        sumOfTree(root!.right, &sum)
    }
}
```