### [451\. Sort Characters By Frequency](https://leetcode.com/problems/sort-characters-by-frequency/)

Difficulty: **Medium**  

Related Topics: [Hash Table](https://leetcode.com/tag/hash-table/), [Heap](https://leetcode.com/tag/heap/)


Given a string, sort it in decreasing order based on the frequency of characters.

**Example 1:**

```
Input:
"tree"

Output:
"eert"

Explanation:
'e' appears twice while 'r' and 't' both appear once.
So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.
```

**Example 2:**

```
Input:
"cccaaa"

Output:
"cccaaa"

Explanation:
Both 'c' and 'a' appear three times, so "aaaccc" is also a valid answer.
Note that "cacaca" is incorrect, as the same characters must be together.
```

**Example 3:**

```
Input:
"Aabb"

Output:
"bbAa"

Explanation:
"bbaA" is also a valid answer, but "Aabb" is incorrect.
Note that 'A' and 'a' are treated as two different characters.
```
#### Solution, using maxheap


#### Solution, using dictionary, sort the val

Language: **Swift**

```swift
class Solution {
    func frequencySort(_ s: String) -> String {
        var res = ""
        var map: [Character:Int] = [:]
        for c in s {map[c, default: 0] += 1}      // O(N)
        let sorted = map.sorted{$0.value > $1.value}  // return a array of tuple (key, value)     // O(clogc)  c is the number of characters, it is constant.
        for item in sorted {
            for i in 0...item.value-1{  // O(c)
                res+=String(item.key)
            }
        }
        return res
    }
}
```