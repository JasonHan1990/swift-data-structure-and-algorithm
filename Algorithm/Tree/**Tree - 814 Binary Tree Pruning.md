### [814\. Binary Tree Pruning](https://leetcode.com/problems/binary-tree-pruning/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/)


We are given the head node `root` of a binary tree, where additionally every node's value is either a 0 or a 1.

Return the same tree where every subtree (of the given tree) not containing a 1 has been removed.

(Recall that the subtree of a node X is X, plus every node that is a descendant of X.)

```
Example 1:
Input: [1,null,0,0,1]
Output: [1,null,0,null,1]

Explanation: 
Only the red nodes satisfy the property "every subtree not containing a 1".
The diagram on the right represents the answer.

```
![](814_example_1.png)
```
Example 2:
Input: [1,0,1,0,0,0,1]
Output: [1,null,1,null,1]

```
![](814_example_2.png)
```
Example 3:
Input: [1,1,0,1,1,0,1,0]
Output: [1,1,0,1,1,null,1]

```
![](814_example_3.png)
**Note:**

*   The binary tree will have at most `200 nodes`.
*   The value of each node will only be `0` or `1`.


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
    func pruneTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil { return nil }
        
        let left = pruneTree(root!.left)
        let right = pruneTree(root!.right)
        
        if left == nil && right == nil && root!.val == 0 {
            return nil
        } else {
            root!.left = left
            root!.right = right
            return root
        }
    }
    
}
        let left = pruneTree(root!.left)
```