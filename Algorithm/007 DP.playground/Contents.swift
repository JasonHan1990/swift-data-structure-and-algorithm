import Foundation
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
        res = min(res, count)
        return
    }
    
    for c in start..<coins.count {
        if cur + coins[c] <= amount {
            coinChanges(coins, amount, start, cur + coins[c], count + 1, &res)
        } else {
            coinChanges(coins, amount, start + 1, cur, count, &res)
        }
    }
}

coinChanges(coins, amount)
