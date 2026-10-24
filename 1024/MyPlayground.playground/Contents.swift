enum sellError: Error {
    case outOfStock
    case notExist
    case moneyNotEnough(Int)
}

struct Product {
    let name: String
    let price: Int
    var stock: Int
}

struct Vendor {
    var products: [Product]
    
    mutating func sell(name: String, money: Int) throws -> Int{
        guard var index = products.firstIndex(where: { $0.name == name }) else {
            throw sellError.notExist
        }
        var money = money
        if products[index].stock < 1 {
            throw sellError.outOfStock
        } else if money < products[index].price {
            throw sellError.moneyNotEnough(products[index].price - money)
        } else {
            products[index].stock -= 1
            money -= products[index].price
        }
        return money
    }
}

var vendingMachine = Vendor(products: [
    Product(name: "茶", price: 120, stock: 2),
    Product(name: "水", price: 120, stock: 1),
    Product(name: "コーラ", price: 120, stock: 0)
])

// 1
do {
    let change = try vendingMachine.sell(name: "茶", money: 150)
    print("成功！お釣りは\(change)円です。")
} catch sellError.notExist{
    print("商品がありません。")
} catch sellError.outOfStock {
    print("商品が売り切れです。")
} catch sellError.moneyNotEnough(let money) {
    print("お金が\(money)円足りません。")
}
// 2
do {
    let change = try vendingMachine.sell(name: "茶", money: 100)
    print("成功！お釣りは\(change)円です。")
} catch sellError.notExist{
    print("商品がありません。")
} catch sellError.outOfStock {
    print("商品が売り切れです。")
} catch sellError.moneyNotEnough(let money) {
    print("お金が\(money)円足りません。")
}
// 3
do {
    let change = try vendingMachine.sell(name: "コーラ", money: 200)
    print("成功！お釣りは\(change)円です。")
} catch sellError.notExist{
    print("商品がありません。")
} catch sellError.outOfStock {
    print("商品が売り切れです。")
} catch sellError.moneyNotEnough(let money) {
    print("お金が\(money)円足りません。")
}
// 4
do {
    let change = try vendingMachine.sell(name: "ジュース", money: 200)
    print("成功！お釣りは\(change)円です。")
} catch sellError.notExist{
    print("商品がありません。")
} catch sellError.outOfStock {
    print("商品が売り切れです。")
} catch sellError.moneyNotEnough(let money) {
    print("お金が\(money)円足りません。")
}
// 5
do {
    let change = try vendingMachine.sell(name: "茶", money: 120)
    print("成功！お釣りは\(change)円です。")
} catch sellError.notExist{
    print("商品がありません。")
} catch sellError.outOfStock {
    print("商品が売り切れです。")
} catch sellError.moneyNotEnough(let money) {
    print("お金が\(money)円足りません。")
}
// 6
do {
    let change = try vendingMachine.sell(name: "茶", money: 500)
    print("成功！お釣りは\(change)円です。")
} catch sellError.notExist{
    print("商品がありません。")
} catch sellError.outOfStock {
    print("商品が売り切れです。")
} catch sellError.moneyNotEnough(let money) {
    print("お金が\(money)円足りません。")
}
// 7
let change = try? vendingMachine.sell(name: "水", money: 50)
print(change)
