//
//  WorkoutViewController.swift
//  1031
//
//  Created by 伊藤瞭汰 on 2026/10/31.
//

import UIKit

class WorkoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct WorkoutRecord: Codable {
    let name: String
    var counnt: Int
}

struct WorkoutLog {
    var records: [WorkoutRecord]

    mutating func add(name: String, count: Int) -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return false }
        guard count > 0 && count <= 999 else { return false }
        
        records.append(WorkoutRecord(name: name, counnt: count))
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
