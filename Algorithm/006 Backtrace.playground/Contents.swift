import Foundation



var result = Array<Int>(repeating: -1, count: 8)

func eightQueue(row: Int) {
    if row == 8 {
        // successfully add all queens
        print(result)
        return
    }
    
    for i in 0...7 { // for current row, check all columns
        if isOK(row: row, col: i) {
            result[row] = i
            // next row
            eightQueue(row: row + 1)
        }
    }
}

func isOK(row: Int, col: Int) -> Bool {
    var upleft = col - 1, upright = col + 1, prevRow = row - 1
    while prevRow >= 0 {
        // if prev row has a queue at this column, return false
        if result[prevRow] == col {
            return false
        }
        // if prev row has a queue at left
        if upleft >= 0 && result[prevRow] == upleft {
            return false
        }
        
        // if prev row has a queue at left
        if upright < 8 && result[prevRow] == upright {
            return false
        }
        
        prevRow -= 1 // check upper row
        upleft -= 1
        upright += 1
    }
    return true
}

// eightQueue(row: 0)


func permutation(elements: [Character]) -> [[Character]] {
    var result = [[Character]]()
    let current = [Character]()
    var charactor_dict = [Character : Int]()
    for e in elements {
        if charactor_dict.keys.contains(e) {
            charactor_dict[e] = charactor_dict[e]! + 1
        } else {
            charactor_dict[e] = 1
        }
    }
    permutation(elements: elements, current: current, result: &result, char_dict: charactor_dict)
    return result
}

private func permutation(elements: [Character], current: [Character], result: inout [[Character]], char_dict: [Character : Int]) {
    if current.count == elements.count {
        result.append(current)
        return
    }
    
    for e in elements {
        if char_dict[e] == 0 {
            continue
        } else {
            var current = current
            current.append(e)
            var char_dict = char_dict
            char_dict[e] = char_dict[e]! - 1
            permutation(elements: elements, current: current, result: &result, char_dict: char_dict)
        }
    }
}

print(permutation(elements: ["a", "a", "c"]))



func permute(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    var nums = nums
    permute(&nums, 0, &res)
    return res
}

private func permute(_ nums: inout [Int], _ start: Int, _ res: inout [[Int]]) {
    if start == nums.count {
        res.append(nums)
        return
    }
    
    for i in start..<nums.count {
        if check(&nums, start, i) {
            nums.swapAt(i, start)
            permute(&nums, start + 1, &res)
            nums.swapAt(i, start)
        }
    }
}

private func check(_ nums: inout [Int],_ l: Int,_ r: Int) -> Bool {
    print("s = \(l), cur = \(r)")
    for i in l..<r {
        if nums[i] == nums[r] {
            return false
        }
    }
    return true
}

permute([1, 1, 3])



// fill bag 0-1 bag

var maxW = Int.min
func fillBag(items: [Int], w: Int, i: Int, curW: Int) {
    if curW == w || i == items.count {
        maxW = max(maxW, curW)
        return
    }
    
    fillBag(items: items, w: w, i: i + 1, curW: curW) // not add item at i
    if curW + items[i] <= w {
        fillBag(items: items, w: w, i: i + 1, curW: curW + items[i]) // add item at i
    }
}

fillBag(items: [1, 2, 3, 4, 5], w: 13, i: 0, curW: 0)

print(maxW)



let itemW = [5, 4, 7, 2, 6]
let itemV = [12, 3, 10, 3, 6]
let w = 10

func fillBagGetMostValue(_ itemW: [Int], _ itemV: [Int], _ w: Int) -> Int {
    // index is the weight, value is the current max value
    var dp = Array<Int>(repeating: -1, count: w + 1)
    // init the dp storage
    dp[0] = 0
    dp[itemW[0]] = itemV[0]
    
    for i in 1..<itemW.count {
        var j = w - itemW[i]
        while j > 0 {
            if dp[j] != -1 { // has value before
                dp[j + itemW[i]] = max(dp[j + itemW[i]], dp[j] + itemV[i])
            }
            j -= 1
        }
    }
//      print(dp)
    dp.sort()

    return dp.last!
}

fillBagGetMostValue(itemW, itemV, w)
