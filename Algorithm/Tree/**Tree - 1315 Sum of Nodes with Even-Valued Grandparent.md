### [1315\. Sum of Nodes with Even-Valued Grandparent](https://leetcode.com/problems/sum-of-nodes-with-even-valued-grandparent/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given a binary tree, return the sum of values of nodes with even-valued grandparent.  (A _grandparent_ of a node is the parent of its parent, if it exists.)

If there are no nodes with an even-valued grandparent, return `0`.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2019/07/24/1473_ex1.png)**

```
Input: root = [6,7,8,2,7,1,3,9,null,1,4,null,null,null,5]
Output: 18
Explanation: The red nodes are the nodes with even-value grandparent while the blue nodes are the even-value grandparents.
```

**Constraints:**

*   The number of nodes in the tree is between `1` and `10^4`.
*   The value of nodes is between `1` and `100`.


#### Solution

DFS, Postorder, for each root, return its left child and right child as the grad children for its parent.

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
    func sumEvenGrandparent(_ root: TreeNode?) -> Int {
        var res = 0
        grandparent(root, &res)
        return res
    }
    
    // return grad children
    private func grandparent(_ root: TreeNode?, _ res: inout Int ) -> [TreeNode] {
        if root == nil { return [TreeNode]() }
        if root!.left == nil && root!.right == nil { return [TreeNode]() }
        
        let l_GrandChilds = grandparent(root!.left, &res)
        let r_GrandChilds = grandparent(root!.right, &res)
        
        if root!.val % 2 == 0 {
            for l_c in l_GrandChilds {
                res += l_c.val
            }
            for r_c in r_GrandChilds {
                res += r_c.val
            }
        }
        
        // prepare the ret for its parent
        var ret = [TreeNode]() 
        if root!.left != nil {
            ret.append(root!.left!)
        }
        if root!.right != nil {
            ret.append(root!.right!)
        }
        return ret
    }
}
```