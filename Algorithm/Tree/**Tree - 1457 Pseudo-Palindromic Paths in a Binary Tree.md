### [1457\. Pseudo-Palindromic Paths in a Binary Tree](https://leetcode.com/problems/pseudo-palindromic-paths-in-a-binary-tree/)

Difficulty: **Medium**  

Related Topics: [Bit Manipulation](https://leetcode.com/tag/bit-manipulation/), [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given a binary tree where node values are digits from 1 to 9\. A path in the binary tree is said to be **pseudo-palindromic** if at least one permutation of the node values in the path is a palindrome.

_Return the number of **pseudo-palindromic** paths going from the root node to leaf nodes._

**Example 1:**

![](https://assets.leetcode.com/uploads/2020/05/06/palindromic_paths_1.png)

```
Input: root = [2,3,1,3,1,null,1]
Output: 2 
Explanation: The figure above represents the given binary tree. There are three paths going from the root node to leaf nodes: the red path [2,3,3], the green path [2,1,1], and the path [2,3,1]. Among these paths only red path and green path are pseudo-palindromic paths since the red path [2,3,3] can be rearranged in [3,2,3] (palindrome) and the green path [2,1,1] can be rearranged in [1,2,1] (palindrome).
```

**Example 2:**

**![](https://assets.leetcode.com/uploads/2020/05/07/palindromic_paths_2.png)**

```
Input: root = [2,1,1,1,3,null,null,null,null,null,1]
Output: 1 
Explanation: The figure above represents the given binary tree. There are three paths going from the root node to leaf nodes: the green path [2,1,1], the path [2,1,3,1], and the path [2,1]. Among these paths only the green path is pseudo-palindromic since [2,1,1] can be rearranged in [1,2,1] (palindrome).
```

**Example 3:**

```
Input: root = [9]
Output: 1
```

**Constraints:**

*   The given binary tree will have between `1` and `10^5` nodes.
*   Node values are digits from `1` to `9`.


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
    func pseudoPalindromicPaths (_ root: TreeNode?) -> Int {
        var res = 0
        pseudoPalindromicPaths(root, [Int : Int](), &res)
        return res
    }
    
    private func pseudoPalindromicPaths(_ root: TreeNode?, _ dict: [Int: Int], _ res: inout Int) {
        if root == nil { 
            return 
        }
        
        var dict = dict
        if let count = dict[root!.val] {
            dict[root!.val] = count + 1
        } else {
            dict[root!.val] = 1
        }
        
         // if this root is a leaf
        if root!.left == nil && root!.right == nil {
            if canPseudoPalindromic(dict) {
                res += 1
            }
            return
        }
        
        pseudoPalindromicPaths(root!.left, dict, &res)
        pseudoPalindromicPaths(root!.right, dict, &res)
    }
    // PseudoPalindromic中最多只能有一个元素是单数个
    private func canPseudoPalindromic(_ dict: [Int: Int]) -> Bool {
        var hasEven = false
        for k in dict.keys {
            if dict[k]! % 2 != 0 {
                if hasEven {
                    return false
                }
                hasEven = true
            }
        }
        return true
    }
}
```