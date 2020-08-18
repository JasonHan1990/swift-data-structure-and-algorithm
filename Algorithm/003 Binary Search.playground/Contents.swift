import Foundation


// find target in data without duplicate
func binarySearch<T: RandomAccessCollection>(data: T, target: T.Element) -> T.Index? where T.Element: Comparable {
    
    var low = data.startIndex
    var high = data.index(before: data.endIndex)
    
    while low <= high {
        let distance = data.distance(from: low, to: high)
        let mid = data.index(low, offsetBy: distance/2)
        let find = data[mid]
        if find == target {
            return mid
        } else if find > target {
            high = data.index(before: mid) // mid - 1
        } else {
            low = data.index(after: mid) // mid + 1
        }
    }
    return nil
}

binarySearch(data: [1, 2, 4, 5], target: 3)



// find the first item equal to target
func binarySearchForFirst<T: RandomAccessCollection>(equalTo target: T.Element, data: T) -> T.Index? where T.Element: Comparable {
    
    var low = data.startIndex
    var high = data.index(before: data.endIndex)
    while low < high {
        let distance = data.distance(from: low, to: high)
        let mid = data.index(low, offsetBy: distance/2)
        let find = data[mid]
        if find == target {
            high = mid
        } else if find > target {
            high = data.index(before: mid) // mid - 1
        } else {
            low = data.index(after: mid) // mid + 1
        }
    }
    return data[low] == target ? low : nil
}

binarySearchForFirst(equalTo: 3, data: [3, 3])


// find the last item equal to target
func binarySearchForLast<T: RandomAccessCollection>(equalTo target: T.Element, data: T) -> T.Index? where T.Element: Comparable {
    
    var low = data.startIndex
    var high = data.index(before: data.endIndex)
    while low < data.index(before: high) { // low < high - 1
        let distance = data.distance(from: low, to: high)
        let mid = data.index(low, offsetBy: distance/2)
        let find = data[mid]
        if find == target {
            low = mid
        } else if find > target {
            high = data.index(before: mid) // mid - 1
        } else {
            low = data.index(after: mid) // mid + 1
        }
    }
    
    if data[high] == target {
        return high
    }
    if data[low] == target {
        return low
    }
    return nil
}

binarySearchForLast(equalTo: 8 , data: [1, 3, 4, 5, 6, 8, 8, 8, 8, 11, 18])



func binarySearchForLastElement<T: RandomAccessCollection>(smallerThan target: T.Element, data: T) -> T.Index? where T.Element: Comparable {
    
    var low = data.startIndex
    var high = data.index(before: data.endIndex)
    while low < data.index(before: high) { // low < high - 1
       let distance = data.distance(from: low, to: high)
       let mid = data.index(low, offsetBy: distance/2)
       let find = data[mid]
       if find == target {
           high = data.index(before: mid)
       } else if find > target {
           high = data.index(before: mid) // mid - 1
       } else {
           low = mid
       }
    }

    if data[high] < target {
       return high
    }
    
    if data[low] < target {
       return low
    }
    return nil
}


binarySearchForLastElement(smallerThan: 7, data: [3, 5, 6, 8, 9, 10])

func binarySearchForFirstElement<T: RandomAccessCollection>(greaterThan target: T.Element, data: T) -> T.Index? where T.Element: Comparable {
    
    var low = data.startIndex
    var high = data.index(before: data.endIndex)
    while low <  high { // low < high
       let distance = data.distance(from: low, to: high)
       let mid = data.index(low, offsetBy: distance/2)
       let find = data[mid]
       if find == target {
          low = data.index(after: mid)
       } else if find > target {
           high = mid
       } else {
           low = data.index(after: mid)
       }
    }

    if data[low] > target {
        return low
    }
    return nil

}

binarySearchForFirstElement(greaterThan: 2, data: [1, 8, 8, 8, 8, 8])
