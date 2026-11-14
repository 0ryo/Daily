//
//  PlantListViewController.swift
//  1114
//
//  Created by 伊藤瞭汰 on 2026/11/14.
//

import UIKit

class PlantListViewController: UIViewController {
    let reuseIdentifier = "PlantListCell"
    var plants: [Plant] = Plant.samples
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "植物"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
    }
}

extension PlantListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = plants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name)：\(content.memo)"
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let plantEditViewController = PlantEditViewController()
        navigationController?.pushViewController(plantEditViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

struct Plant: Codable {
    let name: String
    let memo: String
    
    static let samples: [Plant] = [
        Plant(name: "モンステラ", memo: "土が乾いたら水をやる"),
        Plant(name: "サボテン", memo: "月に1回水をやる"),
        Plant(name: "ポトス", memo: "直射日光に当てない"),
    ]
}

