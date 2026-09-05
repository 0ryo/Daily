let money = 1000
let orders = ["keyboard", "cable", "mouse", "monitor", "mouse"]

func checkout(money: Int, orders: [String]) -> (currentMoney: Int, stockByProduct: [String: Int], purchasedProducts: [String], failedProducts: [String]){
    let priceByProduct = ["keyboard": 500, "mouse": 300, "cable": 200]
    var stockByProduct = ["keyboard": 1, "mouse": 2, "cable": 0]
    var currentMoney = money
    var purchasedProducts: [String] = []
    var failedProducts: [String] = []
    
    for order in orders {
        // 商品がpriceByProductに存在する
        guard let price = priceByProduct[order] else {
            failedProducts.append(order)
            continue
        }
        
        // 商品がstockByProductに存在する
        guard let stock = stockByProduct[order] else {
            failedProducts.append(order)
            continue
        }
        
        // 在庫が1個以上ある
        guard stock >= 1 else {
            failedProducts.append(order)
            continue
        }
        
        // 所持金が価格以上ある
        guard currentMoney >= price else {
            failedProducts.append(order)
            continue
        }
        
        currentMoney -= price // お金を減らす
        stockByProduct[order] = stock - 1// 在庫を1減らす
        purchasedProducts.append(order) // 購入済み商品に追加する
    }
    return (currentMoney, stockByProduct, purchasedProducts, failedProducts)
}

let result = checkout(money: money, orders: orders)
print("残金：\(result.currentMoney)")
print("購入した商品：\(result.purchasedProducts)")
print("購入失敗した商品：\(result.failedProducts)")
