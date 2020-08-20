### [1123\. Lowest Common Ancestor of Deepest Leaves](https://leetcode.com/problems/lowest-common-ancestor-of-deepest-leaves/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given a rooted binary tree, return the lowest common ancestor of its deepest leaves.

Recall that:

*   The node of a binary tree is a _leaf_ if and only if it has no children
*   The _depth_ of the root of the tree is 0, and if the depth of a node is `d`, the depth of each of its children is `d+1`.
*   The _lowest common ancestor_ of a set `S` of nodes is the node `A` with the largest depth such that every node in S is in the subtree with root `A`.

**Example 1:**

```
Input: root = [1,2,3]
Output: [1,2,3]
Explanation: 
The deepest leaves are the nodes with values 2 and 3.
The lowest common ancestor of these leaves is the node with value 1.
The answer returned is a TreeNode object (not an array) with serialization "[1,2,3]".
```

**Example 2:**

```
Input: root = [1,2,3,4]
Output: [4]
```

**Example 3:**

```
Input: root = [1,2,3,4,5]
Output: [2,4,5]
```

**Constraints:**

*   The given tree will have between 1 and 1000 nodes.
*   Each node of the tree will have a distinct value between 1 and 1000.


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
​
extension TreeNode : Hashable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
​
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
}
class Solution {
    var dict = [TreeNode : Int]()
    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        if root == nil { return nil }
        let left = getDepth(root!.left), right = getDepth(root!.right)
        // If left height  ==  right height, return root
        if left == right {
            return root
        }
        return left > right ? lcaDeepestLeaves(root!.left) : lcaDeepestLeaves(root!.right)
    }
    
    private func getDepth(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        if dict[root!] != nil {
            return dict[root!]!
        } else {
            dict[root!] = max(getDepth(root!.left), getDepth(root!.right)) + 1
            return dict[root!]!
        }
    }
}
```