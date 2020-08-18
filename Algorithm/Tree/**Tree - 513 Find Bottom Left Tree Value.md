### [513\. Find Bottom Left Tree Value](https://leetcode.com/problems/find-bottom-left-tree-value/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/), [Breadth-first Search](https://leetcode.com/tag/breadth-first-search/)


Given a binary tree, find the leftmost value in the last row of the tree.

**Example 1:**  

```
Input:

    2
   / \
  1   3

Output:
1
```

**Example 2:**  

```
Input:

        1
       / \
      2   3
     /   / \
    4   5   6
       /
      7

Output:
7
```

**Note:** You may assume the tree (i.e., the given root node) is not **NULL**.


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
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        var maxLevel = 0
        var ans = root == nil ? 0 : root!.val
        findBottomLeftValue(root, 0, &maxLevel, &ans)
        return ans
    }
    
    private func findBottomLeftValue(_ root: TreeNode?, _ curLevel: Int, _ maxLevel: inout Int, _ ans: inout Int) {
        if root == nil { return }
        
        if root!.left == nil && root!.right == nil {
            if curLevel > maxLevel {
                maxLevel = curLevel
                ans = root!.val
            }
            return
        }
        
        findBottomLeftValue(root!.left, curLevel + 1, &maxLevel, &ans)
        findBottomLeftValue(root!.right, curLevel + 1, &maxLevel, &ans)
    }
}
```