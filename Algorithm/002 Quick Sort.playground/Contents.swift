import Foundation


public func quicksort<T: Comparable>(array arr: inout [T]) {
    quick_sort(array: &arr, startIndex: 0, endIndex: arr.count - 1)
}

public func quick_sort<T: Comparable>(array arr: inout [T], startIndex s: Int, endIndex e: Int) {
    if s >= e { return }
    let pivotIndex = partition(array: &arr, startIndex: s, endIndex: e)
    print("pivot = \(pivotIndex), array = \(arr)")
    quick_sort(array: &arr, startIndex: s, endIndex: pivotIndex - 1)
    quick_sort(array: &arr, startIndex: pivotIndex + 1, endIndex: e)
}

fileprivate func partition<T: Comparable>(array: inout [T], startIndex s: Int, endIndex e: Int) -> Int {
    
    // I choose the last item as pivot here
    let pivot = array[e]
    // Use two points, start from the beginning.
    // i and j move to the right together
    // When found a item is greater than pivot, i stops
    // keep j moving right until found one item smaller or equal to pivot
    // swap items at i and j, then move i++ and j++
    // both i and j < last index
    // last swap the item at i and pivot, return i the pivot index
    var i = s, j = s
    while i < e && j < e {
        if array[j] <= pivot {
            array.swapAt(i, j)
            j += 1
            i += 1
        } else {
            j += 1
        }
    }
    
    // put the last one to location i
    array.swapAt(i, e)
    return i
}


var test = [2, 1, 4,9,0,5,3,0]
quicksort(array: &test)
assert(test == [0, 0, 1, 2, 3, 4, 5, 9])

