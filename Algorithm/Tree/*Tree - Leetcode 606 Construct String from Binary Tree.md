### [606\. Construct String from Binary Tree](https://leetcode.com/problems/construct-string-from-binary-tree/)

Difficulty: **Easy**


You need to construct a string consists of parenthesis and integers from a binary tree with the preorder traversing way.

The null node needs to be represented by empty parenthesis pair "()". And you need to omit all the empty parenthesis pairs that don't affect the one-to-one mapping relationship between the string and the original binary tree.

**Example 1:**  

```
Input: Binary tree: [1,2,3,4]
       1
     /   \
    2     3
   /    
  4     

Output: "1(2(4))(3)"
Explanation: Originallay it needs to be "1(2(4)())(3()())", but you need to omit all the unnecessary empty parenthesis pairs. And it will be "1(2(4))(3)".
```

**Example 2:**  

```
Input: Binary tree: [1,2,3,null,4]
       1
     /   \
    2     3
     \  
      4 

Output: "1(2()(4))(3)"
Explanation: Almost the same as the first example, except we can't omit the first parenthesis pair to break the one-to-one mapping relationship between the input and the output.
```


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
    func tree2str(_ t: TreeNode?) -> String {
        var res = ""
        tree2str(t, false, &res)
        return res
    }
    
    private func tree2str(_ t: TreeNode?, _ isLeft: Bool, _ res: inout String) {
        if t == nil {
            return
        }
        
        res += "\(t!.val)"
        if t!.left != nil || t!.right != nil {
            res += "("
            tree2str(t!.left, true, &res)
            res += ")"
        }
        if t!.right != nil {
            res += "("
            tree2str(t!.right, true, &res)
            res += ")"
        }
        
    }
}
```