### [690\. Employee Importance](https://leetcode.com/problems/employee-importance/)

Difficulty: **Easy**


You are given a data structure of employee information, which includes the employee's **unique id**, his **importance value** and his **direct** subordinates' id.

For example, employee 1 is the leader of employee 2, and employee 2 is the leader of employee 3\. They have importance value 15, 10 and 5, respectively. Then employee 1 has a data structure like [1, 15, [2]], and employee 2 has [2, 10, [3]], and employee 3 has [3, 5, []]. Note that although employee 3 is also a subordinate of employee 1, the relationship is **not direct**.

Now given the employee information of a company, and an employee id, you need to return the total importance value of this employee and all his subordinates.

**Example 1:**







```
Input: [[1, 5, [2, 3]], [2, 3, []], [3, 3, []]], 1
Output: 11
Explanation:
Employee 1 has importance value 5, and he has two direct subordinates: employee 2 and employee 3\. They both have importance value 3\. So the total importance value of employee 1 is 5 + 3 + 3 = 11.
```

**Note:**

1.  One employee has at most one **direct** leader and may have several subordinates.
2.  The maximum number of employees won't exceed 2000.


#### Solution

Language: **Swift**

```swift
/**
 * Definition for Employee.
 * public class Employee {
 *     public var id: Int
 *     public var importance: Int
 *     public var subordinates: [Int]
 *     public init(_ id: Int, _ importance: Int, _ subordinates: [Int]) {
 *         self.id = id
 *         self.importance = importance
 *         self.subordinates = subordinates
 *     }
 * }
 */
​
class Solution {
    func getImportance(_ employees: [Employee], _ id: Int) -> Int {
        var employees_dict = [Int : Employee]()
        for e in employees {
            employees_dict[e.id] = e
        }
        var res = 0
        var visited = [Int]()
        dfs(employees_dict, id, &res, &visited)
        return res
    }
    
    private func dfs(_ employees: [Int: Employee], _ id: Int, _ res: inout Int, _ visited: inout [Int]) {
        
        if visited.contains(id) { return }
        
        res += employees[id]!.importance
        visited.append(id)
        
        for nextId in employees[id]!.subordinates {
            dfs(employees, nextId, &res, &visited)
        }
    }
}
```