let orders = [
    ("keyboard", 5000),
    ("mouse", 3000),
    ("keyboard", 5000),
    ("cable", 1500),
    ("mouse", 3000),
    ("keyboard", 5000),
    ("monitor", 20000),
    ("cable", 1500),
    ("mouse", 3000)
]

func analyzeOrders(_ orders: [(String, Int)]) -> (Int, [String: Int], String?){
    var totalSales = 0 // 全注文の売り上げ合計
    var countByProduct: [String: Int] = [:] // 商品ごとの注文回数
    
    for order in orders {
        let (product, price) = order
        totalSales += price
        countByProduct[product, default: 0] += 1
    }
    
    let mostPopularProduct = countByProduct.max{ $0.value < $1.value }?.key // 最も多く注文された商品
    
    return (totalSales, countByProduct, mostPopularProduct)
    
}

let result = analyzeOrders(orders)
print(result)
