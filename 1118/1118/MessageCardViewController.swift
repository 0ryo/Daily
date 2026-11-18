//
//  MessageCardViewController.swift
//  1118
//
//  Created by 伊藤瞭汰 on 2026/11/18.
//

import UIKit

class MessageCardViewController: UIViewController {

    @IBOutlet private weak var previewLabel: UILabel!
    @IBOutlet private weak var formStackView: UIStackView!
    @IBOutlet private weak var toField: UITextField!
    @IBOutlet private weak var fromField: UITextField!
    @IBOutlet private weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "メッセージカード"
        previewLabel.text = "メッセージを入力してください"
        
        toField.delegate = self
        fromField.delegate = self
        messageField.delegate = self
    }
}

extension MessageCardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.tag != 2 else {
            self.view.endEditing(true)
            previewLabel.text = "\(toField.text ?? "")さんへ：\(messageField.text ?? "")（\(fromField.text ?? "")より）"
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
