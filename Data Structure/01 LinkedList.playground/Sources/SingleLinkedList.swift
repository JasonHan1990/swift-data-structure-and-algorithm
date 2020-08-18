import Foundation

public class SNode<T> {
    public var value: T?
    public var next: SNode?
    
    init() {}
    public init(_ value: T, _ next: SNode? = nil) {
        self.value = value
    }
}

// Singly linked list, implement size, isEmpty, create list with array, insert, delete, find

public class SLinkedList<Element: Equatable> {
    
    private let dummy = SNode<Element>()
    public var size : Int {
        var size = 0
        var p = dummy
        while(p.next != nil) {
            p = p.next!
            size = size + 1
        }
        return size
    }
    
    public var isEmpty : Bool { return size == 0 }
    
    public init() {}
    
    // init a list with an array and keep the order
    public init(_ array: Array<Element>) {
        var lastIndex = array.count - 1
        while lastIndex >= 0 {
            insertToFront(array[lastIndex])
            lastIndex -= 1
        }
    }
    
    // find a node with the value equal
    public func find(with value: Element) -> SNode<Element>? {
        var p = dummy.next
        while p != nil {
            if p!.value == value {
                return p
            }
            p = p!.next
        }
        return nil
    }
    
    
    public func insertToFront(_ newElement: Element) {
        let newNode = SNode(newElement)
        
        newNode.next = dummy.next
        dummy.next = newNode
    }
    
    public func insertToTail(_ newElement: Element) {
        let newNode = SNode(newElement)
        
        var p = dummy
        while(p.next != nil) {
            p = p.next!
        }
        newNode.next = p.next
        p.next = newNode
    }
    
    public func delete(with value: Element) {
        var pre = dummy
        var cur = dummy.next
        while cur != nil {
            if cur!.value == value {
                pre.next = cur!.next
                cur = nil
                break
            }
            pre = pre.next!
            cur = cur!.next
        }
    }
    
    // stringify the list to "a -> b -> c"
    public func stringify() -> String {
        var s = ""
        var p = dummy
        while(p.next != nil) {
            s += "\(String(describing: p.next!.value!))"
            if p.next!.next != nil {
                s += " -> "
            }
            p = p.next!
        }
        return s
    }
}

extension SLinkedList: CustomStringConvertible {
    public var description: String {
        return self.stringify()
    }
}
