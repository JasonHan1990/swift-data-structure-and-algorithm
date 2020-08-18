import Foundation

let maze = [[1, 3, 5, 9],
            [2, 1, 3, 4],
            [5, 2, 6, 7]], m = 3, n = 4

func shortestPathInMaze(_ maze: [[Int]], n: Int, m: Int) -> Int {

    var dp = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: n), count: m)
    dp[0][0] = maze[0][0]

    for i in 0..<m {
        for j in 0..<n {
            if i == 0 && j == 0 {
                continue
            }
            if i - 1 < 0 {
                dp[i][j] = dp[i][j - 1] + maze[i][j]
            } else if j - 1 < 0 {
                dp[i][j] = dp[i - 1][j] + maze[i][j]
            } else {
                dp[i][j] = min(dp[i][j - 1], dp[i - 1][j]) + maze[i][j]
            }
        }
    }
    print(dp)
    return dp[m - 1][n - 1]
}

shortestPathInMaze(maze, n: n, m: m)



//
//  Levenshtein distance
//


// 子问题：一个字符串和另一个字符串的距离等于前半截字符串的距离，加上后半截字符串的距离

// backtrace!!!!!
func levenshteinDistance(_ a: String, _ b: String) -> Int {
    let ac = Array(a), bc = Array(b)
    var res = Int.max
    levenshteinDistance(ac, bc, 0, 0, 0, &res)
    return res
}

private func levenshteinDistance(_ ac: [Character], _ bc: [Character], _ i: Int, _ j: Int, _ cur: Int, _ res: inout Int) {
    if i == ac.count || j == bc.count {
        var cur = cur
        if i != ac.count {
            cur += (ac.count - i)
        }
        if j != ac.count {
            cur += (bc.count - j)
        }
        res = min(res, cur)
        return
    }
    
    if ac[i] == bc[j] {
        levenshteinDistance(ac, bc, i + 1, j + 1, cur, &res)
    } else {
        levenshteinDistance(ac, bc, i, j + 1, cur + 1, &res)
        levenshteinDistance(ac, bc, i + 1, j, cur + 1, &res)
        levenshteinDistance(ac, bc, i + 1, j + 1, cur + 1, &res)
    }
}

levenshteinDistance("bite", "tibe")

// dp

func levenshteinDistanceDP(_ a: String, _ b: String) -> Int {
    return levenshteinDistanceDP(Array(a), Array(b), a.count, b.count)
}


private func levenshteinDistanceDP(_ ac: [Character], _ bc: [Character], _ n: Int, _ m: Int) -> Int {
    
    var minDist = Array<Array<Int>>(repeating: Array(repeating: 0, count: n), count: m)
    print(minDist)
    // init the minDist first row
    for i in 0..<n {
        if ac[i] == bc[0] {
            minDist[0][i] = i
        } else if i != 0 {
            minDist[0][i] = minDist[0][i - 1] + 1
        } else { // i == 0 && ac[0] == bc[0]
             minDist[0][i] = 1
        }
    }
    
    // init the minDist first col
    for j in 0..<m {
        if ac[0] == bc[j] {
            minDist[j][0] = j
        } else if j != 0 {
            minDist[j][0] = minDist[j][0] + 1
        } else { // j == 0 && ac[0] == bc[0]
             minDist[j][0] = 1
        }
    }

    for i in 1..<m {
        for j in 1..<n {
            if ac[j] == bc[i] {
                minDist[i][j] = min(minDist[i - 1][j - 1], minDist[i - 1][j] + 1, minDist[i][j - 1] + 1)
            } else {
                minDist[i][j] = min(minDist[i - 1][j - 1] + 1, minDist[i - 1][j] + 1, minDist[i][j - 1] + 1)
            }
        }
    }
    
    print(minDist)
    
    return minDist[m - 1][n - 1]
}


levenshteinDistanceDP("bite", "tibe")


func longestCommonSequenceBT(_ a: String, _ b: String) -> Int {
    var res = 0
    longestCommonSequenceBT(Array(a), Array(b), 0, 0, 0, &res)
    return res
}

private func longestCommonSequenceBT(_ a: [Character], _ b: [Character], _ i: Int, _ j: Int, _ cur: Int, _ res: inout Int) {
    
    if i == a.count || j == b.count {
        res = max(res, cur)
        return
    }
    
    if a[i] == b[j] {
        longestCommonSequenceBT(a, b, i + 1, j + 1, cur + 1, &res)
    } else {
        longestCommonSequenceBT(a, b, i + 1, j, cur, &res)
        longestCommonSequenceBT(a, b, i, j + 1, cur, &res)
    }
}

