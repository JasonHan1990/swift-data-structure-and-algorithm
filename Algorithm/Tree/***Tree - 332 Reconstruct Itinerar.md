### [332\. Reconstruct Itinerary](https://leetcode.com/problems/reconstruct-itinerary/)

Difficulty: **Medium**


Given a list of airline tickets represented by pairs of departure and arrival airports `[from, to]`, reconstruct the itinerary in order. All of the tickets belong to a man who departs from `JFK`. Thus, the itinerary must begin with `JFK`.

**Note:**

1.  If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string. For example, the itinerary `["JFK", "LGA"]` has a smaller lexical order than `["JFK", "LGB"]`.
2.  All airports are represented by three capital letters (IATA code).
3.  You may assume all tickets form at least one valid itinerary.

**Example 1:**

```
Input: [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
Output: ["JFK", "MUC", "LHR", "SFO", "SJC"]
```

**Example 2:**

```
Input: [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]
Explanation: Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"].
             But it is larger in lexical order.
```


#### Solution

Language: **Swift**

```swift
class Solution {
    func findItinerary(_ tickets: [[String]]) -> [String] {
        var tickets = tickets.sorted {
            return $0[1] < $1[1]
        }
        var dict = [String : [String]]()
        for ticket in tickets {
            if let _ = dict[ticket[0]] {
                dict[ticket[0]]!.append(ticket[1])
            } else {
                dict[ticket[0]] = [ticket[1]]
            }
        }
        print(dict)
        var res = [String]()
        findItinerary(&dict, &res, "JFK")
        return res.reversed()
    }
    
    private func findItinerary(_ dict: inout [String : [String]], _ res: inout [String], _ cur: String) {     
        
        // 这是一个后序遍历！！！！
        while dict[cur] != nil && !dict[cur]!.isEmpty {
            let nextStart = dict[cur]!.removeFirst()
            findItinerary(&dict, &res, nextStart)
        }
        
        res.append(cur)
    }
}
```