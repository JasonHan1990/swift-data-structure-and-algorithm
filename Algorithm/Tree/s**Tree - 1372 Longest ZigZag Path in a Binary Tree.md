### [1372\. Longest ZigZag Path in a Binary Tree](https://leetcode.com/problems/longest-zigzag-path-in-a-binary-tree/)

Difficulty: **Medium**  

Related Topics: [Dynamic Programming](https://leetcode.com/tag/dynamic-programming/), [Tree](https://leetcode.com/tag/tree/)


Given a binary tree `root`, a ZigZag path for a binary tree is defined as follow:

*   Choose **any** node in the binary tree and a direction (right or left).
*   If the current direction is right then move to the right child of the current node otherwise move to the left child.
*   Change the direction from right to left or right to left.
*   Repeat the second and third step until you can't move in the tree.

Zigzag length is defined as the number of nodes visited - 1\. (A single node has a length of 0).

Return the longest **ZigZag** path contained in that tree.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2020/01/22/sample_1_1702.png)**

```
Input: root = [1,null,1,1,1,null,null,1,1,null,1,null,null,null,1,null,1]
Output: 3
Explanation: Longest ZigZag path in blue nodes (right -> left -> right).
```

**Example 2:**

**![](https://assets.leetcode.com/uploads/2020/01/22/sample_2_1702.png)**

```
Input: root = [1,1,1,null,1,null,null,1,1,null,1]
Output: 4
Explanation: Longest ZigZag path in blue nodes (left -> right -> left -> right).
```

**Example 3:**

```
Input: root = [1]
Output: 0
```

**Constraints:**

*   Each tree has at most `50000` nodes..
*   Each node's value is between `[1, 100]`.


#### Solution 1: Too Slow, Topdown

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
    
    func longestZigZag(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        var maxLeft = 0, maxRight = 0
        countLongestZigZag(root!.left, 0, &maxLeft, true)
        countLongestZigZag(root!.right, 0, &maxRight, false)
        
        return max(maxLeft, maxRight, longestZigZag(root!.left), longestZigZag(root!.right))
    }
    
    private func countLongestZigZag(_ root: TreeNode?, _ cur: Int, _ maxCount: inout Int, _ lastLeft: Bool) {
        if root == nil { 
            maxCount = max(cur, maxCount)
            return 
        }
    
        if lastLeft {
            countLongestZigZag(root!.right, cur + 1, &maxCount, false)
        } else {
            countLongestZigZag(root!.left, cur + 1, &maxCount, true)
        }
    }
}
```

#### Solution 2: Bottom up

Language: **Swift**

```swift
class Solution {
    
//     // The Counts contains
//     // 1. The max ZigZag path length if go left
//     // 2. The max ZigZag path length if go right
//     // 3. The max ZigZag path length within the subtree
//     struct Counts {
//         var left: Int
//         var right: Int
//         var sub: Int
//         init(_ left: Int, _ right: Int, _ sub: Int) {
//             self.left = left
//             self.right = right
//             self.sub = sub
//         }
//     }
    
//     func longestZigZag(_ root: TreeNode?) -> Int {
//         return zigZag(root).sub
//     }
    
//     private func zigZag(_ root: TreeNode?) -> Counts {
//         if root == nil { return Counts(-1, -1, -1) }
        
//         let goLeft = zigZag(root!.left)
//         let goRight = zigZag(root!.right)
//         // For this root, if it is a left child of its parent:
//         let l = goLeft.right + 1   
//         // For this root, if it is a right child of its parent:
//         let r = goRight.left + 1
//         return Counts(l, r, max(l, r, goLeft.sub, goRight.sub))
//     }

    func step(_ root: TreeNode?, _ isRight: Bool, _ ans: inout Int) -> Int {
        if root == nil {
            return 0
        }
        
        let right = step(root!.right, true, &ans) + 1
        let left = step(root!.left, false, &ans) + 1
        ans = max(ans, max(right, left))
        if isRight {
            return left            
        } else {
            return right
        }
    }
    
    func longestZigZag(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        var ans = 0
        step(root, true, &ans)
        return ans - 1
    }

}
```