//
//  WorkoutViewController.swift
//  1031
//
//  Created by 伊藤瞭汰 on 2026/10/31.
//

import UIKit

class WorkoutViewController: UIViewController {
    var log = WorkoutLog(records: [])
    
    @IBOutlet private weak var exerciseField: UITextField!
    @IBOutlet private weak var repsField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBAction private func addButtonDidTap(_ sender: UIButton) {
        let exercise = exerciseField.text ?? ""
        let reps = repsField.text ?? ""
        let repsInt = Int(reps.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        let result = log.add(name: exercise, count: repsInt)
        
        updateView(result)
    }
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WorkoutCell")
        tableView.dataSource = self
    }
    
    func updateView(_ result: Bool) {
        tableView.reloadData()
        
        if result {
            resultLabel.text = "追加しました"
            exerciseField.text = ""
            repsField.text = ""
            self.view.endEditing(true)
        } else {
            resultLabel.text = "種目名と回数を確認してください"
        }
    }
}

extension WorkoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return log.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = log.records[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name): \(content.count)回"
        cell.contentConfiguration = config
        return cell
    }
}

struct WorkoutRecord: Codable {
    let name: String
    var count: Int
}

struct WorkoutLog {
    var records: [WorkoutRecord]

    mutating func add(name: String, count: Int) -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return false }
        guard count > 0 && count <= 999 else { return false }
        
        records.append(WorkoutRecord(name: name, count: count))
        return true
    }

    init(records: [WorkoutRecord]) {
        self.records = records
    }
}

struct WorkoutStorage {
    let fileURL = URL.documentsDirectory.appendingPathComponent("workouts.json")

    func save(_ records: [WorkoutRecord]) throws {
        do {
            let data = try JSONEncoder().encode(records)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            throw error
        }
    }
    
    func load() throws -> [WorkoutRecord] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        do {
            let json = try String(contentsOf: fileURL, encoding: .utf8)
            guard let data = json.data(using: .utf8) else { return [] }
            let items = try JSONDecoder().decode([WorkoutRecord].self, from: data)
            return items
        } catch {
            throw error
        }
    }
}
