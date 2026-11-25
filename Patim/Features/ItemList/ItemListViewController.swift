//
//  ItemListViewController.swift
//  Patim
//
//  Created by 伊藤瞭汰 on 2026/11/21.
//

import UIKit

final class ItemListViewController: UIViewController {
    private let cellIdentifier = "ItemCell"
    private var items: [ClothingItem] = [
        ClothingItem(name: "白Tシャツ", brand: "UNIQLO", category: .tops, isReusableBeforeWash: false),
        ClothingItem(name: "デニム", brand: "Levi's", category: .pants, isReusableBeforeWash: true),
        ClothingItem(name: "ニット", brand: "Cornier", category: .tops, isReusableBeforeWash: true),
        ClothingItem(name: "MA-1", brand: "Entire Studios", category: .outer, isReusableBeforeWash: true),
        ClothingItem(name: "靴下", brand: "UNIQLO", category: .other, isReusableBeforeWash: false),
    ].compactMap{ $0 }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "アイテム一覧"
        let registerButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(didTapRegister))
        navigationItem.rightBarButtonItem = registerButton
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
    }
    @objc private func didTapRegister() {
        let itemRegisterViewController = ItemRegisterViewController()
        itemRegisterViewController.delegate = self
        navigationController?.pushViewController(itemRegisterViewController, animated: true)
    }
}

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var config = cell.defaultContentConfiguration()
        cell.textLabel?.numberOfLines=0
        
        let washNote = item.isReusableBeforeWash ? "・毎回は洗わない" : ""
        config.text = "\(item.name)"
        config.secondaryText = (item.category.displayName) + (washNote)
        cell.contentConfiguration = config
        return cell
    }
}

extension ItemListViewController: ItemRegisterViewControllerDelegate {
    func itemRegisterViewController(_ viewController: ItemRegisterViewController, didRegister item: ClothingItem) {
        items.append(item)
        tableView.reloadData()
    }
}
