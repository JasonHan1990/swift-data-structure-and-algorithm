### [894\. All Possible Full Binary Trees](https://leetcode.com/problems/all-possible-full-binary-trees/)

Difficulty: **Medium**


A _full binary tree_ is a binary tree where each node has exactly 0 or 2 children.

Return a list of all possible full binary trees with `N` nodes.  Each element of the answer is the root node of one possible tree.

Each `node` of each tree in the answer **must** have `node.val = 0`.

You may return the final list of trees in any order.

**Example 1:**

```
Input: 7
Output: [[0,0,0,null,null,0,0,null,null,0,0],[0,0,0,null,null,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,null,null,null,null,0,0],[0,0,0,0,0,null,null,0,0]]
Explanation:

```
![](894.png)

**Note:**

*   `1 <= N <= 20`


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
    func allPossibleFBT(_ N: Int) -> [TreeNode?] {
        if N % 2 == 0 { return [TreeNode?]() } 
        if N == 1 { return [TreeNode(0)] }
        var ans = [TreeNode?]()
        
        for i in stride(from: 1, to: N - 1, by: 2) {
            let left = allPossibleFBT(i)
            let right = allPossibleFBT(N - 1 - i)
            
            for l in left {
                for r in right {
                    ans.append(TreeNode(0, l, r))
                }
            }
        }
        return ans
    }
}
```