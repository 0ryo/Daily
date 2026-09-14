let orders = [
    ("keyboard", 5000, 2, false),
    ("mouse", 3000, 1, false),
    ("keyboard", 5000, 1, true),
    ("monitor", 20000, 1, false),
    ("mouse", 3000, 3, false),
    ("cable", 1500, 2, true)
]

func analyzeOrders(_ orders: [(String, Int, Int, Bool)]) -> (totalSales: Int, salesByProduct: [String: Int], topSalesProduct: String?) {
    var totalSales = 0
    var salesByProduct: [String: Int] = [:]
    
    for order in orders {
        let (product, price, amount, isReturn) = order
        guard !isReturn else { continue }
        totalSales += price * amount
        salesByProduct[product, default: 0] += amount
    }
    let topSalesProduct = salesByProduct.max{ $0.value < $1.value}?.key
    
    return (totalSales, salesByProduct, topSalesProduct)
}

let result = analyzeOrders(orders)
print(result.totalSales)
print(result.salesByProduct)
print(result.topSalesProduct)
