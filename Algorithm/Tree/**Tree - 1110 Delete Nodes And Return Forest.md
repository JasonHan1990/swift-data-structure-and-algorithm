### [1110\. Delete Nodes And Return Forest](https://leetcode.com/problems/delete-nodes-and-return-forest/)

Difficulty: **Medium**


Given the `root` of a binary tree, each node in the tree has a distinct value.

After deleting all nodes with a value in `to_delete`, we are left with a forest (a disjoint union of trees).

Return the roots of the trees in the remaining forest.  You may return the result in any order.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2019/07/01/screen-shot-2019-07-01-at-53836-pm.png)**

```
Input: root = [1,2,3,4,5,6,7], to_delete = [3,5]
Output: [[1,2,null,4],[6],[7]]
```

**Constraints:**

*   The number of nodes in the given tree is at most `1000`.
*   Each node has a distinct value between `1` and `1000`.
*   `to_delete.length <= 1000`
*   `to_delete` contains distinct values between `1` and `1000`.

#### Solution 1
Fast, post-order

```swift
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    func delNodes(_ root: TreeNode?, _ to_delete: [Int]) -> [TreeNode?] {
        var ans = [TreeNode?]()
        let root = delete(to_delete, root, &ans)
        if root != nil { ans.append(root) }
        return ans
    }
    
    private func delete(_ to_delete: [Int], _ root: TreeNode?, _ ans: inout [TreeNode?]) -> TreeNode? {
        if root == nil { return nil }
        root!.left = delete(to_delete, root!.left, &ans)
        root!.right = delete(to_delete, root!.right, &ans)
        // if root is not the node to delete, add back to its parent
        if !to_delete.contains(root!.val) { return root }
        // else, append its left and right to the ans, and return nil
        if root!.left != nil { ans.append(root!.left) }
        if root!.right != nil { ans.append(root!.right) }
        return nil
    }
}
```

#### Solution 2
Slow, pre-order, from top to bottom to find the delete val, and make changes to the answer.

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
    func delNodes(_ root: TreeNode?, _ to_delete: [Int]) -> [TreeNode?] {
        var ans = [root]
        for i in to_delete {
            let copy = ans
            for node in copy {
                if findAndDelete(i, node, nil, &ans) {
                    break
                }
            }
        }
        return ans
    }
    
    private func findAndDelete(_ delete: Int, _ root: TreeNode?, _ pre: TreeNode?, _ ans: inout [TreeNode?]) -> Bool {
        if root == nil { return false }
        if root!.val == delete {
            if pre != nil { // break the link
                if pre!.left === root {
                    pre!.left = nil
                }
                if pre!.right === root {
                    pre!.right = nil
                }
            } else {
                // and this root is in the ans, delete it
                if let index = ans.firstIndex(where: { $0 === root }) {
                    ans.remove(at: index)
                }
            }
            if root!.left != nil {
                ans.append(root!.left)
            }
            if root!.right != nil {
                ans.append(root!.right)
            }
            return true
        }
        
        return findAndDelete(delete, root!.left, root, &ans) || findAndDelete(delete, root!.right, root, &ans)
    }
}
```