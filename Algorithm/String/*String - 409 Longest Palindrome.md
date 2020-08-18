### [409\. Longest Palindrome](https://leetcode.com/problems/longest-palindrome/)

Difficulty: **Easy**  

Related Topics: [Hash Table](https://leetcode.com/tag/hash-table/)


Given a string which consists of lowercase or uppercase letters, find the length of the longest palindromes that can be built with those letters.

This is case sensitive, for example `"Aa"` is not considered a palindrome here.

**Note:**  
Assume the length of given string will not exceed 1,010.

**Example:**

```
Input:
"abccccdd"

Output:
7

Explanation:
One longest palindrome that can be built is "dccaccd", whose length is 7.
```


#### Solution

Language: **Swift**

```swift
class Solution {
    
    func longestPalindrome(_ s: String) -> Int {
        var res = 0
        var dict = [Character : Int]()
        for char in s {
            dict[char, default: 0] += 1
        }
        var hasOdd = false
        for (key, val) in dict {
            if val % 2 == 0 {
                res += val
            } else {
                hasOdd = true
                res += (val - 1)
            }
        }
        res += hasOdd ? 1 : 0
        return res
    }
}
                hasOdd = true
```