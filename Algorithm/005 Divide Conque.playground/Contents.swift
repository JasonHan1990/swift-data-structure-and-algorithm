import Foundation


// 计算逆序对个数Inversion
// 用分治算法，改造mergesort来实现计算逆序对个数

func countInversion(nums: [Int]) -> Int {
    var count = 0
    var nums = nums
    helper(&nums, 0, nums.count - 1, &count)
    return count
}

private func helper(_ nums: inout [Int], _ s: Int, _ e: Int, _ count: inout Int) {
    guard s < e else { return }
    
    let mid = s + (e - s) / 2
    // left
    helper(&nums, s, mid, &count)
    // right
    helper(&nums, mid + 1, e, &count)
    // merge
    countHelper(&nums, s, mid, e, &count)
}

private func countHelper(_ nums: inout [Int], _ s: Int, _ mid: Int, _ e: Int, _ count: inout Int) {
    var temp = Array<Int>()
    
    var l = s, r = mid + 1
    while l <= mid, r <= e {
        if nums[l] > nums[r] {
            count += (mid - l + 1)
            temp.append(nums[r])
            r += 1
        } else {
            temp.append(nums[l])
            l += 1
        }
    }
    
    // check left items
    if l <= mid {
        temp.append(contentsOf: nums[l...mid])
    }
    if r <= e {
        temp.append(contentsOf: nums[r...e])
    }
    
    // replace the original items with the sorted items
    var i = s
    for item in temp {
        nums[i] = item
        i += 1
    }
}

countInversion(nums: [2, 4, 3, 1, 5, 6])

