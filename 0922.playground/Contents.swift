struct Product {
    let name: String
    let price: Int
}

struct ShoppingCart {
    var products: [Product]
    
    mutating func add(product: Product) {
        products.append(product)
    }
    
    mutating func remove(name: String) -> Bool {
        if let index = products.firstIndex(where: { product in
            product.name == name
        }) {
            products.remove(at: index)
            return true
        } else {
            return false
        }
    }
    
    var totalPrice: Int {
        products.reduce(0) { $0 + $1.price }
    }
    
    var productCount: Int {
        products.count
    }
    
    var mostExpensiveProduct: Product? {
        products.max(by: { $0.price < $1.price })
    }
}

let product1 = Product(name: "product1", price: 30)
let product2 = Product(name: "product2", price: 9)
let product3 = Product(name: "product3", price: 34)
let product4 = Product(name: "product4", price: 21)
let product5 = Product(name: "product5", price: 300)

var shoppingCart1 = ShoppingCart(products: [product1, product2, product3])
shoppingCart1.add(product: product4)
print(shoppingCart1)
print(shoppingCart1.mostExpensiveProduct)
print(shoppingCart1.totalPrice)
print(shoppingCart1.productCount)

shoppingCart1.add(product: product5)
print(shoppingCart1)
print(shoppingCart1.mostExpensiveProduct)
print(shoppingCart1.totalPrice)
print(shoppingCart1.productCount)

shoppingCart1.remove(name: "product1")
print(shoppingCart1)
print(shoppingCart1.mostExpensiveProduct)
print(shoppingCart1.totalPrice)
print(shoppingCart1.productCount)
