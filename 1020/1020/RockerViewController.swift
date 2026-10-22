//
//  RockerViewController.swift
//  1020
//
//  Created by 伊藤瞭汰 on 2026/10/20.
//

import UIKit

class RockerViewController: UIViewController {
    @IBOutlet private weak var digitLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var settingsButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!

    @IBAction func settingButtonDidTap(_ sender: UIButton) {
        let rawNum = textField.text ?? ""
        let num = rawNum.trimmingCharacters(in: .whitespacesAndNewlines)
        let result = settings(num)
        updateView(result)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButton.isEnabled = false
        updateView(false)
        
        textField.delegate = self
    }
    
    private func settings(_ num: String) -> Bool {
        guard let _ = Int(num) else { return false }
        guard num.count == 4 else { return false }
        textField.text = ""
        return true
    }
    
    private func updateView(_ result: Bool) {
        
        if textField.text?.count == 4 {
            digitLabel.text = "入力完了"
        } else {
            digitLabel.text = "現在の桁数: \(textField.text?.count ?? 0)"
        }
        
        if result {
            resultLabel.text = "暗証番号を設定しました。"
            settingsButton.isEnabled = false
            self.view.endEditing(true)
        }
    }
}

struct password {
    let input: String
    func checkInput(password: String) -> Bool {
        guard password.count <= 4 else { return false }
        return true
    }
}

extension RockerViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateView(false)
        guard let password = textField.text else { return }
        if password.count == 4 {
            settingsButton.isEnabled = true
            self.view.endEditing(true)
        }
        if password.count > 4 {
            self.view.endEditing(true)
            textField.text = ""
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 0 {
            var allowedCharacters = CharacterSet(charactersIn: "1234567890")
            allowedCharacters.insert(charactersIn: " -")
            
            let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
            if unwantedStr.count == 0 {
                return true
            } else if range.length <= 4 {
                return false
            }
        }
        return true
    }
}
