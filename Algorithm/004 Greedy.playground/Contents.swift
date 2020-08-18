import Foundation

// interval

let intervals = [(6, 8), (2, 4), (3, 5), (1, 5), (5, 9), (8, 9)]


func mostNonOverlapIntervals(intervals: [(Int, Int)]) -> [(Int, Int)] {
    if intervals.count == 0 || intervals.count == 1 {
        return intervals
    }
    
    // sort
    let intervals = intervals.sorted { (a, b) -> Bool in
        return a.0 < b.0
    }
    
    var prev_spacing = intervals[0].1 - intervals[0].0
    var result = [intervals[0]]
    for i in 1..<intervals.count {
        let spacing = intervals[i].1 - intervals[i].0
        // no overlap, add to the result
        if intervals[i].0 >= result.last!.1 {
            prev_spacing = spacing
            result.append(intervals[i])
        } else { // has overlap, compare the spacing
            if spacing < prev_spacing {
                prev_spacing = spacing
                result[result.count - 1] = intervals[i]
            }
        }
    }
    
    return result
}


mostNonOverlapIntervals(intervals: intervals)
