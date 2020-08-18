### [958\. Check Completeness of a Binary Tree](https://leetcode.com/problems/check-completeness-of-a-binary-tree/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/)


Given a binary tree, determine if it is a _complete binary tree_.

<u style="display: inline;">**Definition of a complete binary tree from :**</u>  
In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2<sup>h</sup> nodes inclusive at the last level h.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2018/12/15/complete-binary-tree-1.png)**

```
Input: [1,2,3,4,5,6]
Output: true
Explanation: Every level before the last is full (ie. levels with node-values {1} and {2, 3}), and all nodes in the last level ({4, 5, 6}) are as far left as possible.
```


**Example 2:**

**![](https://assets.leetcode.com/uploads/2018/12/15/complete-binary-tree-2.png)**

```
Input: [1,2,3,4,5,null,7]
Output: false
Explanation: The node with value 7 isn't as far left as possible.
```


**Note:**

1.  The tree will have between 1 and 100 nodes.


#### Solution

更优解，直接用preorder，如果是慢二叉树的话，空叶节点肯定是在最末尾出现，所以我们用一个标识seen来记录见过的空叶节点，如果seen已经是true了，而后面还有非空节点，那么就是非满二叉树

```swift
class Solution {
    func isCompleteTree(_ root: TreeNode?) -> Bool {
        var queue = [TreeNode?]()
        queue.append(root)
        var seen = false
        
        while (!queue.isEmpty) {
            if let node = queue.removeFirst() {
                if (seen) {
                    return false
                }
                
                queue.append(node.left)
                queue.append(node.right)
            }
            else {
                seen = true
            }
        }
        
        return true
    }
}
```

慢！！！！利用满二叉树的性质，先level order遍历得到原树的数组，然后构建一个新的满二叉树，比较这两个树是否相同。

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
    func isCompleteTree(_ root: TreeNode?) -> Bool {
        var tree_array = [Int]()
        levelOrder(root, &tree_array)
        let myRoot = createTree(from: tree_array, 0)
        levelOrder(myRoot, &tree_array)
        return isSameTree(root, myRoot)
    }
    
    private func createTree(from array: [Int], _ idx: Int) -> TreeNode? {
        if idx >= array.count { return nil }
        let node = TreeNode(array[idx], nil, nil)
        node.left = createTree(from: array, idx * 2 + 1)
        node.right = createTree(from: array, idx * 2 + 2)
        return node
    }
    
    private func isSameTree(_ r1: TreeNode?, _ r2: TreeNode?) -> Bool {
        if r1 == nil && r2 == nil { return true }
        if r1 == nil || r2 == nil { return false }
        if r1!.val != r2!.val { return false }
        return isSameTree(r1!.left, r2!.left) && isSameTree(r1!.right, r2!.right)
    }
    
    private func levelOrder(_ root: TreeNode?, _ array: inout [Int]) {
        if root == nil { return }
        var queue = [root]
        while !queue.isEmpty {
            let size = queue.count
            for _ in 0..<size {
                let node = queue.removeFirst()
                array.append(node!.val)
                
                if node!.left != nil {
                    queue.append(node!.left)
                }
                if node!.right != nil {
                    queue.append(node!.right)
                }
            }
        }
    }
}
```