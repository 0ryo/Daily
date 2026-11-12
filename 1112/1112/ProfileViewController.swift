//
//  ProfileViewController.swift
//  1112
//
//  Created by 伊藤瞭汰 on 2026/11/12.
//

import UIKit

final class ProfileViewController: UIViewController {
    var nickname: String? = nil
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBAction private func changeButtonDidTap(_ sender: UIButton) {
        let editViewController = NicknameEditViewController()
        editViewController.delegate = self
        self.navigationController?.pushViewController(editViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "プロフィール"
        
        updateLabel()
    }
    
    private func updateLabel() {
        if let nickname = nickname {
            nameLabel.text = "ニックネーム：\(nickname)"
        } else {
            nameLabel.text = "ニックネーム：未設定"
        }
    }
}

extension ProfileViewController: NicknameEditViewControllerDelegate {
    func nicknameEditViewController(_ controller: NicknameEditViewController, didSave nickname: String) {
        self.nickname = nickname
        updateLabel()
    }
}
