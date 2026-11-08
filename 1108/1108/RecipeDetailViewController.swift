//
//  RecipeDetailViewController.swift
//  1108
//
//  Created by 伊藤瞭汰 on 2026/11/08.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    let recipe: Recipe
    @IBOutlet private var cookingMinutesLabel: UILabel!
    @IBOutlet private var memoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = recipe.name
        cookingMinutesLabel.text = recipe.cookingTimeText()
        memoLabel.text = recipe.memo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) は使いません")
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: "RecipeDetailViewController", bundle: nil)
    }
}
