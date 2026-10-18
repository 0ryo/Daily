//
//  RegisterCustomerViewController.swift
//  1018
//
//  Created by 伊藤瞭汰 on 2026/10/18.
//

import UIKit

class RegisterCustomerViewController: UIViewController {
    private var resultTimer: Timer?
    
    var customersList = CustomersList(customers: [])
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nameStatusText: UILabel!
    @IBOutlet private weak var ageText: UILabel!
    @IBOutlet private weak var ageStepper: UIStepper!
    @IBOutlet private weak var notificationText: UILabel!
    @IBOutlet private weak var isNotificationSwitch: UISwitch!
    @IBOutlet private weak var registerStatusText: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        ageText.text = "\(Int(sender.value))"
    }
    @IBAction func notificationSwitchDidChange(_ sender: UISwitch) {
        notificationText.text = isNotificationSwitch.isOn ? "ON":"OFF"
    }
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        let rawName = nameTextField.text ?? ""
        let name = rawName.trimmingCharacters(in: .whitespacesAndNewlines)
        let age = Int(ageStepper.value)
        let result = customersList.add(name: name, age: age, isNotification: isNotificationSwitch.isOn)
        if result == .OK {
            nameTextField.text = ""
            registerStatusText.text = "登録しました。"
            self.view.endEditing(true)
        } else {
            registerStatusText.text = "登録できませんでした。: \(result)"
        }
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        nameTextField.addTarget(self, action: #selector(nameFieldDidChange), for: .editingChanged)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RegisteredCustomersCell")
        tableView.dataSource = self
    }
    
    private func updateView() {
        tableView.reloadData()
        resultTimer?.invalidate()
        
        ageStepper.value = 20
        isNotificationSwitch.isOn = false
        registerButton.isEnabled = false
        
        ageText.text = "20"
        notificationText.text = "OFF"
        
        nameStatusText.isHidden = false
        registerStatusText.isHidden = false
        
        resultTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.registerStatusText.isHidden = true
        }
    }
    
    @objc func nameFieldDidChange(_ nameField: UITextField) {
        let rawName = nameTextField.text ?? ""
        let name = rawName.trimmingCharacters(in: .whitespacesAndNewlines)
        let age = Int(ageStepper.value)
        let result = customersList.validationInput(name: name, age: age, isNotification: isNotificationSwitch.isOn)
        switch result {
        case .OK, .ageRange:
            nameStatusText.isHidden = true
            registerButton.isEnabled = true
        case .nameIsEmpty:
            nameStatusText.text = "名前を入力してください。"
            nameStatusText.isHidden = false
            registerButton.isEnabled = false
        case .nameConflict:
            nameStatusText.text = "同じ名前が使われています。"
            nameStatusText.isHidden = false
            registerButton.isEnabled = false
        case .nameOverLength:
            nameStatusText.text = "名前は1〜20文字で入力してください。"
            nameStatusText.isHidden = false
            registerButton.isEnabled = false
        }
    }
}

enum inputType: String {
    case nameIsEmpty
    case nameConflict
    case nameOverLength
    case ageRange
    case OK
}

struct customer {
    let name: String
    let age: Int
    var isNotification: Bool
}

struct CustomersList {
    var customers: [customer]
    
    func validationInput(name: String, age: Int, isNotification: Bool) -> inputType {
        guard !name.isEmpty else { return .nameIsEmpty }
        let conflict = customers.contains(where: { $0.name == name })
        guard !conflict else { return .nameConflict }
        guard name.count >= 1 && name.count <= 20 else { return .nameOverLength }
        guard age >= 18 && age <= 99 else { return .ageRange }
        return .OK
    }
    
    mutating func add(name: String, age: Int, isNotification: Bool) -> inputType {
        // 引数の検証
        let result = validationInput(name: name, age: age, isNotification: isNotification)
        guard result == .OK else { return result }
        
        // 追加処理
        customers.append(customer(name: name, age: age, isNotification: isNotification))
        return result //.OKが返る
    }
}

extension RegisterCustomerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customersList.customers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = customersList.customers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisteredCustomersCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "名前: \(content.name) 年齢: \(content.age) 通知: \(content.isNotification ? "ON":"OFF")"
        cell.contentConfiguration = config
        return cell
    }
}

extension RegisterCustomerViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
