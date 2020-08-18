### [1305\. All Elements in Two Binary Search Trees](https://leetcode.com/problems/all-elements-in-two-binary-search-trees/)

Difficulty: **Medium**


Given two binary search trees `root1` and `root2`.

Return a list containing _all the integers_ from _both trees_ sorted in **ascending** order.

**Example 1:**

![](https://assets.leetcode.com/uploads/2019/12/18/q2-e1.png)

```
Input: root1 = [2,1,4], root2 = [1,0,3]
Output: [0,1,1,2,3,4]
```

**Example 2:**

```
Input: root1 = [0,-10,10], root2 = [5,1,7,0,2]
Output: [-10,0,0,1,2,5,7,10]
```

**Example 3:**

```
Input: root1 = [], root2 = [5,1,7,0,2]
Output: [0,1,2,5,7]
```

**Example 4:**

```
Input: root1 = [0,-10,10], root2 = []
Output: [-10,0,10]
```

**Example 5:**

![](https://assets.leetcode.com/uploads/2019/12/18/q2-e5-.png)

```
Input: root1 = [1,null,8], root2 = [8,1]
Output: [1,1,8,8]
```

**Constraints:**

*   Each tree has at most `5000` nodes.
*   Each node's value is between `[-10^5, 10^5]`.


#### Solution 1
Compare to solution 2, the differece is that it generate the anwser while traveraling the two trees.
So it is faster than solution 2.

The idea is using a stack to store current left traversal, compare the top of two stacks, pop the smaller one and added it to ans

#### Solution 2
Use inorder traversal to get two sorted array, then merge two array. O(n)

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
    func getAllElements(_ root1: TreeNode?, _ root2: TreeNode?) -> [Int] {
        var a = [Int](), b = [Int]()
        bstToArray(root1, &a)
        bstToArray(root2, &b)
        
        return mergeTwoSortedArray(a, b)
    }
    
    func bstToArray(_ root: TreeNode?, _ array: inout [Int]) {
        if root == nil { return }
        bstToArray(root!.left, &array)
        array.append(root!.val)
        bstToArray(root!.right, &array)
    }
    
    func mergeTwoSortedArray(_ a: [Int], _ b: [Int]) -> [Int] {
        var ans = [Int]()
        var i = 0, j = 0
        while i < a.count && j < b.count {
            if a[i] <= b[j] {
                ans.append(a[i])
                i += 1
            } else {
                ans.append(b[j])
                j += 1
            }
        }
        
        if i != a.count {
            ans.append(contentsOf: a[i..<a.count])
        }
        if j != b.count {
            ans.append(contentsOf: b[j..<b.count])
        }
        return ans
    }
}
```