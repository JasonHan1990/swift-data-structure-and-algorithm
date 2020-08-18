### [863\. All Nodes Distance K in Binary Tree](https://leetcode.com/problems/all-nodes-distance-k-in-binary-tree/)

Difficulty: **Medium**


We are given a binary tree (with root node `root`), a `target` node, and an integer value `K`.

Return a list of the values of all nodes that have a distance `K` from the `target` node.  The answer can be returned in any order.


**Example 1:**

```
Input: root = [3,5,1,6,2,0,8,null,null,7,4], target = 5, K = 2

Output: [7,4,1]

Explanation: 
The nodes that are a distance 2 from the target node (with value 5)
have values 7, 4, and 1.

Note that the inputs "root" and "target" are actually TreeNodes.
The descriptions of the inputs above are just serializations of these objects.
```
![](863.png)

**Note:**

1.  The given tree is non-empty.
2.  Each node in the tree has unique values `0 <= node.val <= 500`.
3.  The `target` node is a node in the tree.
4.  `0 <= K <= 1000`.


#### Solution

Language: **Swift**

```swift
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */

extension TreeNode: Hashable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val && lhs.left === rhs.left && lhs.right === rhs.right
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
}

class Solution {
    func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ K: Int) -> [Int] {
        var graph_ = [TreeNode : [TreeNode]]()
        treeToGraph(root, &graph_)
        print(graph_)
        // BFS start from the target
        var queue = [TreeNode]()
        queue.append(target!)
        var level = 0
        var visited = [TreeNode]()
        while !queue.isEmpty {
            if level == K {
               break;
            }
            let size = queue.count
            // for current level
            for i in 0...queue.count - 1 {
                let cur = queue.removeFirst()
                visited.append(cur)
                let children = graph_[cur]
                for node in children! {
                    if !visited.contains(node) {
                        queue.append(node)
                    }
                }
            }
            // increment the level, however, is level == K, meaning the added nodes from method above is the result
            level += 1
        }
        var ans = [Int]()
        print(queue)
        for node in queue {
            ans.append(node.val)
        }
        return ans
    }
    
    private func treeToGraph(_ root: TreeNode?, _ graph: inout [TreeNode : [TreeNode]]) {
        if root == nil { return }
        if root!.left == nil && root!.right == nil {
            if graph[root!] == nil {
                graph[root!] = [TreeNode]()
            } 
            return
        }
        if root!.left != nil {
            if graph[root!] != nil {
                graph[root!]!.append(root!.left!)
            } else {
                graph[root!] = [root!.left!]
            }
            if graph[root!.left!] != nil {
                graph[root!.left!]!.append(root!)
            } else {
                graph[root!.left!] = [root!]
            }
        }
        if root!.right != nil {
            if graph[root!] != nil {
                graph[root!]!.append(root!.right!)
            } else {
                graph[root!] = [root!.right!]
            }
            if graph[root!.right!] != nil {
                graph[root!.right!]!.append(root!)
            } else {
                graph[root!.right!] = [root!]
            }
        }
        treeToGraph(root!.left, &graph)
        treeToGraph(root!.right, &graph)
    }
}
```