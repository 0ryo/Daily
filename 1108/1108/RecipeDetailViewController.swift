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
    @IBAction private func backButtonDidTap(_ sender: UIButton) {
        guard let navigationController = self.navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = recipe.name
        cookingMinutesLabel.text = recipe.cookingTimeText()
        memoLabel.text = recipe.memo
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let viewControllersCount = self.navigationController?.viewControllers.count else { return }
        print("詳細を表示：スタックの画面は\(viewControllersCount)件")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) は使いません")
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: "RecipeDetailViewController", bundle: nil)
    }
}
