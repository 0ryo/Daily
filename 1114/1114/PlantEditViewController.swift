//
//  PlantEditViewController.swift
//  1114
//
//  Created by 伊藤瞭汰 on 2026/11/14.
//

import UIKit

final class PlantEditViewController: UIViewController {
    
    @IBOutlet private weak var nameTextLabel: UILabel!
    @IBOutlet private weak var memoField: UITextField!
    @IBAction private func saveButtonDidTap(_ sender: UIButton) {
        let newPlant = Plant(name: plant.name, memo: memoField.text ?? "")
        delegate?.plantEditViewController(self, didSave: newPlant, at: index)
        self.navigationController?.popViewController(animated: true)
    }
    
    let plant: Plant
    let index: Int
    weak var delegate: PlantEditViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "編集"
        nameTextLabel.text = plant.name
        memoField.text = plant.memo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(plant: Plant, index: Int) {
        self.plant = plant
        self.index = index
        super.init(nibName: "PlantEditViewController", bundle: nil)
    }
}

protocol PlantEditViewControllerDelegate: AnyObject {
    func plantEditViewController(_ controller: PlantEditViewController, didSave plant: Plant, at index: Int)
}
