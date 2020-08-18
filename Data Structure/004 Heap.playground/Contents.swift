import Foundation


public struct MaxHeap {
    
    
    private var items : [Int?]
    private var writeIndex = 0
    
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

extension MaxHeap {
    public mutating func heapsort() -> [Int?] {
        if isEmpty {
            return [Int]()
        }
        var last = writeIndex - 1
        while last > 0 {
            items.swapAt(last, 0)
            heapFixDown(itemIndex: 0, boundary: last)
            last -= 1
        }
        return items
    }
}


//var heap = MaxHeap(capacity: 10)
//
//heap.insert(newElement: 1)
//heap.insert(newElement: 2)
//heap.insert(newElement: 3)
//heap.insert(newElement: 4)
//heap.insert(newElement: 5)
//heap.insert(newElement: 6)
//heap.insert(newElement: 7)
//heap.insert(newElement: 8)
//heap.insert(newElement: -1)
//heap.insert(newElement: 10)
//print(heap)
//
//heap.remove()
//print(heap)
//heap.insert(newElement: 10)
//print(heap)


var heap_array = MaxHeap(array: [1,3,2])

print(heap_array)

heap_array.remove(2)

print(heap_array.heapsort())
