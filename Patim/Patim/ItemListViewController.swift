//
//  ItemListViewController.swift
//  Patim
//
//  Created by 伊藤瞭汰 on 2026/11/21.
//

import UIKit

final class ItemListViewController: UIViewController {
    private let reusableCell = "ItemCell"
    private let items: [ClothingItem] = [
        ClothingItem(name: "白Tシャツ", brand: "UNIQLO", category: .tops, isReusableBeforeWash: false),
        ClothingItem(name: "デニム", brand: "Levi's", category: .pants, isReusableBeforeWash: true),
        ClothingItem(name: "ニット", brand: "Cornier", category: .tops, isReusableBeforeWash: true),
        ClothingItem(name: "MA-1", brand: "Entire Studios", category: .outer, isReusableBeforeWash: true),
        ClothingItem(name: "靴下", brand: "UNIQLO", category: .other, isReusableBeforeWash: false),
    ]
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "アイテム一覧"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusableCell)
        tableView.dataSource = self
    }
}

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCell, for: indexPath)
        var config = cell.defaultContentConfiguration()
        cell.textLabel?.numberOfLines=0
        config.text = "\(content.name)\n\(content.category.displayName)\(content.isReusableBeforeWash ? "・毎回は洗わない" : "")"
        cell.contentConfiguration = config
        return cell
    }
}
