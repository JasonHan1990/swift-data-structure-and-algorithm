import Foundation

public struct Stack<Element> {
    
    private var elements = Array<Element>()
    
    public var isEmpty: Bool {
        return elements.count == 0
    }
    
    public var count: Int { return elements.count }
    
    public var peek: Element? {
        guard let top = elements.last else {
            return nil
        }
        return top
    }
    
    public init() {}
    public init(elements: [Element]) {
        self.elements = elements
    }
    
    public mutating func push(newElement: Element) {
        elements.append(newElement)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        guard elements.last != nil else {
            return nil
        }
        return elements.removeLast()
    }
    
}

extension Stack: CustomStringConvertible {
    public var description: String {
        var s = "Stack:\n--- Top ---\n"
        for element in self.elements.reversed() {
            s += "\(element)\n"
        }
        s += "--- Bottom ---"
        return s
    }
}
