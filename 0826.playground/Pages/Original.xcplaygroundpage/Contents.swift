// サイコロポーカー：5個のサイコロで役を判定する
var hand: [Int] = []

// 1〜6の数字をランダムに生成 × 5
for _ in 0..<5 {
    let randomNumber = Int.random(in: 1...6)
    hand.append(randomNumber)
}

var count1 = 0
var count2 = 0
var count3 = 0
var count4 = 0
var count5 = 0
var count6 = 0

// 判定：それぞれの数字が何回出たかを数える
for number in hand {
    if number == 1 {
        count1 += 1
    } else if number == 2 {
        count2 += 1
    } else if number == 3 {
        count3 += 1
    } else if number == 4 {
        count4 += 1
    } else if number == 5 {
        count5 += 1
    } else if number == 6 {
        count6 += 1
    }
}

let counts = [count1, count2, count3, count4, count5, count6]

print(hand)
print(counts)

if counts.contains(5) {
    print("Five of a Kind")
} else if counts.contains(4) {
    print("Four of a Kind")
} else if counts.contains(3) {
    print("Three of a Kind")
} else if counts.contains(2) {
    print("Two of a Kind")
} else {
    print("No Pair")
}


