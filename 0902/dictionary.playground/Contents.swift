// Dictionary使ってみるかそんな言うんやったら

var money = 500

func buy(money: Int, product: String) -> Int {
    let prices = ["water": 120, "cola": 160, "coffee": 150]
    guard let price = prices[product] else { return money }
    return money >= price ? money - price : money
}

money = buy(money: money, product: "water")
money = buy(money: money, product: "cola")
money = buy(money: money, product: "coffee")
money = buy(money: money, product: "aaaa")
