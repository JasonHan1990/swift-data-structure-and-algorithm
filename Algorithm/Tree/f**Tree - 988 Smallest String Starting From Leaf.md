### [988\. Smallest String Starting From Leaf](https://leetcode.com/problems/smallest-string-starting-from-leaf/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


Given the `root` of a binary tree, each node has a value from `0` to `25` representing the letters `'a'` to `'z'`: a value of `0` represents `'a'`, a value of `1` represents `'b'`, and so on.

Find the lexicographically smallest string that starts at a leaf of this tree and ends at the root.

_(As a reminder, any shorter prefix of a string is lexicographically smaller: for example, `"ab"` is lexicographically smaller than `"aba"`.  A leaf of a node is a node that has no children.)_


**Example 1:**

**![](https://assets.leetcode.com/uploads/2019/01/30/tree1.png)**

```
Input: [0,1,2,3,4,3,4]
Output: "dba"
```


**Example 2:**

**![](https://assets.leetcode.com/uploads/2019/01/30/tree2.png)**

```
Input: [25,1,3,1,3,0,2]
Output: "adz"
```


**Example 3:**

**![](https://assets.leetcode.com/uploads/2019/02/01/tree3.png)**

```
Input: [2,2,1,null,1,0,null,0]
Output: "abc"
```

**Note:**

1.  The number of nodes in the given tree will be between `1` and `8500`.
2.  Each node in the tree will have a value between `0` and `25`.


#### Solution

Brute force: DFS construct string from root to its children.

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
    let startingValue = Int(("a" as UnicodeScalar).value)
    func smallestFromLeaf(_ root: TreeNode?) -> String {
        var allStrings = [String]()
        stringFromLeaf(root, "", &allStrings)
        allStrings = allStrings.sorted()
        return allStrings[0]
    }
   
    private func stringFromLeaf(_ root: TreeNode?, _ curString: String, _ allStrings: inout [String]) {
        if root == nil {
            return 
        }
        
        if root!.left == nil && root!.right == nil {
            var curString = curString
            curString += String(UnicodeScalar(root!.val + startingValue)!)
            allStrings.append(String(curString.reversed()))
            return 
        }
        
        var curString = curString
        curString += String(UnicodeScalar(root!.val + startingValue)!)
        
        stringFromLeaf(root!.left, curString, &allStrings)
        stringFromLeaf(root!.right, curString, &allStrings)
    }
}
```