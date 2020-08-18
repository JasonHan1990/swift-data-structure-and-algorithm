### [684\. Redundant Connection](https://leetcode.com/problems/redundant-connection/)

Difficulty: **Medium**


In this problem, a tree is an **undirected** graph that is connected and has no cycles.

The given input is a graph that started as a tree with N nodes (with distinct values 1, 2, ..., N), with one additional edge added. The added edge has two different vertices chosen from 1 to N, and was not an edge that already existed.

The resulting graph is given as a 2D-array of `edges`. Each element of `edges` is a pair `[u, v]` with `u < v`, that represents an **undirected** edge connecting nodes `u` and `v`.

Return an edge that can be removed so that the resulting graph is a tree of N nodes. If there are multiple answers, return the answer that occurs last in the given 2D-array. The answer edge `[u, v]` should be in the same format, with `u < v`.

**Example 1:**  

```
Input: [[1,2], [1,3], [2,3]]
Output: [2,3]
Explanation: The given undirected graph will be like this:
  1
 / \
2 - 3
```

**Example 2:**  

```
Input: [[1,2], [2,3], [3,4], [1,4], [1,5]]
Output: [1,4]
Explanation: The given undirected graph will be like this:
5 - 1 - 2
    |   |
    4 - 3
```

**Note:**  

*   The size of the input 2D-array will be between 3 and 1000.*   Every integer represented in the 2D-array will be between 1 and N, where N is the size of the input array.  

**<font color="red" style="display: inline;">Update (2017-09-26):</font>**  
We have overhauled the problem description + test cases and specified clearly the graph is an **_undirected_** graph. For the **_directed_** graph follow up please see ). We apologize for any inconvenience caused.


#### Solution

Language: **Swift**

```swift

// DFS
class Solution {
    func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
        
        var graph = [Int : [Int]]()
        for e in edges {
            var visited = [Int]()
            if findCircle(graph, e[0], e[1], &visited) {
                return e
            }
            
            if graph[e[0]] == nil {
                graph[e[0]] = [e[1]]
            } else {
                graph[e[0]]!.append(e[1])
            }
            if graph[e[1]] == nil {
                graph[e[1]] = [e[0]]
            } else {
                graph[e[1]]!.append(e[0])
            }
        }
        return [Int]()
    }
    
    private func findCircle(_ graph: [Int : [Int]], _ source: Int, _ target: Int, _ visited: inout [Int]) -> Bool {
        if source == target { return true }
        visited.append(source)
        if !graph.keys.contains(source) || !graph.keys.contains(target) { return false }
        for next in graph[source]! {
            if visited.contains(next) { continue }
            if (findCircle(graph, next, target, &visited)) { return true }
        }
        return false
    }
}
```




class Solution {
    func getRootNode(_ map:[Int: Int], _ node: Int) -> Int {
        var result = node
        while let value = map[result] {
            result = value
        }
        return result
    }
    func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
        var lines = [Int: Int].init()
        
        for edge in edges {
            guard let nodeA = edge.first, let nodeB = edge.last else { continue }
            
            let rootA = getRootNode(lines, nodeA)
            let rootB = getRootNode(lines, nodeB)
            
            if rootA == rootB {
                return [nodeA, nodeB]
            } else {
                lines[rootA] = rootB
            }
        }
        
        return [];
    }
}


class Solution {
    func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
        var ans: [[Int]] = [[]]
        var parents = Array(repeating: -1, count: edges.count+1)
        for edge in edges {
            let result = union(parents: &parents, u: edge[0], v: edge[1])
            if result {
                return edge
            }
        }
        return [0,0]
    }
    func union(parents: inout [Int], u: Int, v: Int) -> Bool {
        let parent1 = find(parents: parents, u: u)
        let parent2 = find(parents: parents, u: v)
        
        if parent1 != parent2 {
            parents[parent1] = parent2
            return false
        } else {
            return true
        }
    }
    func find(parents: [Int], u:Int) -> Int {
        if parents[u] == -1 {
            return u
        }
        return find(parents: parents, u: parents[u])
    }
}