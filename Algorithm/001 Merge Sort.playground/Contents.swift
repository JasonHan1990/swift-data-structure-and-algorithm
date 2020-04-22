import Foundation

// merge sort


public func mergesort<T: Comparable>(array arr: inout [T]) {
    merge_sort(array: &arr, startIndex: 0, endIndex: arr.count - 1)
}

fileprivate func merge_sort<T: Comparable>(array arr: inout [T], startIndex s: Int, endIndex e: Int) {
    if s >= e { return }
    // be careful, since the start index could be value other than 0, the mid should be the start index plus the offset
    let offset = (e - s) / 2
    let mid = s + offset
    merge_sort(array: &arr, startIndex: s, endIndex: mid)
    merge_sort(array: &arr, startIndex: mid + 1, endIndex: e)
    merge(&arr, leftStart: s, leftEnd: mid, rightStart: mid + 1, rightEnd: e)
}

func merge<T: Comparable>(_ array: inout [T], leftStart ls: Int, leftEnd le: Int, rightStart rs: Int, rightEnd re: Int ) {
    
    // create a temp space to store the sorted items
    var temp = Array<T>()
    temp.reserveCapacity(re - ls + 1)
    // compare the items
    var i = ls, j = rs
    while i <= le && j <= re {
        if array[i] <= array[j] {
            temp.append(array[i])
            i += 1
        } else {
            temp.append(array[j])
            j += 1
        }
    }
    
    // check left items
    if i <= le {
        temp.append(contentsOf: array[i...le])
    }
    if j <= re {
        temp.append(contentsOf: array[j...re])
    }
    
    // replace the original items with the sorted items
    i = ls
    for item in temp {
        array[i] = item
        i += 1
    }
}


var test = [1, 6, 3, 5, 8, 2, 3]
mergesort(array: &test)
assert(test == [1, 2, 3, 3, 5, 6, 8])
