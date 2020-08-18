### [726\. Number of Atoms](https://leetcode.com/problems/number-of-atoms/)

Difficulty: **Hard**  

Related Topics: [Hash Table](https://leetcode.com/tag/hash-table/), [Stack](https://leetcode.com/tag/stack/), [Recursion](https://leetcode.com/tag/recursion/)


Given a chemical `formula` (given as a string), return the count of each atom.

An atomic element always starts with an uppercase character, then zero or more lowercase letters, representing the name.

1 or more digits representing the count of that element may follow if the count is greater than 1\. If the count is 1, no digits will follow. For example, H2O and H2O2 are possible, but H1O2 is impossible.

Two formulas concatenated together produce another formula. For example, H2O2He3Mg4 is also a formula.

A formula placed in parentheses, and a count (optionally added) is also a formula. For example, (H2O2) and (H2O2)3 are formulas.

Given a formula, output the count of all elements as a string in the following form: the first name (in sorted order), followed by its count (if that count is more than 1), followed by the second name (in sorted order), followed by its count (if that count is more than 1), and so on.

**Example 1:**  

```
Input: 
formula = "H2O"
Output: "H2O"
Explanation: 
The count of elements are {'H': 2, 'O': 1}.
```

**Example 2:**  

```
Input: 
formula = "Mg(OH)2"
Output: "H2MgO2"
Explanation: 
The count of elements are {'H': 2, 'Mg': 1, 'O': 2}.
```

**Example 3:**  

```
Input: 
formula = "K4(ON(SO3)2)2"
Output: "K4N2O14S4"
Explanation: 
The count of elements are {'K': 4, 'N': 2, 'O': 14, 'S': 4}.
```

**Note:**

*   All atom names consist of lowercase letters, except for the first character which is uppercase.*   The length of `formula` will be in the range `[1, 1000]`.*   `formula` will only consist of letters, digits, and round parentheses, and is a valid formula as defined in the problem.

#### Solution
思路: 用递归来求解。

先写出两个辅助方程，getName()顺序读string，返回一个元素名称，getCount()顺序读string，返回一个数字。 用一个globle的idx来记录当前string读到的位置，如果遇到括号，就递归求解括号内部的东西，返回后需乘上外部的数字。


Language: **Swift**

```swift
class Solution {
    func countOfAtoms(_ formula: String) -> String {
        var idx = 0
        let count = countOfAtoms(Array(formula), &idx).sorted { $0.0 < $1.0 }
        var res = ""
        for c in count {
            res += c.key 
            if c.value != 1 {
                res += String(c.value)
            }
        }
        return res
    }
    
    // return unsorted {atom : count}
    private func countOfAtoms(_ formula: [Character], _ idx: inout Int) -> [String: Int] {
        var num_of_atom = [String: Int]()
        while idx < formula.count {
            if formula[idx] == "(" {
                idx += 1
                let noa = countOfAtoms(formula, &idx)
                let cnt = getCount(formula, &idx)
                for (key, value) in noa {
                    num_of_atom[key, default: 0] += value * cnt
                }
            } else if formula[idx] == ")" {
                idx += 1
                return num_of_atom
            } else {
                let nm = getName(formula, &idx)
                let cnt = getCount(formula, &idx)
                num_of_atom[nm, default: 0] += cnt
            }
        }
        return num_of_atom
    } 
    
    // get name
    private func getName(_ formula: [Character], _ idx: inout Int) -> String {
        var name = ""
        while idx < formula.count && formula[idx].isLetter && (name.isEmpty || formula[idx].isLowercase) {
            name += String(formula[idx])
            idx += 1
        }
        return name
    }
    // get count
    private func getCount(_ formula: [Character], _ idx: inout Int) -> Int {
        var count = ""
        while idx < formula.count && formula[idx].isWholeNumber {
            count += String(formula[idx])
            idx += 1
        }
        return count.isEmpty ? 1 : Int(count)!
    }
}
```