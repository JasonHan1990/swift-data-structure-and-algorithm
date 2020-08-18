import Foundation
/*: ### Singly Linked List
![Singly linked list](SinglyLinkedList.png)
 */


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



/*: ### Doubly Linked List
![Doubly linked list](DoublyLinkedList.png)
 */

let double_linkedlist = DLinkedList(with: array)

assert(double_linkedlist.stringify() == "a -> b -> c -> d -> e\ne -> d -> c -> b -> a", "Double Linked list - init error")
assert(double_linkedlist.size == 5, "Double Linked list - size error")
assert(double_linkedlist.find(with: "b")?.value == "b", "Double Linked list - find error")
assert(double_linkedlist.find(with: "g") == nil, "Double Linked list - find error")
double_linkedlist.delete(with: "g")
assert(double_linkedlist.stringify() == "a -> b -> c -> d -> e\ne -> d -> c -> b -> a", "Double Linked list - delete error")
double_linkedlist.delete(with: "c")
assert(double_linkedlist.stringify() == "a -> b -> d -> e\ne -> d -> b -> a", "Double Linked list - delete error")



