//
//  main.swift
//  1126
//
//  Created by 伊藤瞭汰 on 2026/11/26.
//

enum Drink: CaseIterable {
    case water
    case tea
    case coffee
    
    var displayName: String {
        switch self {
        case .water: return "水"
        case .tea: return "お茶"
        case .coffee: return "コーヒー"
        }
    }
    
    var price: Int {
        switch self {
        case .water: return 100
        case .tea: return 130
        case .coffee: return 150
        }
    }
}

struct DrinkButton {
    let title: String
    let onPress: (Int) -> Void
    
    func press(insertedMoney: Int) {
        onPress(insertedMoney)
    }
}

class VendingMachine {
    var buttons: [DrinkButton] = []
    var selectedDrink: Drink? = nil
    
    func makeButtons() {
        let allDrinks: [DrinkButton] = Drink.allCases.map { drink in
            DrinkButton(title: drink.displayName, onPress: { [weak self] insertedMoney in
                self?.selectedDrink = drink
                if insertedMoney >= drink.price {
                    print("\(drink.displayName)を選びました。お釣りは\(insertedMoney - drink.price)円です。")
                }
            })
        }
        buttons.append(contentsOf: allDrinks)
    }
    
    deinit {
        print("VendingMachineを解放しました")
    }
}

do {
    let vendingMachine = VendingMachine()
    vendingMachine.makeButtons()
    let buttonTitle = vendingMachine.buttons.map { button in
        button.title
    }
    print(buttonTitle)

    vendingMachine.buttons[1].press(insertedMoney: 160)
    print(vendingMachine.selectedDrink?.displayName ?? "なし")
}

