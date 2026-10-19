//
//  ShippingListViewController.swift
//  1019
//
//  Created by 伊藤瞭汰 on 2026/10/19.
//

import UIKit

final class ShippingListViewController: UIViewController {
    
    private var resultTimer: Timer?
    var shippingList = ShippingAddressForm(addressList: [])
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var memoField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBAction func registerButtonDidTap(_ sender: AnyObject) {
        let rawName = nameField.text ?? ""
        let rawAddress = addressField.text ?? ""
        let rawMemo = memoField.text ?? ""
        let name = rawName.trimmingCharacters(in: .whitespacesAndNewlines)
        let address = rawAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let memo = rawMemo.trimmingCharacters(in: .whitespacesAndNewlines)
        let result = shippingList.add(name: name, address: address, memo: memo)
        
        updateView(result)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShippingListCell")
        tableView.dataSource = self
        nameField.delegate = self
        addressField.delegate = self
        memoField.delegate = self
    }
    
    private func updateView(_ result: InputState) {
        tableView.reloadData()
        
        switch result {
        case .ok:
            nameField.text = ""
            addressField.text = ""
            memoField.text = ""
            nameField.endEditing(true)
            addressField.endEditing(true)
            memoField.endEditing(true)
            alertLabel.isHidden = true
        case .emptyName:
            alertLabel.isHidden = false
            alertLabel.text = "名前を入力してください"
            showAlert()
        case .longName:
            alertLabel.isHidden = false
            alertLabel.text = "名前は1〜20文字で入力してください"
            showAlert()
        case .emptyAddress:
            alertLabel.isHidden = false
            alertLabel.text = "住所を入力してください"
            showAlert()
        case .longAddress:
            alertLabel.isHidden = false
            alertLabel.text = "住所は1〜40文字で入力してください"
            showAlert()
        case .longMemo:
            alertLabel.isHidden = false
            alertLabel.text = "配達メモは0〜30文字で入力してください"
            showAlert()
        }
    }
    
    private func showAlert() {
        resultTimer?.invalidate()
        resultTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.alertLabel.isHidden = true
        }
    }
}

enum InputState {
    case ok
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
    var addressList: [ShippingAddress]
    private func validationInput(name: String, address: String, memo: String) -> InputState {
        guard !name.isEmpty else { return .emptyName }
        guard name.count >= 1 && name.count <= 20 else { return .longName}
        guard !address.isEmpty else { return .emptyAddress }
        guard address.count >= 1 && address.count <= 40 else { return .longAddress }
        guard memo.count >= 0 && memo.count <= 30 else { return .longMemo }
        return .ok
    }
    
    mutating func add(name: String, address: String, memo: String) -> InputState {
        let result = validationInput(name: name, address: address, memo: memo)
        guard result == .ok else { return result }
        addressList.append(ShippingAddress(name: name, address: address, memo: memo))
        return result
    }
}

extension ShippingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shippingList.addressList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = shippingList.addressList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingListCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name) \(content.address) \(content.memo.isEmpty ? "":"メモ: \(content.memo)")"
        cell.contentConfiguration = config
        return cell
    }
}

extension ShippingListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.tag != 2 else {
            registerButtonDidTap(textField)
            return true
        }
        textField.resignFirstResponder()
        let nextTag = textField.tag + 1
        if let nextTextField = self.view.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}
