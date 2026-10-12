//
//  RentalListViewController.swift
//  1012
//
//  Created by 伊藤瞭汰 on 2026/10/12.
//

import UIKit

class RentalListViewController: UIViewController {
    
    var rentalList = RentalList(items: [
        RentalItem(name: "傘", availableCount: 2, totalCount: 2),
        RentalItem(name: "充電器", availableCount: 1, totalCount: 1),
        RentalItem(name: "ペン", availableCount: 3, totalCount: 3)
    ])
    
    @IBOutlet private weak var rentLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction func tapBack(_ sender: UIButton) {
        rentalList.returnAll()
        update()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RentalItemCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func update() {
        tableView.reloadData()
        
        if rentalList.items.isEmpty {
            rentLabel.text = "備品がありません"
        } else {
            rentLabel.text = "貸出中: \(rentalList.totalRentalCount)"
        }
    }
}

struct RentalItem {
    let name: String
    var availableCount: Int
    let totalCount: Int
    var rentalable: Bool {
        return availableCount > 0
    }
}

struct RentalList {
    var items: [RentalItem]
    var totalRentalCount: Int {
        var count = 0
        for item in items {
            count += item.totalCount - item.availableCount
        }
        return count
    }
    
    mutating func borrow(index: Int) -> Bool {
        guard index >= 0 && index < items.count else { return false }
        guard items[index].rentalable else { return false }
        items[index].availableCount -= 1
        return true
    }
    
    mutating func returnAll() {
        for index in items.indices {
            items[index].availableCount = items[index].totalCount
        }
    }
}

extension RentalListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentalList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = rentalList.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentalItemCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name) \(content.availableCount)/\(content.totalCount) \(content.rentalable ? "貸出可能":"貸出不可")"
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = rentalList.borrow(index: indexPath.row)
        update()
    }
}
