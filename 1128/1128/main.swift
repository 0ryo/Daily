//
//  main.swift
//  1128
//
//  Created by 伊藤瞭汰 on 2026/11/28.
//

// (String, Int) -> String
// String と Int を受け取って、String を返す処理

// ((Int) -> Void)?
// Intを受け取って何も返さない処理。ただし、処理そのものがないかもしれない処理

// (Int) -> () -> Int
// Int を受け取って、何も受け取らない関数を返す。その関数が Int を返す処理。

let isEven: (Int) -> Bool = { (num: Int) -> Bool in
    return num.isMultiple(of: 2)
}
print(isEven(4))
print(isEven(7))

let isEvenShort: (Int) -> Bool = { num in
    num.isMultiple(of: 2)
}
print(isEvenShort(4))
print(isEvenShort(7))

let isEvenShortest: (Int) -> Bool = { $0.isMultiple(of: 2) }
print(isEvenShortest(4))
print(isEvenShortest(7))

func repeatTwice(_ action: () -> Void) {
    action()
    action()
}

func applyToTen(_ transform: (Int) -> Int) -> Int {
    transform(10)
}

repeatTwice { print("こんにちは") }

let a = applyToTen({ (x: Int) -> Int in
    x + 3
})
print(a)

let array1 = [1, 2, 3]
let newArray1 = array1.map{ $0 * 10 }
print(newArray1)

let array2 = ["いぬ", "ねこ", "うさぎ"]
let newArray2 = array2.filter{ $0.count < 3 }
print(newArray2)
