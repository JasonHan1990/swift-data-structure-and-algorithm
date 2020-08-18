### [652\. Find Duplicate Subtrees](https://leetcode.com/problems/find-duplicate-subtrees/)

Difficulty: **Medium**


Given a binary tree, return all duplicate subtrees. For each kind of duplicate subtrees, you only need to return the root node of any **one** of them.

Two trees are duplicate if they have the same structure with same node values.

**Example 1:**

```
        1
       / \
      2   3
     /   / \
    4   2   4
       /
      4
```

The following are two duplicate subtrees:

```
      2
     /
    4
```

and

```
    4
```

Therefore, you need to return above trees' root in the form of a list.

#### Solution 1 failed too slow

Language: **Swift**

```swift
 /**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    func findDuplicateSubtrees(_ root: TreeNode?) -> [TreeNode?] {
        var dict = [Int : [[TreeNode?]]]()
        var ans = [TreeNode?]()
        dfs(root, &dict)
        for key in dict.keys {
            for dup in dict[key]! {
                if dup.count > 1 {
                   ans.append(dup[0]) 
                }
            }
        }
        print(dict)
        return ans
    }
    
    private func dfs(_ root: TreeNode?, _ dict: inout [Int : [[TreeNode?]]]) {
        if root == nil { return }
        
        dfs(root!.left, &dict)
        var dups = dict[root!.val]
        if dups != nil {
            var newDups = [[TreeNode?]]()
            var updated = false
            for dup in dups! {
                    if isSameTree(dup[0], root) {
                        var newDup = dup
                        newDup.append(root)
                        updated = true
                        newDups.append(newDup)
                    } else {
                        newDups.append(dup)
                    }
            }
            if !updated {
                newDups.append([root])
            }
            dict[root!.val] = newDups
        } else {
            dict[root!.val] = [[root]]
            print("new \(root!.val)")
        }
        dfs(root!.right, &dict)
    }
    
    private func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil { return true }
        if p == nil || q == nil { return false }
        if p!.val != q!.val { return false }
        return isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right)
    }
}
```


#### Solution 2 
Intuition

We can serialize each subtree. For example, the tree

   1
  / \
 2   3
    / \
   4   5
can be represented as the serialization 1,2,#,#,3,4,#,#,5,#,#, which is a unique representation of the tree.

Algorithm

Perform a depth-first search, where the recursive function returns the serialization of the tree. At each node, record the result in a map, and analyze the map after to determine duplicate subtrees.

```java
class Solution {
    Map<String, Integer> count;
    List<TreeNode> ans;
    public List<TreeNode> findDuplicateSubtrees(TreeNode root) {
        count = new HashMap();
        ans = new ArrayList();
        collect(root);
        return ans;
    }

    public String collect(TreeNode node) {
        if (node == null) return "#";
        String serial = node.val + "," + collect(node.left) + "," + collect(node.right);
        count.put(serial, count.getOrDefault(serial, 0) + 1);
        if (count.get(serial) == 2)
            ans.add(node);
        return serial;
    }
}
```