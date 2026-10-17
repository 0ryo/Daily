//
//  ShoppingListViewController.swift
//  1016
//
//  Created by 伊藤瞭汰 on 2026/10/16.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    private var resultTimer: Timer?
    var shoppingList = ShoppingList(items: [])
    
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var quantityField: UITextField!
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        let name = nameField.text ?? ""
        let quantity = quantityField.text ?? ""
        guard let intQuantity = Int(quantity.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            updateView(false)
            return
        }
        let result = shoppingList.add(name: name, quantity: intQuantity)
        if result {
            nameField.text = ""
            quantityField.text = ""
            self.view.endEditing(true)
        }
        
        tableView.reloadData()
        updateView(result)
    }
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShoppingListCell")
        tableView.dataSource = self
    }
    
    private func updateView(_ result: Bool) {
        resultTimer?.invalidate()
        
        resultLabel.text = result ? "追加しました":"商品名と個数を確認してください"
        resultLabel.isHidden = false
        
        resultTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.resultLabel.isHidden = true
        }
    }
}

struct ShoppingItem {
    let name: String
    var quantity: Int
}

struct ShoppingList {
    var items: [ShoppingItem]
    mutating func add(name: String, quantity: Int) -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return false }
        guard quantity > 0 && quantity < 100 else { return false }
        
        items.append(ShoppingItem(name: trimmedName, quantity: quantity))
        return true
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = shoppingList.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name)：\(content.quantity)個"
        
        cell.contentConfiguration = config
        return cell
    }
}
