### [715\. Range Module](https://leetcode.com/problems/range-module/)

Difficulty: **Hard**


A Range Module is a module that tracks ranges of numbers. Your task is to design and implement the following interfaces in an efficient manner.

*   `addRange(int left, int right)` Adds the half-open interval `[left, right)`, tracking every real number in that interval. Adding an interval that partially overlaps with currently tracked numbers should add any numbers in the interval `[left, right)` that are not already tracked.*   `queryRange(int left, int right)` Returns true if and only if every real number in the interval `[left, right)` is currently being tracked.*   `removeRange(int left, int right)` Stops tracking every real number currently being tracked in the interval `[left, right)`.

**Example 1:**  

```
addRange(10, 20): null
removeRange(14, 16): null
queryRange(10, 14): true (Every number in [10, 14) is being tracked)
queryRange(13, 15): false (Numbers like 14, 14.03, 14.17 in [13, 15) are not being tracked)
queryRange(16, 17): true (The number 16 in [16, 17) is still being tracked, despite the remove operation)
```

**Note:**

*   A half open interval `[left, right)` denotes all real numbers `left <= x < right`.*   `0 < left < right < 10^9` in all calls to `addRange, queryRange, removeRange`.*   The total number of calls to `addRange` in a single test case is at most `1000`.*   The total number of calls to `queryRange` in a single test case is at most `5000`.*   The total number of calls to `removeRange` in a single test case is at most `1000`.

#### Solution 1, array

Language: **Swift**

```swift
class RangeModule {
    
    // use a array to store the intervals, make sure all intervals has no overlaps
    // the intervals are sorted by left bound
    var intervals = [(Int, Int)]()

    init() {
        
    }
    
    // O(n)
    func addRange(_ left: Int, _ right: Int) {
        var left = left, right = right
        var isInserted = false
        var newIntervals = [(Int, Int)]()
        // loop through all intervals
        for interval in intervals {
            // find a place in front of current interval
            if interval.0 > right && !isInserted {
                newIntervals.append((left, right))
            }
            
            if interval.1 < left ||  interval.0 > right {
                newIntervals.append(interval)
            } else {
                left = min(left, interval.0)
                right = max(right, interval.1)
            }
        }
        
        if !isInserted { // meaning the inserted one is at the last interval
            newIntervals.append((left, right))
        }
        // copy
        intervals = newIntervals
    }
    
    // O(logn)
    func queryRange(_ left: Int, _ right: Int) -> Bool {
        // use binary search to find the interval
        var l = 0, r = intervals.count - 1
        while l <= r {
            let mid = l + (r - l) / 2
            let interval = intervals[mid]
            if interval.1 < left { // look for the right side
                l = mid + 1
            } else if interval.0 > right { // look for the left side
                r = mid - 1
            } else if left >= interval.0 && right <= interval.1 {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    // O(n)
    func removeRange(_ left: Int, _ right: Int) {
        // loop
        var newIntervals =  [(Int, Int)]()
        for interval in intervals {
            if interval.1 <= left || interval.0 >= right {
                newIntervals.append(interval)
            } else {
                if interval.0 < left {
                    newIntervals.append((interval.0, left))
                }
                if interval.1 > right {
                    newIntervals.append((right, interval.1))
                }
            }
        }
        intervals = newIntervals
    }
}
```