struct Order {
    let product: String
    let quantity: Int
    let isShipped: Bool
}


let orders = [
    Order(product: "keyboard", quantity: 2, isShipped: false),
    Order(product: "mouse", quantity: 1, isShipped: true),
    Order(product: "keyboard", quantity: 3, isShipped: false),
    Order(product: "monitor", quantity: 1, isShipped: false),
    Order(product: "mouse", quantity: 2, isShipped: false),
    Order(product: "keyboard", quantity: 1, isShipped: true),
]

func analyzeOrders(_ orders: [Order]) -> (unshippedQuantity: Int, quantityByProduct: [String: Int], mostUnshippedProduct: String?) {
    var unshippedQuantity: Int = 0 // 未発送商品のquantityの合計
    var quantityByProduct: [String: Int] = [:]
    let mostUnshippedProduct: String?
    
    for order in orders {
        if !order.isShipped {
            unshippedQuantity += order.quantity
            quantityByProduct[order.product, default: 0] += order.quantity
        }
    }
    
    mostUnshippedProduct = quantityByProduct.max{ $0.value < $1.value}?.key
    
    return (unshippedQuantity, quantityByProduct, mostUnshippedProduct)
}

let result = analyzeOrders(orders)
print(result.unshippedQuantity)
print(result.quantityByProduct)
print(result.mostUnshippedProduct)
