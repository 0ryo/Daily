//
//  RegisterCustomerViewController.swift
//  1018
//
//  Created by 伊藤瞭汰 on 2026/10/18.
//

import UIKit

class RegisterCustomerViewController: UIViewController {
    
    var customersList = CustomersList(customers: [])
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nameStatusText: UILabel!
    @IBOutlet private weak var ageText: UILabel!
    @IBOutlet private weak var ageStepper: UIStepper!
    @IBOutlet private weak var notificationText: UILabel!
    @IBOutlet private weak var isNotificationSwitch: UISwitch!
    @IBOutlet private weak var registerStatusText: UILabel!
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        ageText.text = "\(Int(sender.value))"
    }
    @IBAction func notificationSwitchDidChange(_ sender: UISwitch) {
        notificationText.text = isNotificationSwitch.isOn ? "ON":"OFF"
    }
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        let age = ageText.text ?? ""
        let ageInt = Int(age) ?? 0
        let result = customersList.add(name: name, age: ageInt, isNotification: isNotificationSwitch.isOn)
        print(result)
        updateView()
    }
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RegisteredCustomersCell")
        tableView.dataSource = self
    }
    
    private func updateView() {
        tableView.reloadData()
        
        ageStepper.value = 20
        isNotificationSwitch.isOn = false
        
        nameTextField.text = ""
        ageText.text = "20"
        notificationText.text = "OFF"
    }
}

struct customer {
    let name: String
    let age: Int
    var isNotification: Bool
}

struct CustomersList {
    var customers: [customer]
    
    mutating func add(name: String, age: Int, isNotification: Bool) -> Bool {
        // 引数の検証
        guard !name.isEmpty else { return false }
        let conflict = customers.contains(where: { $0.name == name })
        guard !conflict else { return false }
        guard age >= 18 && age <= 99 else { return false }
        
        // 追加処理
        customers.append(customer(name: name, age: age, isNotification: isNotification))
        return true
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
