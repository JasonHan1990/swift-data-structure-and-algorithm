### [551\. Student Attendance Record I](https://leetcode.com/problems/student-attendance-record-i/)

Difficulty: **Easy**  

Related Topics: [String](https://leetcode.com/tag/string/)

You are given a string representing an attendance record for a student. The record only contains the following three characters:

1.  **'A'** : Absent.
2.  **'L'** : Late.
3.  **'P'** : Present.

A student could be rewarded if his attendance record doesn't contain **more than one 'A' (absent)** or **more than two continuous 'L' (late)**.

You need to return whether the student could be rewarded according to his attendance record.

**Example 1:**  

```
Input: "PPALLP"
Output: True
```

**Example 2:**  

```
Input: "PPALLL"
Output: False
```


#### Solution
思路：遍历一遍字符串，记录A和L的出现个数. 其中当L的个数大于2时需要及时返回false

Language: **Swift**

```swift
class Solution {
    func checkRecord(_ s: String) -> Bool {
        let attendance = Array(s)
        var num_of_A = 0, num_of_L = 0
        for att in attendance {
            if att == "A" {
                num_of_A += 1
                num_of_L = 0
            } else if att == "L" {
                num_of_L += 1
                if num_of_L == 3 { 
                    return false
                }
            } else {
                num_of_L = 0
            }
        }
        
        return !(num_of_A > 1)
    }
}
```