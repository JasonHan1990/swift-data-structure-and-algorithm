### [677\. Map Sum Pairs](https://leetcode.com/problems/map-sum-pairs/)

Difficulty: **Medium**  

Related Topics: [Trie](https://leetcode.com/tag/trie/)


Implement a MapSum class with `insert`, and `sum` methods.

For the method `insert`, you'll be given a pair of (string, integer). The string represents the key and the integer represents the value. If the key already existed, then the original key-value pair will be overridden to the new one.

For the method `sum`, you'll be given a string representing the prefix, and you need to return the sum of all the pairs' value whose key starts with the prefix.

**Example 1:**  

```
Input: insert("apple", 3), Output: Null
Input: sum("ap"), Output: 3
Input: insert("app", 2), Output: Null
Input: sum("ap"), Output: 5
```


#### Solution

Language: **Swift**

```swift
public class TrieNode {
    var char: Character?
    var value : Int?
    var child : [Character : TrieNode]
    init(_ char: Character?) {
        self.char = char
        self.value = nil
        self.child = [Character : TrieNode]()
    }
}
​
extension TrieNode: CustomStringConvertible {
    public var description: String {
        return "\n{\(char)\n\(value)\(child)\n}"
    }
    
}
​
class MapSum {
    
    var root = TrieNode(nil)
    /** Initialize your data structure here. */
    init() {
        
    }
    
    func insert(_ key: String, _ val: Int) {
        var runner = root
        var idx = 0
        for char in key {
            if let found = runner.child[char] {
                runner = found
            } else {
                let newNode = TrieNode(char)
                runner.child[char] = newNode
                runner = newNode
            }
            if idx == key.count - 1 {
                // update the value
                runner.value = val
            }
            idx += 1
        }
    }
    
    func sum(_ prefix: String) -> Int {
        var sum = 0
        var runner = root
        for char in prefix {
            if let found = runner.child[char] {
                runner = found
            } else {
                // the prefix doesn't exist
                return 0
            }
        }
        
        sumTrie(runner, &sum)
        return sum
    }
    
    private func sumTrie(_ node: TrieNode, _ sum: inout Int) {
        if node.value != nil {
            sum += node.value!
            
            // don't return here
        }
        
        for (char, next) in node.child {
            sumTrie(next, &sum)
        }
    }
}
```