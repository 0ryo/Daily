//
//  PackingListViewController.swift
//  1008
//
//  Created by 伊藤瞭汰 on 2026/10/08.
// 1. ViewControllerからTableViewを使えるようにする。
// 2. TableViewで使うためのデータを用意する。
// 3. 用意したデータをTableViewDataSourceに渡す。
// 4. items[indexPath.row]のデータを、Cellに表示する！
// 5. セルの再利用をする。

import UIKit

class PackingListViewController: UIViewController {
    
    private let items: [PackingItem] = [
        PackingItem(name: "水筒", quantity: 1),
        PackingItem(name: "タオル", quantity: 2),
        PackingItem(name: "ノート", quantity: 1),
    ]
    
    @IBOutlet private weak var itemCountLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView! // TableViewも、他のUIと同じように@/IBOutletでいいんだ!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if items.isEmpty {
            itemCountLabel.text = "持ち物はありません。"
        } else {
            itemCountLabel.text = "持ち物: \(items.count)種類"
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PackingItemCell") // PackingItemCellという名前でセルを頼まれたら、標準のUITableViewCellを使ってください。
        tableView.dataSource = self // UITableViewDataSourceへViewControllerが回答するメソッドを用意しただけではTableViewが実際に誰に問い合わせたらいいかわからないため、ここで明記
    }
}

// 複数の場所から同じインスタンスを共有して変更する必要がないため、struct。
struct PackingItem {
    let name: String
    let quantity: Int
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
}

extension PackingListViewController: UITableViewDataSource {
    // UITableViewDataSourceは、2つの関数を必ず作らないといけないプロトコル。
    // 1つ目の関数：何行ありますか？を知りたい。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // 2つ目の関数：この行にはどのセルを表示しますか？を知りたい。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackingItemCell", for: indexPath) // ここにデータが入っていく。再利用可能な形で作る。
        var content = cell.defaultContentConfiguration() // このセル用の、標準的な表示設定を用意するという処理。
        
        content.text = "\(item.name) (\(item.quantity)個)"
        cell.contentConfiguration = content // ここでContent設定をcellに適用。
        
        return cell
    }
}
