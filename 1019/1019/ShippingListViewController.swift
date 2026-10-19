//
//  ShippingListViewController.swift
//  1019
//
//  Created by 伊藤瞭汰 on 2026/10/19.
//

import UIKit

class ShippingListViewController: UIViewController {
    
    var shippingList = ShippingAddressForm(shippingList: [])

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var memoField: UITextField!
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        let rawName = nameField.text ?? ""
        let rawAdress = nameField.text ?? ""
        let rawMemo = nameField.text ?? ""
        let name = rawName.trimmingCharacters(in: .whitespacesAndNewlines)
        let address = rawAdress.trimmingCharacters(in: .whitespacesAndNewlines)
        let memo = rawMemo.trimmingCharacters(in: .whitespacesAndNewlines)
        _ = shippingList.add(name: name, address: address, memo: memo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShippingListCell")
        tableView.dataSource = self
    }
    
    private func updateView() {
        tableView.reloadData()
        
        nameField.text = ""
        addressField.text = ""
        memoField.text = ""
    }
}

struct ShippingAddress {
    let name: String
    let address: String
    let memo: String
}

struct ShippingAddressForm {
    var shippingList: [ShippingAddress]
    
    mutating func add(name: String, address: String, memo: String) -> Bool {
        shippingList.append(ShippingAddress(name: name, address: address, memo: memo))
        return true
    }
}

extension ShippingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shippingList.shippingList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = shippingList.shippingList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingListCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name) \(content.address) メモ: \(content.memo)"
        cell.contentConfiguration = config
        return cell
    }
}
