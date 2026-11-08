//
//  RecipeListViewController.swift
//  1108
//
//  Created by 伊藤瞭汰 on 2026/11/08.
//

import UIKit

class RecipeListViewController: UIViewController {
    let reuseIdentifier = "RecipeCell"
    var recipes: [Recipe] = []
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "レシピ"

        recipes = Recipe.samples
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = recipes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name)：\(content.cookingTimeText())"
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 選択解除
        let recipeDetailView = RecipeDetailViewController(recipe: recipes[indexPath.row])
        self.navigationController?.pushViewController(recipeDetailView, animated: true)// ナビゲーションコントローラーのpush遷移
        print("\(recipes[indexPath.row])が選択されました。")
    }
}

struct Recipe {
    let name: String
    let cookingMinutes: Int
    let memo: String
    static let samples: [Recipe] = [
        Recipe(name: "カレー", cookingMinutes: 45, memo: "玉ねぎはあめ色になるまで炒める"),
        Recipe(name: "オムライス", cookingMinutes: 20, memo: "卵は半熟で火を止める"),
        Recipe(name: "豚汁", cookingMinutes: 30, memo: "味噌は火を止めてから溶く")
    ]
    
    func cookingTimeText() -> String {
        return "\(cookingMinutes)分"
    }
}
