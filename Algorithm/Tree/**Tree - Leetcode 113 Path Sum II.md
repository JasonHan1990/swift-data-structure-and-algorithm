### [113\. Path Sum II](https://leetcode.com/problems/path-sum-ii/)

Difficulty: **Medium**


Given a binary tree and a sum, find all root-to-leaf paths where each path's sum equals the given sum.

**Note:** A leaf is a node with no children.

**Example:**

Given the below binary tree and `sum = 22`,

```
      5
     / \
    4   8
   /   / \
  11  13  4
 /  \    / \
7    2  5   1
```

Return:

```
[
   [5,4,11,2],
   [5,8,4,5]
]
```


#### Solution

#### 需要注意两个地方
1. 只有在走到leaf的时候才能判断
2. 节点中的值可能是负数，所以，没有办法节支！只能遍历所有的路径。 

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
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        var res = [[Int]]()
        if root == nil { return res }
        dfs(root!, 0, [Int](), sum, &res)
        return res
    }
    
    private func dfs(_ root: TreeNode, _ curSum: Int, _ curRes: [Int], _ sum: Int, _ res: inout [[Int]]) {
        var curRes = curRes
        let curSum = curSum + root.val
        curRes.append(root.val)
        if root.left == nil && root.right == nil { // reach a leaf
            if curSum == sum {
                res.append(curRes)
            }
        } else { // not a leaf
            if root.left != nil {
                dfs(root.left!, curSum, curRes, sum, &res)
            }
​
            if root.right != nil {
                dfs(root.right!, curSum, curRes, sum, &res)
            }
        }
    }
}
        // var curRes = curRes
```