let money = 500

func buy(products: [String], money: Int) -> (currentMoney: Int, boughtProducts: [String]) {
    let prices = ["water": 120, "cola": 160, "coffee": 150]
    var boughtProducts: [String] = []
    var currentMoney = money
    
    for product in products {
        guard let price = prices[product] else { continue }
        guard currentMoney >= price else { continue }
        
        currentMoney -= price
        boughtProducts.append(product)
    }
    return (currentMoney, boughtProducts)
}

let result = buy(products: ["water", "soda", "cola", "coffee", "water"], money: money)
print("\(result.currentMoney)円 / \(result.boughtProducts)")
