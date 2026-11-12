//
//  NicknameEditViewController.swift
//  1112
//
//  Created by 伊藤瞭汰 on 2026/11/12.
//

import UIKit

final class NicknameEditViewController: UIViewController {
    
    weak var delegate: NicknameEditViewControllerDelegate?
    
    @IBOutlet private weak var nicknameField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBAction private func saveButtonDidTap() {
        let nickname = nicknameField.text ?? ""
        let trimmedNickname = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedNickname.isEmpty else {
            errorLabel.isHidden = false
            errorLabel.text = "ニックネームを入力してください"
            return
        }
        errorLabel.isHidden = true
        delegate?.nicknameEditViewController(self, didSave: trimmedNickname)
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
}

protocol NicknameEditViewControllerDelegate: AnyObject {
    func nicknameEditViewController(_ controller: NicknameEditViewController, didSave nickname: String)
}
