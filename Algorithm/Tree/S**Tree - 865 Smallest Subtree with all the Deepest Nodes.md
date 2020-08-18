### [865\. Smallest Subtree with all the Deepest Nodes](https://leetcode.com/problems/smallest-subtree-with-all-the-deepest-nodes/)

Difficulty: **Medium**


Given a binary tree rooted at `root`, the _depth_ of each node is the shortest distance to the root.

A node is _deepest_ if it has the largest depth possible among any node in the <u style="display: inline;">entire tree</u>.

The subtree of a node is that node, plus the set of all descendants of that node.

Return the node with the largest depth such that it contains all the deepest nodes in its subtree.

**Example 1:**

```
Input: [3,5,1,6,2,0,8,null,null,7,4]
Output: [2,7,4]
Explanation:

We return the node with value 2, colored in yellow in the diagram.
The nodes colored in blue are the deepest nodes of the tree.
The input "[3, 5, 1, 6, 2, 0, 8, null, null, 7, 4]" is a serialization of the given tree.
The output "[2, 7, 4]" is a serialization of the subtree rooted at the node with value 2.
Both the input and output have TreeNode type.
```

**Note:**

*   The number of nodes in the tree will be between 1 and 500.
*   The values of each node are unique.


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
    func subtreeWithAllDeepest(_ root: TreeNode?) -> TreeNode? {
        if root == nil { return root }
        let l = height(root!.left)
        let r = height(root!.right)
        if l == r {
            return root
        } else if l < r {
            return subtreeWithAllDeepest(root!.right)
        } else {
            return subtreeWithAllDeepest(root!.left)
        }
    }
    
    private func height(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        return max(height(root!.left), height(root!.right)) + 1
    }
}
```