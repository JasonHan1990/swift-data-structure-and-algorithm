### [680\. Valid Palindrome II](https://leetcode.com/problems/valid-palindrome-ii/)

Difficulty: **Easy**  

Related Topics: [String](https://leetcode.com/tag/string/)


Given a non-empty string `s`, you may delete **at most** one character. Judge whether you can make it a palindrome.

**Example 1:**  

```
Input: "aba"
Output: True
```

**Example 2:**  

```
Input: "abca"
Output: True
Explanation: You could delete the character 'c'.
```

**Note:**  

1.  The string will only contain lowercase characters a-z. The maximum length of the string is 50000.


#### Solution

Language: **Swift**

```swift
class Solution {
    func validPalindrome(_ s: String) -> Bool {
        return validPalindrome(Array(s), 0, s.count - 1, false)
    }
    
    private func validPalindrome(_ chars: [Character], _ l: Int, _ r: Int, _ unmatch: Bool) -> Bool {
        if l == r || l > r { return true }
        
        if chars[l] == chars[r] {
            return validPalindrome(chars, l + 1, r - 1, unmatch)
        } else {
            if unmatch {
                return false
            }
            return validPalindrome(chars, l + 1, r, !unmatch) || validPalindrome(chars, l, r - 1, !unmatch)
        }
    }
}
```