### [848\. Shifting Letters](https://leetcode.com/problems/shifting-letters/)

Difficulty: **Medium**  

Related Topics: [String](https://leetcode.com/tag/string/)


We have a string `S` of lowercase letters, and an integer array `shifts`.

Call the _shift_ of a letter, the next letter in the alphabet, (wrapping around so that `'z'` becomes `'a'`). 

For example, `shift('a') = 'b'`, `shift('t') = 'u'`, and `shift('z') = 'a'`.

Now for each `shifts[i] = x`, we want to shift the first `i+1` letters of `S`, `x` times.

Return the final string after all such shifts to `S` are applied.

**Example 1:**

```
Input: S = "abc", shifts = [3,5,9]
Output: "rpl"
Explanation: 
We start with "abc".
After shifting the first 1 letters of S by 3, we have "dbc".
After shifting the first 2 letters of S by 5, we have "igc".
After shifting the first 3 letters of S by 9, we have "rpl", the answer.
```

**Note:**

1.  `1 <= S.length = shifts.length <= 20000`
2.  `0 <= shifts[i] <= 10 ^ 9`


#### Solution

Language: **Swift**

```swift
class Solution {
    func shiftingLetters(_ S: String, _ shifts: [Int]) -> String {
        
        // converting shifts
        var i = shifts.count - 1
        var shifts = shifts
        var pre = 0
        while i >= 0 {
            var finalShift = shifts[i] % 26
            finalShift = (finalShift + pre) % 26
            shifts[i] = finalShift
            pre = finalShift
            i -= 1
        }
        
        let a_ascii = Int(Character("a").asciiValue!)
        
        var res = "", j = 0
        for c in S {
            let c_ascii = Int(c.asciiValue!)
            let a_shift = ((c_ascii - a_ascii) + shifts[j]) % 26
            res += String(Character(UnicodeScalar(a_shift + a_ascii)!))
            j += 1
        }
​
        return res
    }
}
```