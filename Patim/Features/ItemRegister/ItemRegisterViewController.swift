//
//  ItemRegisterViewController.swift
//  Patim
//
//  Created by 伊藤瞭汰 on 2026/11/22.
//

import UIKit

final class ItemRegisterViewController: UIViewController {
    
    private var selectedCategory: ClothingCategory = .tops
    weak var delegate: ItemRegisterViewControllerDelegate?
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var brandField: UITextField!
    @IBOutlet private weak var categoryButton: UIButton!
    @IBOutlet private weak var washSwitch: UISwitch!
    @IBOutlet private weak var registerErrorLabel: UILabel!
    @IBAction private func registerButtonDidTap(_ sender: UIButton) {
        let name = (nameField.text ?? "")
        let brand = (brandField.text ?? "")
        guard let newClothingItem = ClothingItem.init(name: name, brand: brand, category: selectedCategory, isReusableBeforeWash: washSwitch.isOn) else {
            registerErrorLabel.isHidden = false
            registerErrorLabel.text = "名前とブランド名を入力してください"
            return
        }
        registerErrorLabel.isHidden = true
        delegate?.itemRegisterViewController(self, didRegister: newClothingItem)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categories = ClothingCategory.allCases.map { category in
            UIAction(title: category.displayName, state: category == selectedCategory ? .on : .off) { [weak self] _ in
                self?.selectedCategory = category
            }
        }
        
        categoryButton.menu = UIMenu(children: categories)
        categoryButton.showsMenuAsPrimaryAction = true
        categoryButton.changesSelectionAsPrimaryAction = true
        
        nameField.delegate = self
        brandField.delegate = self
    }
}

protocol ItemRegisterViewControllerDelegate: AnyObject {
    func itemRegisterViewController(_ viewController: ItemRegisterViewController, didRegister item: ClothingItem)
}

extension ItemRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            textField.resignFirstResponder()
            brandField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
}
