### [654\. Maximum Binary Tree](https://leetcode.com/problems/maximum-binary-tree/)

Difficulty: **Medium**


Given an integer array with no duplicates. A maximum tree building on this array is defined as follow:

1.  The root is the maximum number in the array.
2.  The left subtree is the maximum tree constructed from left part subarray divided by the maximum number.
3.  The right subtree is the maximum tree constructed from right part subarray divided by the maximum number.

Construct the maximum tree by the given array and output the root node of this tree.

**Example 1:**  

```
Input: [3,2,1,6,0,5]
Output: return the tree root node representing the following tree:

      6
    /   \
   3     5
    \    / 
     2  0   
       \
        1
```

**Note:**  

1.  The size of the given array will be in the range [1,1000].


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
    func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        return constructMaximumBinaryTree(nums, 0, nums.count - 1)
    }
    
    private func constructMaximumBinaryTree(_ nums: [Int], _ start: Int, _ end: Int) -> TreeNode? {
        if end < start { return nil }
        if end == start { return TreeNode(nums[start], nil, nil) }
        
        let max = findMax(nums, start, end)
        let left = constructMaximumBinaryTree(nums, start, max - 1)
        let right = constructMaximumBinaryTree(nums, max + 1, end)
        return TreeNode(nums[max], left, right)
        
    }
    
    private func findMax(_ nums: [Int], _ start: Int, _ end: Int) -> Int {
        var maxIndex = start
        for i in start...end {
            if nums[i] > nums[maxIndex] {
                maxIndex = i
            }
        }
        return maxIndex
    }
 * }
```