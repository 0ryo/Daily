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
        let result = shippingList.add(name: name, address: address, memo: memo) // todo: あとで結果をラベルに適用する関数を作る。
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

enum inputState {
    case OK
    case emptyName
    case longName
    case emptyAddress
    case longAddress
    case longMemo
}

struct ShippingAddress {
    let name: String
    let address: String
    let memo: String
}

struct ShippingAddressForm {
    var shippingList: [ShippingAddress]
    private func validationInput(name: String, address: String, memo: String) -> inputState {
        guard !name.isEmpty else { return .emptyName }
        guard name.count > 1 && name.count < 21 else { return .longName}
        guard !address.isEmpty else { return .emptyAddress }
        guard address.count > 1 && address.count < 40 else { return .longAddress }
        guard memo.count < 30 else { return .longMemo }
        return .OK
    }
    
    mutating func add(name: String, address: String, memo: String) -> inputState {
        let result = validationInput(name: name, address: address, memo: memo)
        guard result == .OK else { return result }
        shippingList.append(ShippingAddress(name: name, address: address, memo: memo))
        return result
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
