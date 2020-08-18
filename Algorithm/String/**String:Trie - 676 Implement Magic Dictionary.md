### [676\. Implement Magic Dictionary](https://leetcode.com/problems/implement-magic-dictionary/)

Difficulty: **Medium**  

Related Topics: [Hash Table](https://leetcode.com/tag/hash-table/), [Trie](https://leetcode.com/tag/trie/)


Implement a magic directory with `buildDict`, and `search` methods.

For the method `buildDict`, you'll be given a list of non-repetitive words to build a dictionary.

For the method `search`, you'll be given a word, and judge whether if you modify **exactly** one character into **another** character in this word, the modified word is in the dictionary you just built.

**Example 1:**  

```
Input: buildDict(["hello", "leetcode"]), Output: Null
Input: search("hello"), Output: False
Input: search("hhllo"), Output: True
Input: search("hell"), Output: False
Input: search("leetcoded"), Output: False
```

**Note:**  

1.  You may assume that all the inputs are consist of lowercase letters `a-z`.
2.  For contest purpose, the test data is rather small by now. You could think about highly efficient algorithm after the contest.
3.  Please remember to **RESET** your class variables declared in class MagicDictionary, as static/class variables are **persisted across multiple test cases**. Please see for more details.


#### Solution
思路：

Language: **Swift**

```swift
class TrieNode {
    var char: Character?
    var isWord: Bool
    var next: [Character : TrieNode]
    init() {
        char = nil
        isWord = false
        next = [Character : TrieNode]()
    }
}

class MagicDictionary {
    
    let head = TrieNode()

    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Build a dictionary through a list of words */
    func buildDict(_ dict: [String]) {
        for s in dict {
            var runner = head
            let chars = Array(s)
            for (i, c) in chars.enumerated() {
                if let found = runner.next[c] {
                    runner = found
                } else {
                    // c is a new next char for this node
                    var newNode = TrieNode()
                    newNode.char = c
                    if i == chars.count - 1 { // end char
                        newNode.isWord = true
                    }
                    
                    // update current node dict
                    runner.next[c] = newNode
                    runner = newNode
                }
            }
        }
    }
    
    /** Returns if there is any word in the trie that equals to the given word after modifying exactly one character */
    func search(_ word: String) -> Bool {
        var res = false
        search(Array(word), 0, false, head, &res)
        return res
    }
    
    private func search(_ wordChar: [Character], _ idx: Int, _ notMatch: Bool, _ currentNode: TrieNode, _ res: inout Bool) {
        
        if idx == wordChar.count {
            if currentNode.isWord {
                if !notMatch {
                    res = res || false
                } else {
                    res = res || true
                }
            } else {
                res = res || false
            }
            return
        }
        
        for (key, node) in currentNode.next {
            if key == wordChar[idx] {
               search(wordChar, idx + 1, notMatch, node, &res)
            } else {
                if notMatch {
                    res = res || false
                } else {
                    search(wordChar, idx + 1, !notMatch, node, &res)
                }
            }
        }
    }
}
```