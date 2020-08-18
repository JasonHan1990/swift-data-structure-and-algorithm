import Foundation

public class DNode<T> {
    public var prev: DNode?
    public var next: DNode?
    public var value: T?
    
    init(){}
    public init(with value: T, _ prev: DNode? = nil, _ next: DNode? = nil) {
        self.value = value
    }
}

public class DLinkedList<Element: Equatable> {
    
    private var headDummy: DNode<Element>!
    private var tailDummy: DNode<Element>!
    
    public init() {
        commmonInit()
    }
    
    public init(with array: Array<Element>) {
        commmonInit()
        
        var lastIndex = array.count - 1
        while lastIndex >= 0 {
            insertToFront(array[lastIndex])
            lastIndex -= 1
        }
    }
    
    private func commmonInit() {
        headDummy = DNode()
        tailDummy = DNode()
        
        headDummy.next = tailDummy
        tailDummy.prev = headDummy
    }
    
    public var size: Int {
        var num = 0
        var p = headDummy.next
        while p !== tailDummy {
            num += 1
            p = p!.next
        }
        return num
    }
    
    public var isEmpty: Bool {
        return size == 0
    }
    
    public var last: Element? {
        return tailDummy.prev!.value
    }
    
    public func insertToFront(_ newElement: Element) {
        let newNode = DNode(with: newElement)
        let next = headDummy.next
        headDummy.next = newNode
        newNode.prev = headDummy
        newNode.next = next
        next!.prev = newNode
    }
    
    public func insertToTail(_ newElement: Element) {
        let newNode = DNode(with: newElement)
        let prev = tailDummy.prev
        prev!.next = newNode
        newNode.prev = prev
        newNode.next = tailDummy
        tailDummy.prev = newNode
    }
    
    public func find(with value: Element) -> DNode<Element>? {
        var p = headDummy.next
        while p !== tailDummy {
            if p!.value == value {
                return p
            }
            p = p!.next
        }
        return nil
    }
    
    public func delete(with value: Element) {
        if let findNode = find(with: value) {
            let prevNode = findNode.prev
            let nextNode = findNode.next
            prevNode!.next = nextNode
            nextNode!.prev = prevNode
            findNode.prev = nil
            findNode.next = nil
        }
    }
    
    public func stringify() -> String {
        var s = ""
        // from head to tail
        var p = headDummy.next
        while p !== tailDummy {
            s += "\(String(describing: p!.value!))"
            if p!.next !== tailDummy {
                s += " -> "
            }
            p = p!.next!
        }
        s += "\n"
        // from tail to front
        p = tailDummy.prev
        while p !== headDummy {
            s += "\(String(describing: p!.value!))"
            if p!.prev !== headDummy {
                s += " -> "
            }
            p = p!.prev!
        }
        return s
    }
}

extension DLinkedList: CustomStringConvertible {
    public var description: String {
        return self.stringify()
    }
}
