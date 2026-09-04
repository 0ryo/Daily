let money = 500
var stockByProduct = ["water": 2, "cola": 2, "coffee": 1]

func buy(money: Int, orders: [String], stockByProduct: [String: Int]) -> (currentMoney: Int, boughtProducts: [String], stockByProduct: [String: Int]) {
    let priceByProduct = ["water": 120, "cola": 160, "coffee": 150]
    
    var stockByProduct = stockByProduct
    var currentMoney = money
    var boughtProducts: [String] = []
    
    for product in orders {
        guard let price = priceByProduct[product] else { continue }
        guard currentMoney >= price else { continue }
        guard let stockCount = stockByProduct[product] else { continue }
        guard stockCount > 0 else { continue }
        
        currentMoney -= price
        boughtProducts.append(product)
        stockByProduct[product] = stockCount - 1
    }
    return (currentMoney, boughtProducts, stockByProduct)
}

let results1 = buy(money: money, orders: ["cola", "water", "apple"], stockByProduct: stockByProduct)
print("残金：\(results1.currentMoney)円、 購入した商品：\(results1.boughtProducts), 商品在庫：\(results1.stockByProduct)")

let results2 = buy(money: results1.currentMoney, orders: ["cola", "water", "apple", "coffee", "water"], stockByProduct: results1.stockByProduct)
print("残金：\(results2.currentMoney)円、 購入した商品：\(results2.boughtProducts), 商品在庫：\(results2.stockByProduct)")
