### [623\. Add One Row to Tree](https://leetcode.com/problems/add-one-row-to-tree/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/)


Given the root of a binary tree, then value `v` and depth `d`, you need to add a row of nodes with value `v` at the given depth `d`. The root node is at depth 1\.

The adding rule is: given a positive integer depth `d`, for each NOT null tree nodes `N` in depth `d-1`, create two tree nodes with value `v` as `N's` left subtree root and right subtree root. And `N's` **original left subtree** should be the left subtree of the new left subtree root, its **original right subtree** should be the right subtree of the new right subtree root. If depth `d` is 1 that means there is no depth d-1 at all, then create a tree node with value **v** as the new root of the whole original tree, and the original tree is the new root's left subtree.

**Example 1:**  

```
Input: 
A binary tree as following:
       4
     /   \
    2     6
   / \   / 
  3   1 5   

v = 1

d = 2

Output: 
       4
      / \
     1   1
    /     \
   2       6
  / \     / 
 3   1   5   

```

**Example 2:**  

```
Input: 
A binary tree as following:
      4
     /   
    2    
   / \   
  3   1    

v = 1

d = 3

Output: 
      4
     /   
    2
   / \    
  1   1
 /     \  
3       1
```

**Note:**  

1.  The given d is in range [1, maximum depth of the given tree + 1].
2.  The given binary tree has at least one tree node.


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
class Solution1 {  // level order
    func addOneRow(_ root: TreeNode?, _ v: Int, _ d: Int) -> TreeNode? {
        // level-order
        
        var currDepth = 1
        
        if currDepth == d {
            let newRoot = TreeNode(v, root, nil)
            return newRoot
        }
        
        var queue = [root]
        
        while !queue.isEmpty {
            let size = queue.count
            for i in 0..<size {
                let n = queue.removeFirst()!
               
                if currDepth == d - 1 {
                    let newLeft = TreeNode(v, nil, nil)
                    let oldLeft = n.left
                    n.left = newLeft
                    newLeft.left = oldLeft 
                }
                if n.left != nil {
                    queue.append(n.left)
                }
                if currDepth == d - 1 {
                    let newRight = TreeNode(v, nil, nil)
                    let oldRight = n.right
                    n.right = newRight
                    newRight.right = oldRight
                }
                if n.right != nil {
                    queue.append(n.right)
                }
            }
            if currDepth == d - 1 {
                break
            }
            currDepth += 1
        }
        
        return root
    }
}


class Solution2 {  // pre order
    func addOneRow(_ root: TreeNode?, _ v: Int, _ d: Int) -> TreeNode? {
        
        func preOrder(_ root: TreeNode?, _ depth: Int) {
            if root == nil { return }
            
            if depth == d - 1 {
                root!.left = TreeNode(v, root!.left, nil)
                root!.right = TreeNode(v, nil, root!.right)
                return
            }
            preOrder(root!.left, depth + 1)
            preOrder(root!.right, depth + 1)
        }
        
        if d == 1 {
            let newRoot = TreeNode(v, root, nil)
            return newRoot
        } else {
            preOrder(root, 1)
            return root
        }
    }
}
```