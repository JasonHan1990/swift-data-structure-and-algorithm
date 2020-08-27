### [1466\. Reorder Routes to Make All Paths Lead to the City Zero](https://leetcode.com/problems/reorder-routes-to-make-all-paths-lead-to-the-city-zero/)

Difficulty: **Medium**  

Related Topics: [Tree](https://leetcode.com/tag/tree/), [Depth-first Search](https://leetcode.com/tag/depth-first-search/)


There are `n` cities numbered from `0` to `n-1` and `n-1` roads such that there is only one way to travel between two different cities (this network form a tree). Last year, The ministry of transport decided to orient the roads in one direction because they are too narrow.

Roads are represented by `connections` where `connections[i] = [a, b]` represents a road from city `a` to `b`.

This year, there will be a big event in the capital (city 0), and many people want to travel to this city.

Your task consists of reorienting some roads such that each city can visit the city 0\. Return the **minimum** number of edges changed.

It's **guaranteed** that each city can reach the city 0 after reorder.

**Example 1:**

**![](https://assets.leetcode.com/uploads/2020/05/13/sample_1_1819.png)**

```
Input: n = 6, connections = [[0,1],[1,3],[2,3],[4,0],[4,5]]
Output: 3
Explanation: Change the direction of edges show in red such that each node can reach the node 0 (capital).
```

**Example 2:**

**![](https://assets.leetcode.com/uploads/2020/05/13/sample_2_1819.png)**

```
Input: n = 5, connections = [[1,0],[1,2],[3,2],[3,4]]
Output: 2
Explanation: Change the direction of edges show in red such that each node can reach the node 0 (capital).
```

**Example 3:**

```
Input: n = 3, connections = [[1,0],[2,0]]
Output: 0
```

**Constraints:**

*   `2 <= n <= 5 * 10^4`
*   `connections.length == n-1`
*   `connections[i].length == 2`
*   `0 <= connections[i][0], connections[i][1] <= n-1`
*   `connections[i][0] != connections[i][1]`


#### Solution

https://blog.csdn.net/fuxuemingzhu/article/details/106597991

Language: **Swift**

```swift
class Solution {
    func minReorder(_ n: Int, _ connections: [[Int]]) -> Int {
        var graph = [Int : [Int]]()
        var weight = [String : Int]()
        for conn in connections {
            if let _ = graph[conn[0]] {
                graph[conn[0]]!.append(conn[1])
            } else {
                graph[conn[0]] = [conn[1]]
            }
            weight["\(conn[0])-\(conn[1])"] = 1
            if let _ = graph[conn[1]] {
                graph[conn[1]]!.append(conn[0])
            } else {
                graph[conn[1]] = [conn[0]]
            }
            weight["\(conn[1])-\(conn[0])"] = 0
        }
        
        var visited = Set<Int>()
        var ans = 0
        dfs(0, graph, weight, &visited, &ans)
        return ans
    }
    
    private func dfs(_ start: Int, _ graph: [Int : [Int]], _ weight: [String: Int], _ visited: inout Set<Int>, _ ans: inout Int) {
        visited.insert(start)
        for next in graph[start]! {
            if !visited.contains(next) {
                ans += weight["\(start)-\(next)"]!
                dfs(next, graph, weight, &visited, &ans)
            }
        } 
    }
}
```