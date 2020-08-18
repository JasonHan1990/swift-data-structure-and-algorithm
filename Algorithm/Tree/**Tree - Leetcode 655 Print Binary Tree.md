### [655\. Print Binary Tree](https://leetcode.com/problems/print-binary-tree/)

Difficulty: **Medium**


Print a binary tree in an m*n 2D string array following these rules:

1.  The row number `m` should be equal to the height of the given binary tree.
2.  The column number `n` should always be an odd number.
3.  The root node's value (in string format) should be put in the exactly middle of the first row it can be put. The column and the row where the root node belongs will separate the rest space into two parts (**left-bottom part and right-bottom part**). You should print the left subtree in the left-bottom part and print the right subtree in the right-bottom part. The left-bottom part and the right-bottom part should have the same size. Even if one subtree is none while the other is not, you don't need to print anything for the none subtree but still need to leave the space as large as that for the other subtree. However, if two subtrees are none, then you don't need to leave space for both of them.
4.  Each unused space should contain an empty string `""`.
5.  Print the subtrees following the same rules.

**Example 1:**  

```
Input:
     1
    /
   2
Output:
[["", "1", ""],
 ["2", "", ""]]
```

**Example 2:**  

```
Input:
     1
    / \
   2   3
    \
     4
Output:
[["", "", "", "1", "", "", ""],
 ["", "2", "", "", "", "3", ""],
 ["", "", "4", "", "", "", ""]]
```

**Example 3:**  

```
Input:
      1
     / \
    2   5
   / 
  3 
 / 
4 
Output:

[["",  "",  "", "",  "", "", "", "1", "",  "",  "",  "",  "", "", ""]
 ["",  "",  "", "2", "", "", "", "",  "",  "",  "",  "5", "", "", ""]
 ["",  "3", "", "",  "", "", "", "",  "",  "",  "",  "",  "", "", ""]
 ["4", "",  "", "",  "", "", "", "",  "",  "",  "",  "",  "", "", ""]]
```

**Note:** The height of binary tree is in the range of [1, 10].


#### Solution
思路：
![](leetcode_655.jpg)

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
    func printTree(_ root: TreeNode?) -> [[String]] {
        var res = [[String]]()
        if root == nil {
            return res
        }
        let height = maxHeight(root)
        // guard depth != 0 else {
        //     return res.append(["\(root.val)"])
        // }
        
        // level traversal to fill the 2d array
        let n = Int(pow(2.0, Double(height))) - 1
        let m = height
        res  = Array(repeating: Array(repeating:"", count:n), count: m)
        printTree(root, 0, n - 1, 0, &res)
        return res
    }
    
    private func maxHeight(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return max(maxHeight(root!.left)  + 1, maxHeight(root!.right) + 1)
    }
    
    private func printTree(_ root: TreeNode?, _ l: Int, _ r: Int, _ curDepth: Int, _ res: inout [[String]]) {
        if root == nil || curDepth == res.count || l > r { return }
        // the middle position to place root value
        let m = l + (r - l)/2
        res[curDepth][m] = "\(root!.val)"
        
        printTree(root!.left, l, m - 1, curDepth + 1, &res)
        printTree(root!.right, m + 1, r, curDepth + 1, &res)
    }
}
```