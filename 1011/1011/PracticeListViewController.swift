//
//  PracticeListViewController.swift
//  1011
//
//  Created by 伊藤瞭汰 on 2026/10/11.
//

import UIKit

class PracticeListViewController: UIViewController {
    var practiceList = PracticeList(items: [
        PracticeItem(name: "A", count: 0, goal: 2),
        PracticeItem(name: "B", count: 0, goal: 1),
        PracticeItem(name: "C", count: 0, goal: 3),
    ])
    
    @IBOutlet private weak var achieveLabel: UILabel!
    @IBAction private func tapReset(_ sender: UIButton) {
        practiceList.resetAll()
        reload()
    }
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reload()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PracticeListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reload() {
        tableView.reloadData()
        
        guard practiceList.items.count > 0 else {
            achieveLabel.text = "メニューがありません。"
            return
        }
        
        if practiceList.goalCount == practiceList.items.count {
            achieveLabel.text = "全件達成！"
        } else {
            achieveLabel.text = "達成: \(practiceList.goalCount)/\(practiceList.items.count)"
        }
    }
}

struct PracticeItem {
    let name: String
    var count: Int
    var goal: Int
    var isCompleted: Bool {
        return count >= goal
    }
}

struct PracticeList {
    var items: [PracticeItem]
    var goalCount: Int {
        var count = 0
        for item in items {
            if item.isCompleted {
                count += 1
            }
        }
        return count
    }
    
    mutating func record(index: Int) -> Bool {
        guard index >= 0 && index < items.count else { return false }
        guard !items[index].isCompleted else { return false }
        items[index].count += 1
        return true
    }
    
    mutating func resetAll() {
        for index in items.indices {
            items[index].count = 0
        }
    }
}

extension PracticeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return practiceList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = practiceList.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeListCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        
        config.text = "\(content.name) 現在回数:\(content.count)/目標回数:\(content.goal) \(content.isCompleted ? "達成":"未達成")"
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = practiceList.record(index: indexPath.row)
        
        reload()
    }
}
