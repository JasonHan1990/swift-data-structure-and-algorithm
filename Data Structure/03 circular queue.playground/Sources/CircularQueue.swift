import Foundation

public struct CircularQueue<Element> {
    
    private var circularBuffer: CircularBuffer<Element>!
    
    private init(){}
    
    public init(capacity: Int) {
        circularBuffer = CircularBuffer(capacity: capacity)
    }
    
    public mutating func enqueue(newElement: Element) -> Bool {
        return circularBuffer.write(newElement: newElement)
    }
    
    public mutating func dequeue() -> Element? {
        return circularBuffer.read()
    }
}

extension CircularQueue: CustomStringConvertible {
    public var description: String {
        return String(describing: circularBuffer)
    }
}
