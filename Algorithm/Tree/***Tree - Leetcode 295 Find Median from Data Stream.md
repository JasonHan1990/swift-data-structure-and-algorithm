### [295\. Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream/)

Difficulty: **Hard**


Median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value. So the median is the mean of the two middle value.

For example,

`[2,3,4]`, the median is `3`

`[2,3]`, the median is `(2 + 3) / 2 = 2.5`

Design a data structure that supports the following two operations:

*   void addNum(int num) - Add a integer number from the data stream to the data structure.
*   double findMedian() - Return the median of all elements so far.

**Example:**

```
addNum(1)
addNum(2)
findMedian() -> 1.5
addNum(3) 
findMedian() -> 2
```

**Follow up:**

1.  If all integer numbers from the stream are between 0 and 100, how would you optimize it?
2.  If 99% of all integer numbers from the stream are between 0 and 100, how would you optimize it?


#### Solution

Language: **Swift**

```swift
    let leftChildIndex = self.leftChildIndex(ofIndex: index)
  /*
    Allows you to change the priority of an element. In a max-priority queue,
    the new priority should be larger than the old one; in a min-priority queue
    it should be smaller.
  */
  public mutating func changePriority(index i: Int, value: T) {
    return heap.replace(index: i, value: value)
  }
}
​
extension PriorityQueue where T: Equatable {
  public func index(of element: T) -> Int? {
    return heap.index(of: element)
  }
}
​
class MedianFinder {
    var minQueue = PriorityQueue<Int>(sort: <) // right
    var maxQueue = PriorityQueue<Int>(sort: >) // left
    /** initialize your data structure here. */
    init() {
        // var minQueue = PriorityQueue<Int>(sort: <) // right
        // var maxQueue = PriorityQueue<Int>(sort: >) // left
    }
    
    func addNum(_ num: Int) {
        guard maxQueue.count != 0 else {
            maxQueue.enqueue(num)
            return
        }
        if num > maxQueue.peek()! {
            minQueue.enqueue(num)
            if minQueue.count > maxQueue.count + 1 {
                let num = minQueue.dequeue()
                maxQueue.enqueue(num!)
            }
        } else {
            maxQueue.enqueue(num)
            if maxQueue.count > minQueue.count {
                let num = maxQueue.dequeue()
                minQueue.enqueue(num!)
            }
        }
    }
    
    func findMedian() -> Double {
        if maxQueue.count == minQueue.count {
            return (Double(maxQueue.peek()!) + Double(minQueue.peek()!)) / 2.0
        }
        return Double(minQueue.peek()!)
    }
}
​
/**
 * Your MedianFinder object will be instantiated and called as such:
 * let obj = MedianFinder()
 * obj.addNum(num)
 * let ret_2: Double = obj.findMedian()
 */
```