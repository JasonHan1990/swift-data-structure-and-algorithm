### [919\. Complete Binary Tree Inserter](https://leetcode.com/problems/complete-binary-tree-inserter/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/)


A _complete_ binary tree is a binary tree in which every level, except possibly the last, is completely filled, and all nodes are as far left as possible.

Write a data structure `CBTInserter` that is initialized with a complete binary tree and supports the following operations:

*   `CBTInserter(TreeNode root)` initializes the data structure on a given tree with head node `root`;
*   `CBTInserter.insert(int v)` will insert a `TreeNode` into the tree with value `node.val = v` so that the tree remains complete, **and returns the value of the parent of the inserted `TreeNode`**;
*   `CBTInserter.get_root()` will return the head node of the tree.


**Example 1:**

```
Input: inputs = ["CBTInserter","insert","get_root"], inputs = [[[1]],[2],[]]
Output: [null,1,[1,2]]
```


**Example 2:**

```
Input: inputs = ["CBTInserter","insert","insert","get_root"], inputs = [[[1,2,3,4,5,6]],[7],[8],[]]
Output: [null,3,4,[1,2,3,4,5,6,7,8]]
```


**Note:**

1.  The initial given tree is complete and contains between `1` and `1000` nodes.
2.  `CBTInserter.insert` is called at most `10000` times per test case.
3.  Every value of a given or inserted node is between `0` and `5000`.


#### Solution

利用满二叉树的特点，用数组的高效坐标查找来加速insert这个func

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
class CBTInserter {
    
    var val_array = [Int]()
    var node_array = [TreeNode]()
​
    init(_ root: TreeNode?) {
        // use level order to init the two arrays
        if root == nil { return }
        var queue = [root]
        while !queue.isEmpty {
            let size = queue.count
            for _ in 0..<size {
                let n = queue.removeFirst()
                val_array.append(n!.val)
                node_array.append(n!)
                if n!.left != nil {
                    queue.append(n!.left)
                }
                if n!.right != nil {
                    queue.append(n!.right)
                }
            }
        }
    }
    
    func insert(_ v: Int) -> Int {
        val_array.append(v)
        var idx = val_array.count - 1
        var parent_idx = 0
        if idx % 2 == 0 {
            parent_idx = (idx - 2) / 2
        } else {
            parent_idx = (idx - 1) / 2
        }
        let parent = node_array[parent_idx]
        let new_node = TreeNode(v, nil, nil)
        if parent.left == nil {
            parent.left = new_node
        } else if parent.right == nil {
            parent.right = new_node
        }
        node_array.append(new_node)
        return val_array[parent_idx]
    }
    
    func get_root() -> TreeNode? {
        return node_array.count == 0 ? nil : node_array[0]
    }
}
​
/**
 * Your CBTInserter object will be instantiated and called as such:
 * let obj = CBTInserter(root)
 * let ret_1: Int = obj.insert(v)
 * let ret_2: TreeNode? = obj.get_root()
 */
```