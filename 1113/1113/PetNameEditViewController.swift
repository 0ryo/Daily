//
//  PetNameEditViewController.swift
//  1113
//
//  Created by 伊藤瞭汰 on 2026/11/13.
//

import UIKit

class PetNameEditViewController: UIViewController {
    var onSave: ((String) -> Void)?
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBAction private func save(_ sernder: UIButton) {
        let name = nameTextField.text ?? ""
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        onSave?(trimmedName)
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("PetNameEditViewControllerを解放しました")
    }
}
