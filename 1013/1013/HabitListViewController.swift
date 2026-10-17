//
//  HabitListViewController.swift
//  1013
//
//  Created by 伊藤瞭汰 on 2026/10/13.
//

import UIKit

class HabitListViewController: UIViewController {
    
    var habitTracker = HabitTracker(habits: [
        Habit(name: "読書", currentCount: 0, goalCount: 3),
        Habit(name: "ストレッチ", currentCount: 0, goalCount: 2),
        Habit(name: "Swift学習", currentCount: 0, goalCount: 4),
    ])

    @IBOutlet private var completeLabel: UILabel!
    @IBAction private func tapResetButton(_ sender: UIButton) {
        habitTracker.reset()
        updateView()
    }
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HabitListCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updateView() {
        tableView.reloadData()
        
        if habitTracker.habits.isEmpty {
            completeLabel.text = "習慣がありません。"
        } else if habitTracker.completedCount == habitTracker.habits.count {
            completeLabel.text = "達成: \(habitTracker.completedCount)/\(habitTracker.habits.count)　全件達成！"
            return
        } else {
            completeLabel.text = "達成: \(habitTracker.completedCount)/\(habitTracker.habits.count)"
            return
        }
    }
}

struct Habit {
    let name: String
    var currentCount: Int
    let goalCount: Int
    var isCompleted: Bool {
        return currentCount >= goalCount
    }
}

struct HabitTracker {
    var habits: [Habit]
    var completedCount: Int {
        var count = 0
        for habit in habits {
            if habit.isCompleted {
                count += 1
            }
        }
        return count
    }
    
    mutating func record(index: Int) -> Bool {
        guard index >= 0, index < habits.count else { return false }
        guard !habits[index].isCompleted else { return false }
        habits[index].currentCount += 1
        return true
    }
    
    mutating func reset() {
        for index in habits.indices {
            habits[index].currentCount = 0
        }
    }
}

extension HabitListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitTracker.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = habitTracker.habits[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitListCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name) \(content.currentCount)/\(content.goalCount) \(content.isCompleted ? "達成":"未達成")"
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = habitTracker.record(index: indexPath.row)
        updateView()
    }
}
