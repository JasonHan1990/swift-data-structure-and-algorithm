### [218\. The Skyline Problem](https://leetcode.com/problems/the-skyline-problem/)

Difficulty: **Hard**


A city's skyline is the outer contour of the silhouette formed by all the buildings in that city when viewed from a distance. Now suppose you are **given the locations and height of all the buildings** as shown on a cityscape photo (Figure A), write a program to **output the skyline** formed by these buildings collectively (Figure B).

The geometric information of each building is represented by a triplet of integers `[Li, Ri, Hi]`, where `Li` and `Ri` are the x coordinates of the left and right edge of the ith building, respectively, and `Hi` is its height. It is guaranteed that `0 ≤ Li, Ri ≤ INT_MAX`, `0 < Hi ≤ INT_MAX`, and `Ri - Li > 0`. You may assume all buildings are perfect rectangles grounded on an absolutely flat surface at height 0.

For instance, the dimensions of all buildings in Figure A are recorded as: `[ [2 9 10], [3 7 15], [5 12 12], [15 20 10], [19 24 8] ]` .

The output is a list of "**key points**" (red dots in Figure B) in the format of `[ [x1,y1], [x2, y2], [x3, y3], ... ]` that uniquely defines a skyline. **A key point is the left endpoint of a horizontal line segment**. Note that the last key point, where the rightmost building ends, is merely used to mark the termination of the skyline, and always has zero height. Also, the ground in between any two adjacent buildings should be considered part of the skyline contour.

For instance, the skyline in Figure B should be represented as:`[ [2 10], [3 15], [7 12], [12 0], [15 10], [20 8], [24, 0] ]`.

**Notes:**

*   The number of buildings in any input list is guaranteed to be in the range `[0, 10000]`.
*   The input list is already sorted in ascending order by the left x position `Li`.
*   The output list must be sorted by the x position.
*   There must be no consecutive horizontal lines of equal height in the output skyline. For instance, `[...[2 3], [4 5], [7 5], [11 5], [12 7]...]` is not acceptable; the three lines of height 5 should be merged into one in the final output as such: `[...[2 3], [4 5], [12 7], ...]`


#### Solution

Language: **Swift**

