//
//  PetViewController.swift
//  1113
//
//  Created by 伊藤瞭汰 on 2026/11/13.
//

import UIKit

class PetViewController: UIViewController {
    
    private var petName: String? = nil
    
    @IBOutlet private weak var petNameLabel: UILabel!
    @IBAction private func giveNameButtonDidTap(_ sender: UIButton) {
        let editViewController = PetNameEditViewController()
        editViewController.onSave = { [weak self] name in
            guard let self else { return }
            petName = name
            updateLabel()
        }
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ペット"
        updateLabel()
    }
    
    private func updateLabel() {
        if let petName = petName {
            petNameLabel.text = "ペットの名前：\(petName)"
        } else {
            petNameLabel.text = "ペットの名前：未設定"
        }
    }
}
