//
//  PlantListViewController.swift
//  1114
//
//  Created by 伊藤瞭汰 on 2026/11/14.
//

import UIKit

final class PlantListViewController: UIViewController {
    let reuseIdentifier = "PlantListCell"
    let store = PlantStore()
    var plants: [Plant] = []
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "植物"
        
        do {
            plants = try store.load()
        } catch {
            self.title = "植物(読み込み失敗)"
            plants = []
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        updateView()
    }
    
    private func updateView() {
        tableView.reloadData()
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
        let plantEditViewController = PlantEditViewController(plant: plants[indexPath.row], index: indexPath.row)
        plantEditViewController.delegate = self
        navigationController?.pushViewController(plantEditViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PlantListViewController: PlantEditViewControllerDelegate {
    func plantEditViewController(_ controller: PlantEditViewController, didSave plant: Plant, at index: Int) {
        self.plants[index] = plant
        updateView()
        do{
            try store.save(plants)
        } catch {
            self.title = "植物(保存失敗)"
        }
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

