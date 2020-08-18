import Foundation


// implementation for FIFO queue using array
// count, isFull, enqueue, dequeue

struct Queue<Element> {
    
    var items: [Element?]!
    var first: Int = 0, last = 0
    // The reason we define a capacity to store capacity information is because
    // Swift init even number of capacity, for example, if you set capacity to 3,
    // the array capacity in reality is 4
    var capacity: Int!
    var count: Int { return items.count - first }
    var isFull: Bool { return last == items.count}
    var isEmpty: Bool { return first == last}
    var peek: Element? {
        return self.isEmpty ? nil : items[first]
    }
    
    
    init(capacity: Int) {
        items = [Element]()
        items.reserveCapacity(capacity)
        self.capacity = capacity
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        if isFull {
            return false
        }
        enqueueElement(newElement)
        return true
    }
    
    private mutating func enqueueElement(_ e: Element) {
        // if array has no space, clear it then add item
        if items.count == items.capacity {
            var i = 0, j = firstItemIndex
            while j < items.count {
                items.swapAt(i, j)
                j += 1
                i += 1
            }
            while i < items.count {
                items.removeLast()
                i += 1
            }
            firstItemIndex = -1
        }
        items.append(e)
    }
    
    mutating func dequeue() -> Element? {
        if firstItemIndex > -1, let dequeueItem = items[firstItemIndex] {
            firstItemIndex += 1
            if firstItemIndex == items.count {
                // keep the capacity, otherwise the enqueue will have no space to insert.
                items.removeAll(keepingCapacity: true)
                firstItemIndex = -1
            }
            return dequeueItem
        } else {
            return nil
        }
    }
    
    
}

extension Queue: CustomStringConvertible {
    var description: String {
        return items.description
    }
}


var queue = Queue<Int>(capacity: 4)
assert(queue.dequeue() == nil, "The empty queue should return nil.")
assert(queue.peek == nil, "The empty queue should peek nil.")

queue.enqueue(newElement: 1)
print(queue)
queue.enqueue(newElement: 1)
print(queue)
queue.enqueue(newElement: 1)
print(queue)
queue.enqueue(newElement: 1)
print(queue)
queue.enqueue(newElement: 1)
print(queue)
