import Foundation

public struct CircularBuffer<Element> {
    
    private var storageSpace : [Element?]!
    private var readIndex: Int = 0
    private var writeIndex: Int = 0
    
    // The circular buffer will waste one space for easily checking isFull.
    // So, this capacity is the real capacity that could store elements
    public var capacity: Int {
        return storageSpace.capacity - 1
        
    }
    public var isFull: Bool {
        return (writeIndex + 1) % storageSpace.capacity == readIndex
        
    }
    public var isEmpty: Bool {
        return writeIndex == readIndex
    }
    
    
    private init() {}
    public init(capacity: Int) {
        storageSpace = Array<Element?>(repeating: nil, count: capacity + 1)
        print(storageSpace.capacity)
    }
    
    @discardableResult
    public mutating func write(newElement: Element) -> Bool {
        if isFull {
            return false
        }
        storageSpace[writeIndex] = newElement
        writeIndex = (writeIndex + 1) % storageSpace.capacity
        return true
    }
    
    
    // read and remove
    @discardableResult
    public mutating func read() -> Element? {
        if isEmpty {
            return nil
        }
        let element = storageSpace[readIndex]
        readIndex = (readIndex + 1) % storageSpace.capacity
        return element
    }
    
    @discardableResult
    public mutating func peek() -> Element? {
        if isEmpty {
            return nil
        }
        return storageSpace[readIndex]
    }
}


extension CircularBuffer: CustomStringConvertible {
    public var description: String {
        var start = readIndex, end = writeIndex, string = "Circular Buffer: [\n"
        if start <= end {
            while start < end {
                string += "\(String(describing: storageSpace[start])) "
                start += 1
            }
        } else {
            while start < storageSpace.capacity {
                string += "\(String(describing: storageSpace[start])) "
                start += 1
            }
            var start = 0
            while start < end {
                string += "\(String(describing: storageSpace[start])) "
                start += 1
            }
        }
        string += "\n]\n"
        
        return string
    }
}
