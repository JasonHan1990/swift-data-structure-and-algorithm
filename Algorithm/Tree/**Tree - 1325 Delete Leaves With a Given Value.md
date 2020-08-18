### [1325\. Delete Leaves With a Given Value](https://leetcode.com/problems/delete-leaves-with-a-given-value/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/)


Given a binary tree `root` and an integer `target`, delete all the **leaf nodes** with value `target`.

Note that once you delete a leaf node with value `target`**, **if it's parent node becomes a leaf node and has the value `<font face="monospace" style="display: inline;">target</font>`, it should also be deleted (you need to continue doing that until you can't).

**Example 1:**

**![](https://assets.leetcode.com/uploads/2020/01/09/sample_1_1684.png)**

```
Input: root = [1,2,3,2,null,2,4], target = 2
Output: [1,null,3,null,4]
Explanation: Leaf nodes in green with value (target = 2) are removed (Picture in left). 
After removing, new nodes become leaf nodes with value (target = 2) (Picture in center).
```

**Example 2:**

**![](https://assets.leetcode.com/uploads/2020/01/09/sample_2_1684.png)**

```
Input: root = [1,3,3,3,2], target = 3
Output: [1,3,null,null,2]
```

**Example 3:**

**![](https://assets.leetcode.com/uploads/2020/01/15/sample_3_1684.png)**

```
Input: root = [1,2,null,2,null,2], target = 2
Output: [1]
Explanation: Leaf nodes in green with value (target = 2) are removed at each step.
```

**Example 4:**

```
Input: root = [1,1,1], target = 1
Output: []
```

**Example 5:**

```
Input: root = [1,2,3], target = 1
Output: [1,2,3]
```

**Constraints:**

*   `1 <= target <= 1000`
*   The given binary tree will have between `1` and `3000` nodes.
*   Each node's value is between `[1, 1000]`.


#### Solution
DFS / POSTORDER
思路: 这个题的例子非常直接，提醒你需要先走到leaves，然后check它们是不是需要删除，然后popback到上一层。

注意，一定不要写成preorder了，preorder会保住当前的root。

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
    func removeLeafNodes(_ root: TreeNode?, _ target: Int) -> TreeNode? {
        // root is nil, return nil
        if root == nil {
            return nil
        }
        
        // Postorder, go check the leaves first
        root!.left = removeLeafNodes(root!.left, target)
        root!.right = removeLeafNodes(root!.right, target)
        
        // root is a leaf and val == target, return nil
        if root!.val == target && root!.left == nil && root!.right == nil {
            return nil
        }
        
        return root 
    }
}
```