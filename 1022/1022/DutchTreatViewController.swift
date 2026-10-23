//
//  DutchTreatViewController.swift
//  1022
//
//  Created by 伊藤瞭汰 on 2026/10/22.
//

import UIKit

class DutchTreatViewController: UIViewController {

    @IBOutlet private weak var fieldLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var buttonLabel: UILabel!
    @IBAction func buttonTapped(_ sender: Any) {
        // 現在の入力をモデルに保存する
        textField.text = "" // ボタンが押せたら空にしてOK
        textField.endEditing(true) // ボタンが押せたらキーボードを閉じる
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView(0)
        
        textField.delegate = self
    }
    
    private func updateView(_ currentTextInt: Int) {
        if currentTextInt <= 0 || currentTextInt > 20 {
            fieldLabel.text = "1〜20人で入力してください"
            buttonLabel.text = "人数を入力してください。"
            registerButton.isEnabled = false
        } else {
            fieldLabel.text = "決定できます"
            buttonLabel.text = "\(currentTextInt)人で割り勘します"
            registerButton.isEnabled = true
        }
    }
}

struct InputText {
    let newText: String
    func checkText(_ newText: String) -> Bool {
        if newText.count > 2 { return false } // 文字数の判定
        
        let allowedCharacters = CharacterSet(charactersIn: "1234567890")
        let unwantedStr = newText.trimmingCharacters(in: allowedCharacters)
        if unwantedStr.count != 0 {
            return false
        }
        return true
    }
}

extension DutchTreatViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        let instance = InputText(newText: newText)
        guard instance.checkText(newText) else { return false }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let currentText = textField.text ?? ""
        let currentTextInt = Int(currentText) ?? 0
        updateView(currentTextInt)
    }
}
