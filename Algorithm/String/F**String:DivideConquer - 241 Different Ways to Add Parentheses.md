### [241\. Different Ways to Add Parentheses](https://leetcode.com/problems/different-ways-to-add-parentheses/)

Difficulty: **Medium**  

Related Topics: [Divide and Conquer](https://leetcode.com/tag/divide-and-conquer/)


Given a string of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. The valid operators are `+`, `-` and `*`.

**Example 1:**

```
Input: "2-1-1"
Output: [0, 2]
Explanation: 
((2-1)-1) = 0 
(2-(1-1)) = 2
```

**Example 2:**

```
Input: "2*3-4*5"
Output: [-34, -14, -10, -10, 10]
Explanation: 
(2*(3-(4*5))) = -34 
((2*3)-(4*5)) = -14 
((2*(3-4))*5) = -10 
(2*((3-4)*5)) = -10 
(((2*3)-4)*5) = 10
```


#### Solution

Language: **Swift**

```swift
extension String {
​
    var length: Int {
        return count
    }
​
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
​
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
​
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
​
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
​
class Solution {
    func diffWaysToCompute(_ input: String) -> [Int] {    
        var mem = [String : [Int]]()
        return divideAndConquer(input, 0, input.count - 1, &mem)
    }
    
    private func divideAndConquer(_ input: String, _ l: Int, _ r: Int, _ mem: inout [String : [Int]]) -> [Int] {
        let k = "\(l)-\(r)"
        if mem[k] != nil {
            return mem[k]!
        }
        
        var hasOp = false
        var ans = [Int]()
        for z in l...r {
            let c = input[z]
            if c == "+" || c == "-" || c == "*" {
                hasOp = true
                // divide
                let left = divideAndConquer(input, l, z - 1, &mem)
                let right = divideAndConquer(input, z + 1, r, &mem)            
                for i in left {
                    for j in right {
                        switch c {
                            case "+":
                                ans.append(i + j) 
                            case "-":
                                ans.append(i - j) 
                            case "*":
                                ans.append(i * j) 
                            default:
                                break
                        }
                    }
                }  
            }
        }
        if !hasOp {
            ans = [Int(String(input[input.index(input.startIndex, offsetBy: l)...input.index(input.startIndex, offsetBy: r)]))!]
        }
        
        // save it to memory
        mem[k] = ans
        return ans
    }
}
```