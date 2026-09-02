var money = 500

func buy(product: String, money: Int) -> Int{
    let price: Int
    
    switch product {
    case "water":
        price = 120
    case "cola":
        price = 160
    case "coffee":
        price = 150
    default:
        print("その商品はありません")
        return money // early returnという！　ここまできたなら商品は必ず存在するという前提で以下のコードを読める。
    }
    
    if canBuy(money, price: price) {
        let balance = money - price
        print("\(product)を購入しました")
        print("残金:\(balance)円")
        return balance
    } else {
        print("残金が足りません")
        return money
    }
}

func canBuy(_ money: Int, price: Int) -> Bool {
    return money >= price
}

money = buy(product: "cola", money: money)
money = buy(product: "water", money: money)
money = buy(product: "coffee", money: money)
money = buy(product: "aaa", money: money)

