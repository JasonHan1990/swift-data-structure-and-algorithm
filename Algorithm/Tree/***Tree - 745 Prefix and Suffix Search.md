### [745\. Prefix and Suffix Search](https://leetcode.com/problems/prefix-and-suffix-search/)

Difficulty: **Hard**


Given many `words`, `words[i]` has weight `i`.

Design a class `WordFilter` that supports one function, `WordFilter.f(String prefix, String suffix)`. It will return the word with given `prefix` and `suffix` with maximum weight. If no word exists, return -1.

**Examples:**

```
Input:
WordFilter(["apple"])
WordFilter.f("a", "e") // returns 0
WordFilter.f("b", "") // returns -1
```

**Note:**

1.  `words` has length in range `[1, 15000]`.
2.  For each test case, up to `words.length` queries `WordFilter.f` may be made.
3.  `words[i]` has length in range `[1, 10]`.
4.  `prefix, suffix` have lengths in range `[0, 10]`.
5.  `words[i]` and `prefix, suffix` queries consist of lowercase letters only.


#### Solution

Language: **Swift**

```swift
​
class WordFilter {
    
    class TrieNode {
        var weight: Int
        var children: [TrieNode?]
        init(_ weight: Int) {
            self.weight = weight
            self.children = Array<TrieNode?>(repeating: nil, count: 27)
        }
    }
​
    var trieHead = TrieNode(-1)
    // suffix_word
    init(_ words: [String]) {
        for (weight, word) in words.enumerated() {
            var word = Array(word + "{")
            print(word)
            for i in 0..<word.count {
                var cur = trieHead
                cur.weight = weight
                print("i: \(i)")
                for j in i..<(2 * word.count - 1) {
                     print("j: \(j)")
                    print("j % \(word.count) : \(j % word.count)")
                    let k = Int(word[j % word.count].asciiValue! - ("a" as Character).asciiValue!)
                    print(k)
                    if cur.children[k] == nil {
                        cur.children[k] = TrieNode(weight)
                    }
                    cur = cur.children[k]!
                }
            }
        } 
    }
    
    func f(_ prefix: String, _ suffix: String) -> Int {
        var cur = trieHead
        let search_term = Array(suffix + "{" + prefix)
        print(search_term)
        for char in search_term {
            let k = Int(char.asciiValue! - ("a" as Character).asciiValue!)
            if cur.children[k] == nil {
                return -1
            }
            cur = cur.children[k]!
        }
        return cur.weight
    }
}
​
/**
 * Your WordFilter object will be instantiated and called as such:
 * let obj = WordFilter(words)
 * let ret_1: Int = obj.f(prefix, suffix)
 */
```