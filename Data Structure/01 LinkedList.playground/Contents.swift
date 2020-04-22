import Foundation

/*: ### Singly Linked List
![Singly linked list](SinglyLinkedList.png)
 */
// singly list node
class SNode<T> {
    var value: T?
    var next: SNode?
    
    init() {}
    init(_ value: T) {
        self.value = value
    }
}

// Singly linked list, implement size, isEmpty, create list with array, insert, delete, find

class SLinkedList<Element: Equatable> {
    
    private let dummy = SNode<Element>()
    var size : Int {
        var size = 0
        var p = dummy
        while(p.next != nil) {
            p = p.next!
            size = size + 1
        }
        return size
    }
    
    var isEmpty : Bool { return size == 0 }
    
    init() {}
    
    // init a list with an array and keep the order
    init(_ array: Array<Element>) {
        var lastIndex = array.count - 1
        while lastIndex >= 0 {
            insertToFront(array[lastIndex])
            lastIndex -= 1
        }
    }
    
    // find a node with the value equal
    func find(with value: Element) -> SNode<Element>? {
        var p = dummy.next
        while p != nil {
            if p!.value == value {
                return p
            }
            p = p!.next
        }
        return nil
    }
    
    
    func insertToFront(_ newElement: Element) {
        let newNode = SNode(newElement)
        
        newNode.next = dummy.next
        dummy.next = newNode
    }
    
    func insertToTail(_ newElement: Element) {
        let newNode = SNode(newElement)
        
        var p = dummy
        while(p.next != nil) {
            p = p.next!
        }
        newNode.next = p.next
        p.next = newNode
    }
    
    func delete(with value: Element) {
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
    func stringify() -> String {
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
    var description: String {
        return self.stringify()
    }
}


// Singly linked list testing
let array = ["a", "b", "c", "d", "e"]
var singly_list = SLinkedList(array)

assert(singly_list.stringify() == "a -> b -> c -> d -> e", " Single Linked list - init error ")
assert(singly_list.size == array.count, " Single Linked list - size error ")
assert(singly_list.isEmpty == false, " Single Linked list - isEmpty error ")
assert(singly_list.find(with: "c")!.value == "c", " Single Linked list - find error ")
assert(singly_list.find(with: "f") == nil, " Single Linked list - find error ")
singly_list.insertToTail("f")
assert(singly_list.stringify() == "a -> b -> c -> d -> e -> f", " Single Linked list - insertToTail error ")
singly_list.insertToFront("z")
assert(singly_list.stringify() == "z -> a -> b -> c -> d -> e -> f", " Single Linked list - insertToTail error ")
singly_list.delete(with: "g")
assert(singly_list.stringify() == "z -> a -> b -> c -> d -> e -> f", " Single Linked list - delete error ")
singly_list.delete(with: "z")
assert(singly_list.stringify() == "a -> b -> c -> d -> e -> f", " Single Linked list - delete error ")
singly_list.delete(with: "e")
assert(singly_list.stringify() == "a -> b -> c -> d -> f", " Single Linked list - delete error ")
singly_list.delete(with: "f")
assert(singly_list.stringify() == "a -> b -> c -> d", " Single Linked list - delete error ")


/*: ### Double Linked List
 ![Double linked list](DoubleLinkedList.png)
 */
class DNode<T> {
    var prev: DNode?
    var next: DNode?
    var value: T?
    
    init(){}
    init(with value: T) {
        self.value = value
    }
}

class DLinkedList<Element: Equatable> {
    
    var headDummy: DNode<Element>!
    var tailDummy: DNode<Element>!
    
    init() {
        commmonInit()
    }
    
    init(with array: Array<Element>) {
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
    
    var size: Int {
        var num = 0
        var p = headDummy.next
        while p !== tailDummy {
            num += 1
            p = p!.next
        }
        return num
    }
    
    var isEmpty: Bool {
        return size == 0
    }
    
    var last: Element? {
        return tailDummy.prev!.value
    }
    
    func insertToFront(_ newElement: Element) {
        let newNode = DNode(with: newElement)
        let next = headDummy.next
        headDummy.next = newNode
        newNode.prev = headDummy
        newNode.next = next
        next!.prev = newNode
    }
    
    func insertToTail(_ newElement: Element) {
        let newNode = DNode(with: newElement)
        let prev = tailDummy.prev
        prev!.next = newNode
        newNode.prev = prev
        newNode.next = tailDummy
        tailDummy.prev = newNode
    }
    
    func find(with value: Element) -> DNode<Element>? {
        var p = headDummy.next
        while p !== tailDummy {
            if p!.value == value {
                return p
            }
            p = p!.next
        }
        return nil
    }
    
    func delete(with value: Element) {
        if let findNode = find(with: value) {
            let prevNode = findNode.prev
            let nextNode = findNode.next
            prevNode!.next = nextNode
            nextNode!.prev = prevNode
            findNode.prev = nil
            findNode.next = nil
        }
    }
    
    func stringify() -> String {
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


let double_linkedlist = DLinkedList(with: array)

assert(double_linkedlist.stringify() == "a -> b -> c -> d -> e\ne -> d -> c -> b -> a", "Double Linked list - init error")
assert(double_linkedlist.size == 5, "Double Linked list - size error")
assert(double_linkedlist.find(with: "b")?.value == "b", "Double Linked list - find error")
assert(double_linkedlist.find(with: "g") == nil, "Double Linked list - find error")
double_linkedlist.delete(with: "g")
assert(double_linkedlist.stringify() == "a -> b -> c -> d -> e\ne -> d -> c -> b -> a", "Double Linked list - delete error")
double_linkedlist.delete(with: "c")
assert(double_linkedlist.stringify() == "a -> b -> d -> e\ne -> d -> b -> a", "Double Linked list - delete error")