```swift
struct KeyPoint {
    
    var x: Int  // x axis point
    var h: Int  // height
    var isEnter: Bool  // Enter point is 1, Leave point is -1
    
    init(_ x: Int, _ h: Int, _ isEnter: Bool) {
        self.x = x
        self.h = h
        self.isEnter = isEnter
    }
}

extension KeyPoint: Comparable {
    static func < (lhs: KeyPoint, rhs: KeyPoint) -> Bool {
        // For Enter points, if x is the same, lhs.h > rhs.h, 我们要先处理高度较大的，不然小的那个也可能被加入结果中
        if lhs.x == rhs.x && lhs.isEnter == rhs.isEnter {
            if lhs.isEnter {
                return lhs.h > rhs.h
            } else { // For leaving points, if x is the same, lhs.h < rhs.h, 我们要先处理高度较小的，不然的那个会被加入到结果中
                return lhs.h < rhs.h
            }
        }
        
        if lhs.x == rhs.x && lhs.isEnter != rhs.isEnter {
            return (lhs.h * (lhs.isEnter ? 1 : -1)) > (rhs.h * (rhs.isEnter ? 1 : -1))
        }
        
        return lhs.x < rhs.x
    }
    
    static func == (lhs: KeyPoint, rhs: KeyPoint) -> Bool {
        return lhs.x == rhs.x && lhs.h == rhs.h && lhs.isEnter == rhs.isEnter
    }
}

extension KeyPoint: CustomStringConvertible {
    var description: String {
        return "KP[x:\(x),h:\(h),\(isEnter)]"
    }
}

public struct MaxHeap {
    
    
    private var items : [Int?]
    private var writeIndex = 0
    
    public var peek: Int? {
        return items[0]
    }
    
    public var isFull: Bool {
        return writeIndex == items.capacity
    }
    
    public var isEmpty: Bool {
        return writeIndex == 0
    }
    
    public init(capacity: Int) {
        items = Array<Int?>(repeating: nil, count: capacity)
    }
    
    public init(array: [Int]) {
        items = array
        writeIndex = array.count
        // heap are always have half or (half + 1) of leaves.
        // we consider all these leaves are already valid sub heap
        // so when we turn an array to a heap, we only need to heapify non-leaf items
        var i = items.count / 2 - 1
        while i >= 0 {
            heapFixDown(itemIndex: i, boundary: writeIndex)
            i -= 1
        }
    }
    
    
    public mutating func insert(newElement: Int) -> Bool {
        if isFull {
            return false
        }
        
        // put the new element to the last
        items[writeIndex] = newElement
        // fix the heap
        heapFixUp(newItemIndex: writeIndex)
        
        writeIndex += 1
        return true
    }
    
    private mutating func heapFixUp(newItemIndex c: Int) {
        var c = c
        var f = (c - 1) / 2
        while f >= 0 {
            if items[f]! >= items[c]! {
                break
            }
            items.swapAt(f, c)
            c = f
            f = (c - 1) / 2
        }
    }
    
    // remove top
    @discardableResult
    public mutating func remove() -> Int? {
        if isEmpty {
            return nil
        }
        
        let result = items[0]
        // writeIndex - 1 is the last item index
        items[0] = items[writeIndex - 1]
        items[writeIndex - 1] = nil
        writeIndex -= 1
        heapFixDown(itemIndex: 0, boundary: writeIndex)
        return result
    }
    
    // remove a value
    @discardableResult
    public mutating func remove(_ element: Int) -> Int? {
        if isEmpty {
            return nil
        }
        
        var removeIndex = -1
        // find the index in the heap array
        for (i, elemt) in items.enumerated() {
            if elemt == element {
                removeIndex = i
            }
        }
        
        if removeIndex != -1 { // found one
            let result = items[removeIndex]
            // writeIndex - 1 is the last item index
            items[removeIndex] = items[writeIndex - 1]
            items[writeIndex - 1] = nil
            writeIndex -= 1
            heapFixDown(itemIndex: removeIndex, boundary: writeIndex)
            return result
        } else {
            return nil
        }
    }
    
    private mutating func heapFixDown(itemIndex c: Int, boundary b: Int) {
        var c = c
        var l = c * 2 + 1, r = c * 2 + 2
        while true {
            var max = c
            if l < b && items[l]! > items[max]! {
                max = l
            }
            if r < b && items[r]! > items[max]! {
                max = r
            }
            if max == c { break }
            items.swapAt(max, c)
            c = max
            l = c * 2 + 1
            r = c * 2 + 2
        }
    }
}

extension MaxHeap: CustomStringConvertible {
    public var description: String {
        return String(describing: items)
    }
}

class Solution {
    
    func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
        var keyPoints = [KeyPoint]()
        var res = [[Int]]()
        // Creat keypoint with buildings
        for building in buildings {
            keyPoints.append(KeyPoint(building[0], building[2], true))
            keyPoints.append(KeyPoint(building[1], building[2], false))
        }
        
        keyPoints.sort()
        
        var heap = MaxHeap(capacity: 100001)
        heap.insert(newElement: 0)
        
        for kp in keyPoints {
            if kp.isEnter { // for entering point
                if kp.h > heap.peek! {
                    res.append([kp.x, kp.h])
                }
                heap.insert(newElement: kp.h)
            } else { // for leaving point
                // remove the height first
                heap.remove(kp.h)
                if let maxHeight = heap.peek {
                    if kp.h > maxHeight {
                        res.append([kp.x, maxHeight])
                    }
                }
            }
        }
        
        return res
    }
}
```