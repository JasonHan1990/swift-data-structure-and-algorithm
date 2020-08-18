### [5\. Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/)

Difficulty: **Medium**  

Related Topics: [String](https://leetcode.com/tag/string/), [Dynamic Programming](https://leetcode.com/tag/dynamic-programming/)


Given a string **s**, find the longest palindromic substring in **s**. You may assume that the maximum length of **s** is 1000.

**Example 1:**

```
Input: "babad"
Output: "bab"
Note: "aba" is also a valid answer.
```

**Example 2:**

```
Input: "cbbd"
Output: "bb"
```


#### Solution

Language: **Swift**

```swift
class Solution {
    func longestPalindrome(_ s: String) -> String {
        var max_len = 0
        let ss = Array(s)
        var start = 0
        for i in 0..<s.count {
            let len = max(getLength(ss, i, i), getLength(ss, i, i + 1))
            if len > max_len {
                max_len = len
                start = i - (len - 1) / 2
            }
        }
        return String(s[s.index(s.startIndex, offsetBy: start)..<s.index(s.startIndex, offsetBy: start + max_len)])
    }
    
    private func getLength(_ s: [Character], _ l: Int, _ r: Int) -> Int {
        var l = l, r = r
        while l >= 0 && r < s.count && s[l] == s[r] {
            l -= 1
            r += 1
        }
        return r - l - 1
    }
}
```