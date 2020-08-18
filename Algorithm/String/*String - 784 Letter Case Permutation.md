### [784\. Letter Case Permutation](https://leetcode.com/problems/letter-case-permutation/)

Difficulty: **Medium**  

Related Topics: [Backtracking](https://leetcode.com/tag/backtracking/), [Bit Manipulation](https://leetcode.com/tag/bit-manipulation/)


Given a string S, we can transform every letter individually to be lowercase or uppercase to create another string.  Return a list of all possible strings we could create.

```
Examples:
Input: S = "a1b2"
Output: ["a1b2", "a1B2", "A1b2", "A1B2"]

Input: S = "3z4"
Output: ["3z4", "3Z4"]

Input: S = "12345"
Output: ["12345"]
```

**Constraints:**

*   `S` will be a string with length between `1` and `12`.
*   `S` will consist only of letters or digits.


#### Solution

Language: **Swift**

```swift
class Solution {
    func letterCasePermutation(_ S: String) -> [String] {
        var res = [String]()
        letterCasePermutation(Array(S), 0, &res)
        return res
    }
    
    private func letterCasePermutation(_ current: [Character], _ idx: Int, _ res: inout [String]) {
        if idx == current.count {
            res.append(String(current))
            return
        }
        let char = current[idx]
        if char.isWholeNumber {
            letterCasePermutation(current, idx + 1, &res)
        } else {
            // current case
            letterCasePermutation(current, idx + 1, &res)
            var current = current
            if char.isUppercase {
                current[idx] = Character(char.lowercased())
            } else {
                current[idx] = Character(char.uppercased())
            }
            letterCasePermutation(current, idx + 1, &res)
        }
    }
}
```