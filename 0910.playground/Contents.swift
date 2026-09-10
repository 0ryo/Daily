let orders = [
    ("keyboard", 5000, true),
    ("mouse", 3000, true),
    ("keyboard", 5000, false),
    ("cable", 1500, true),
    ("mouse", 3000, false),
    ("keyboard", 5000, true),
    ("monitor", 20000, true),
    ("cable", 1500, true),
    ("mouse", 3000, true)
]

func calculate(_ orders: [(String, Int, Bool)]) -> (totalSales: Int, salesByProduct: [String: Int], cancelledCount: Int, topSalesProduct: String?) {
    var totalSales: Int = 0
    var salesByProduct: [String: Int] = [:]
    var cancelledCount: Int = 0
    
    
    for order in orders {
        let (product, price, status) = order
        
        if status == false {
            cancelledCount += 1
            continue
        }
        
        salesByProduct[product, default: 0] += price
        totalSales += price
    }
    
    let topSalesProduct = salesByProduct.max{ $0.value < $1.value }?.key
    
    return (totalSales, salesByProduct, cancelledCount, topSalesProduct)
}

let result = calculate(orders)
print(result.totalSales)
print(result.salesByProduct)
print(result.cancelledCount)
print(result.topSalesProduct)
