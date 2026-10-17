//
//  ShipmentListViewController.swift
//  1015
//
//  Created by 伊藤瞭汰 on 2026/10/15.
//

import UIKit

class ShipmentListViewController: UIViewController {
    
    var shippingList = ShippingList(packages: [
        Package(name: "書籍", status: .waiting),
        Package(name: "衣類", status: .waiting),
        Package(name: "食器", status: .waiting),
    ])
    
    @IBOutlet private weak var shipStatusLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBAction func resetButtonDidTap(_ sender: UIButton) {
        shippingList.resetAll()
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShipmentListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updateView() {
        tableView.reloadData()
        
        if shippingList.packages.count == 0 {
            shipStatusLabel.text = "荷物がありません"
        } else {
            shipStatusLabel.text = "発送済み: \(shippingList.shippedCount)/\(shippingList.packages.count)"
        }
        
    }
}

extension ShipmentListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shippingList.packages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = shippingList.packages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShipmentListCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        
        switch content.status {
        case .waiting:
            config.text = "\(content.name): 未梱包"
        case .packed:
            config.text = "\(content.name): 梱包済み"
        case .shipped:
            config.text = "\(content.name): 発送済み"
        }
        
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = shippingList.advance(index: indexPath.row)
        updateView()
    }
}

enum ShipmentStatus {
    case waiting
    case packed
    case shipped
}

struct Package {
    let name: String
    var status: ShipmentStatus
}

struct ShippingList {
    var packages: [Package]
    var shippedCount: Int {
        var count = 0
        for package in packages {
            if package.status == .shipped {
                count += 1
            }
        }
        return count
    }
    
    mutating func advance(index: Int) -> Bool {
        guard index >= 0 && index < packages.count else { return false }
        switch packages[index].status {
        case .waiting:
            packages[index].status = .packed
            return true
        case .packed:
            packages[index].status = .shipped
            return true
        case .shipped:
            return false
        }
    }
    
    mutating func resetAll() {
        for index in packages.indices {
            packages[index].status = .waiting
        }
    }
}
