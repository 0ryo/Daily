struct Product {
    let name: String
    let price: Int
    var stock: Int
    
    // method1: 指定された個数の商品を販売する
    mutating func sell(quantity: Int) -> Int? {
        guard quantity > 0 else { return nil }
        guard quantity <= stock else { return nil }
        stock -= quantity
        return price * quantity
    }
    // method2: 指定された個数だけ在庫を追加する
    mutating func restock(quantity: Int) {
        guard quantity > 0 else { return }
        stock += quantity
    }
}

var product1 = Product(name: "keyboard", price: 5000, stock: 5)
let price = product1.sell(quantity:2)
print("価格: \(price)円")
print("Product1の在庫: \(product1.stock)")

product1.restock(quantity: 10)
print("Product1の在庫: \(product1.stock)")
