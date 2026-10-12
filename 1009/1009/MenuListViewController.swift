//
//  MenuListViewController.swift
//  1009
//
//  Created by 伊藤瞭汰 on 2026/10/09.
//

import UIKit

class MenuListViewController: UIViewController {
    
    let menuItems: [MenuItem] = [
        MenuItem(name: "コーヒー", price: 450),
        MenuItem(name: "サンドイッチ", price: 600),
        MenuItem(name: "クッキー", price: 300),
    ]
    
    @IBOutlet private weak var menuCountLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if menuItems.isEmpty {
            menuCountLabel.text = "メニューはありません"
        } else {
            menuCountLabel.text = "メニュー：\(menuItems.count)品"
        }

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItemCell")
        tableView.dataSource = self
    }
}

struct MenuItem {
    let name: String
    let price: Int
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

extension MenuListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = menuItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(item.name)：\(item.price)円"
        cell.contentConfiguration = content
        return cell
    }
}
