### [1302\. Deepest Leaves Sum](https://leetcode.com/problems/deepest-leaves-sum/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)

Given a binary tree, return the sum of values of its deepest leaves.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2019/07/31/1483_ex1.png)**

```
Input: root = [1,2,3,4,5,null,6,7,null,null,null,null,8]
Output: 15
```

**Constraints:**

*   The number of nodes in the tree is between `1` and `10^4`.
*   The value of nodes is between `1` and `100`.


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
    func deepestLeavesSum(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        var height = getHeight(root)
        var cur_h = 1
        var res = 0
        var queue = [root]
        while !queue.isEmpty {
            let size = queue.count
            for _ in 0..<size {
                let n = queue.removeFirst()
                if cur_h == height {
                    res += n!.val
                }
                if n!.left != nil {
                    queue.append(n!.left)
                }
                if n!.right != nil {
                    queue.append(n!.right)
                }
            }
            cur_h += 1
        }
        return res
    }
    
    private func getHeight(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        return max(getHeight(root!.left), getHeight(root!.right)) + 1
    }
}
```