longestCommonSequenceBT("mitcmu", "mtacnu")


func longestCommonSequenceDP(_ a: String, _ b: String) -> Int {
    return longestCommonSequenceDP(Array(a), Array(b), a.count, b.count)
}


private func longestCommonSequenceDP(_ a: [Character], _ b: [Character], _ n: Int, _ m: Int) -> Int {
    var lcs = Array(repeating: Array(repeating: 0, count: n), count: m)
    
    // init first row and first col
    for i in 0..<n {
        if a[i] == b[0] {
            lcs[0][i] = 1
        } else if i != 0 {
            lcs[0][i] = lcs[0][i - 1]
        } else {
            lcs[0][i] = 0
        }
    }
    for j in 0..<m {
        if a[0] == b[j] {
            lcs[j][0] = 1
        } else if j != 0 {
            lcs[j][0] = lcs[j - 1][j]
        } else {
            lcs[j][0] = 0
        }
    }
    
    for j in 1..<m {
        for i in 1..<n {
            if a[i] == b[j] {
                lcs[j][i] = max(lcs[j - 1][i - 1] + 1, lcs[j - 1][i], lcs[j][i - 1])
            } else {
                lcs[j][i] = max(lcs[j - 1][i - 1], lcs[j - 1][i], lcs[j][i - 1])
            }
        }
    }
    
    return lcs[m - 1][n - 1]
}

longestCommonSequenceDP("mm", "m")

///

func longestCommonSubstringBT(_ a: String, _ b: String) -> Int {
    var res = 0
    longestCommonSubstringBT(Array(a), Array(b), 0, 0, 0, &res)
    return res
}

func longestCommonSubstringBT(_ a: [Character], _ b: [Character], _ i: Int, _ j: Int, _ cur: Int, _ res: inout Int) {
    
    if i == a.count || j == b.count {
        res = max(res, cur)
        return
    }

    if a[i] == b[i] {
        longestCommonSubstringBT(a, b, i + 1, j + 1, cur + 1, &res)
    } else {
        // update the res immidiately
        res = max(res, cur)
        longestCommonSubstringBT(a, b, i, j + 1, cur, &res)
        longestCommonSubstringBT(a, b, i + 1, j, cur, &res)
        longestCommonSubstringBT(a, b, i + 1, j + 1, cur, &res)
    }
}

longestCommonSubstringBT("12345c", "22345c")


func longestCommonSubstringDP(_ a: String, _ b: String) -> Int {
    return longestCommonSubstringDP(Array(a), Array(b))
}

func longestCommonSubstringDP(_ a: [Character], _ b: [Character]) -> Int {
    let n = a.count, m = b.count
    var lcs = Array(repeating: Array(repeating: 0, count: n), count: m)
    
    // init lcs first row and col
    for i in 0..<n {
        lcs[0][i] = (a[i] == b[0] ? 1 : 0)
    }
    for j in 0..<n {
        lcs[j][0] = (a[0] == b[j] ? 1 : 0)
    }
    
    for j in 1..<m {
        for i in 1..<n {
            if a[i] == b[j] {
                lcs[j][i] = lcs[j - 1][i - 1] + 1
            } else {
                lcs[j][i] = 0
            }
        }
    }
    var maxLcs = 0
    for j in 1..<m {
        for i in 1..<n {
            maxLcs = max(maxLcs, lcs[i][j])
        }
    }
    return maxLcs
}

longestCommonSubstringDP("abcde", "abcee")



// 凑零钱问题
// 先看下题目：给你 k 种面值的硬币，面值分别为 c1, c2 ... ck，每种硬币的数量无限，再给一个总金额 amount，问你最少需要几枚硬币凑出这个金额，如果不可能凑出，算法返回 -1 。
let k = 3, coins = [1, 3, 5], amount = 11

func coinChanges(_ coins: [Int], _ amount: Int) -> Int {
    var res = Int.max
    coinChanges(coins.reversed(), amount, 0, 0, 0, &res)
    return res
}

private func coinChanges(_ coins: [Int], _ amount: Int, _ start: Int, _ cur: Int, _ count: Int, _ res: inout Int) {
    print(cur)
    if cur > amount {
        return
    }
    if cur == amount {
        // update the count
        res = min(res, cur)
        return
    }
    
    //for c in start..<coins.count {
        if cur + coins[start] <= amount {
            coinChanges(coins, amount, start, cur + coins[start], count + 1, &res)
        } else {
            coinChanges(coins, amount, start + 1, cur, count, &res)
        }
    //}
}

coinChanges(coins, amount)





