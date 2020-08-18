### [720\. Longest Word in Dictionary](https://leetcode.com/problems/longest-word-in-dictionary/)

Difficulty: **Easy**  

Related Topics: [Hash Table](https://leetcode.com/tag/hash-table/), [Trie](https://leetcode.com/tag/trie/)


Given a list of strings `words` representing an English Dictionary, find the longest word in `words` that can be built one character at a time by other words in `words`. If there is more than one possible answer, return the longest word with the smallest lexicographical order.

If there is no answer, return the empty string.

**Example 1:**  

```
Input: 
words = ["w","wo","wor","worl", "world"]
Output: "world"
Explanation: 
The word "world" can be built one character at a time by "w", "wo", "wor", and "worl".
```

**Example 2:**  

```
Input: 
words = ["a", "banana", "app", "appl", "ap", "apply", "apple"]
Output: "apple"
Explanation: 
Both "apply" and "apple" can be built from other words in the dictionary. However, "apple" is lexicographically smaller than "apply".
```

**Note:**

*   All the strings in the input will only contain lowercase letters.*   The length of `words` will be in the range `[1, 1000]`.*   The length of `words[i]` will be in the range `[1, 30]`.

#### Solution

Language: **Swift**

```swift
class TrieNode {
    var isWord: Bool
    var char: Character?
    var next: [Character : TrieNode]
    init(_ char: Character? = nil, _ isWord: Bool = false) {
        self.char = char
        self.isWord = isWord
        self.next = [Character : TrieNode]()
    }
}

extension TrieNode: CustomStringConvertible {
    var description: String {
        return "\n{\n\(char)\n\(isWord)\n\(next)\n}"
    }
}

class Solution {
    
    
    
    var root = TrieNode()
    
    func longestWord(_ words: [String]) -> String {
        
        let words = words.sorted()
        var count = 0
        var res = ""
        
        for w in words {
            var runner = root
            var temp_count = 0
            for (idx, c) in w.enumerated() {
                if let found = runner.next[c] {
                    // since every character must be a word
                    // if the character node we found is not a word,
                    // we break directly
                    if !found.isWord {
                        break;
                    }
                    // otherwise, update the runner and continue
                    runner = found
                    temp_count += 1
                } else {
                    // if words.count jumped, skip this word
                    if temp_count < w.count - 1 {
                        break;
                    }
                    
                    let newNode = TrieNode(c, idx == (w.count - 1))
                    runner.next[c] = newNode
                    runner = newNode
                    temp_count += 1
                    
                    if temp_count > count {
                        res = w
                        count = temp_count
                    }
                }
            }
        }
        return res
        
    }
}
```