### [552\. Student Attendance Record II](https://leetcode.com/problems/student-attendance-record-ii/)

Difficulty: **Hard**  

Related Topics: [Dynamic Programming](https://leetcode.com/tag/dynamic-programming/)


Given a positive integer **n**, return the number of all possible attendance records with length n, which will be regarded as rewardable. The answer may be very large, return it after mod 10<sup>9</sup> + 7.

A student attendance record is a string that only contains the following three characters:

1.  **'A'** : Absent.
2.  **'L'** : Late.
3.  **'P'** : Present.

A record is regarded as rewardable if it doesn't contain **more than one 'A' (absent)** or **more than two continuous 'L' (late)**.

**Example 1:**  

```
Input: n = 2
Output: 8 
Explanation:
There are 8 records with length 2 will be regarded as rewardable:
"PP" , "AP", "PA", "LP", "PL", "AL", "LA", "LL"
Only "AA" won't be regarded as rewardable owing to more than one absent times. 
```

**Note:** The value of **n** won't exceed 100,000.


#### Solution, backtracking, time exceed

Language: **Swift**

```swift
class Solution {
    func checkRecord(_ n: Int) -> Int {
        var res = 0
        createRecord(n, &res, [Character]())
        return res % 1000000007
    }
    
    private func createRecord(_ n: Int, _ res: inout Int, _ currentRecord: [Character]) {
        if !checkA(currentRecord) {
            return
        }
        if !checkL(currentRecord) {
            return
        }
        if currentRecord.count == n {
            res += 1
            return
        }
        for i in ["A", "L", "P"] as [Character] {
            var currentRecord = currentRecord
            currentRecord.append(i)
            createRecord(n, &res, currentRecord)
        }
    }
    
    private func checkA(_ currentRecord: [Character]) -> Bool {
        var number_of_a = 0
        for c in currentRecord {
            if c == "A" {
                number_of_a += 1
            }
        }
        return !(number_of_a > 1)
    }
    
    private func checkL(_ currentRecord: [Character]) -> Bool {
        if currentRecord.count < 3 { return true }
        let l = currentRecord.count - 1
        return !(currentRecord[l] == "L" && currentRecord[l - 1] == "L" && currentRecord[l - 2] == "L")
    }
}
```