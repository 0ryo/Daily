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
    @IBAction private func registerButtonDidTap(_ sender: UIButton) {
        let name = (nameField.text ?? "")
        let brand = (brandField.text ?? "")
        guard let newClothingItem = ClothingItem.init(name: name, brand: brand, category: selectedCategory, isReusableBeforeWash: washSwitch.isOn) else { return }
        delegate?.itemRegisterViewController(self, didRegister: newClothingItem)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categories = ClothingCategory.allCases.map { category in
            UIAction(title: category.displayName) { [weak self] _ in
                self?.selectedCategory = category
            }
        }
        categories[0].state = .on
        
        categoryButton.menu = UIMenu(children: categories)
        categoryButton.showsMenuAsPrimaryAction = true
        categoryButton.changesSelectionAsPrimaryAction = true
    }
}

protocol ItemRegisterViewControllerDelegate: AnyObject {
    func itemRegisterViewController(_ viewController: ItemRegisterViewController, didRegister item: ClothingItem)
}
