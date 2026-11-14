//
//  PlantEditViewController.swift
//  1114
//
//  Created by 伊藤瞭汰 on 2026/11/14.
//

import UIKit

class PlantEditViewController: UIViewController {
    
    let plant: Plant
    let index: Int
    weak var delegate: PlantEditViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "編集"
    }
    
    required init(plant: Plant, index: Int) {
        self.plant = plant
        self.index = index
    }
}

protocol PlantEditViewControllerDelegate: AnyObject {
    func plantEditViewController(_ controller: PlantEditViewController, didSave plant: Plant, at index: Int)
}
