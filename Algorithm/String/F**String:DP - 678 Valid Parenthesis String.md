### [678\. Valid Parenthesis String](https://leetcode.com/problems/valid-parenthesis-string/)

Difficulty: **Medium**  

Related Topics: [String](https://leetcode.com/tag/string/)


Given a string containing only three types of characters: '(', ')' and '*', write a function to check whether this string is valid. We define the validity of a string by these rules:

1.  Any left parenthesis `'('` must have a corresponding right parenthesis `')'`.
2.  Any right parenthesis `')'` must have a corresponding left parenthesis `'('`.
3.  Left parenthesis `'('` must go before the corresponding right parenthesis `')'`.
4.  `'*'` could be treated as a single right parenthesis `')'` or a single left parenthesis `'('` or an empty string.
5.  An empty string is also valid.

**Example 1:**  

```
Input: "()"
Output: True
```

**Example 2:**  

```
Input: "(*)"
Output: True
```

**Example 3:**  

```
Input: "(*))"
Output: True
```

**Note:**  

1.  The string size will be in the range [1, 100].


#### Solution

Language: **Swift**

```swift
class Solution {
    func checkValidString(_ s: String) -> Bool {
        var res = false
        checkValidString(s, 0, [Character](), &res)
        return res
    }
    
    private func checkValidString(_ s: String, _ idx: Int, _ stack: [Character], _ res: inout Bool) {
        if res == true { return } // no need to continue
        
        if idx == s.count {
            if stack.isEmpty {
                res = true
            }
            return
        }
        
        let curr = s[s.index(s.startIndex, offsetBy:idx)]
        var stack = stack
        if curr == "(" {
            stack.append(curr)
            checkValidString(s, idx + 1, stack, &res)
        } else if curr == ")" {
            if let pre = stack.last, pre == "(" {
                stack.removeLast()
                checkValidString(s, idx + 1, stack, &res)
            } else {
                res = false
                return
            }
        } else { // curr == "*"
            // let curr == ""
            checkValidString(s, idx + 1, stack, &res)
            // let curr == ")"
            if let pre = stack.last, pre == "(" {
                var copy = stack
                copy.removeLast()
                checkValidString(s, idx + 1, copy, &res)
            } 
            // let curr == "("
            stack.append("(")
            checkValidString(s, idx + 1, stack, &res)
        }   
    }
}
```