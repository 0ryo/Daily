//
//  StudyRecordViewController.swift
//  1025
//
//  Created by 伊藤瞭汰 on 2026/10/25.
//

import UIKit

final class StudyRecordViewController: UIViewController {
    
    var studyLog = StudyLog()
    
    @IBOutlet private weak var subjectField: UITextField!
    @IBOutlet private weak var studyTimeField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var totalMinutesLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        let subject = subjectField.text ?? ""
        let studyTime = studyTimeField.text ?? ""
        let studyTimeInt = Int(studyTime.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        
        let result = studyLog.add(subject: subject, minutes: studyTimeInt)
        updateView(result)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudyRecordCell")
        tableView.dataSource = self
    }
    
    private func updateView(_ result: Bool) {
        tableView.reloadData()
        
        if result {
            statusLabel.text="追加しました"
            subjectField.text = ""
            studyTimeField.text = ""
            totalMinutesLabel.text = "合計：\(studyLog.totalMinutes)分"
            self.view.endEditing(true)
        } else {
            statusLabel.text = "科目名と時間を確認してください"
        }
    }
}

extension StudyRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyLog.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = studyLog.records[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyRecordCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.subject)：\(content.minutes)分"
        cell.contentConfiguration = config
        return cell
    }
}

struct StudyRecord {
    let subject: String
    let minutes: Int
}

struct StudyLog {
    private(set) var records: [StudyRecord] = []
    
    mutating func add(subject: String, minutes: Int) -> Bool {
        let trimmedSubject = subject.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedSubject.isEmpty else { return false }
        guard trimmedSubject.count <= 20 else { return false }
        guard minutes > 0 && minutes <= 600 else { return false }
        
        records.append(StudyRecord(subject: trimmedSubject, minutes: minutes))
        return true
    }
    
    var totalMinutes: Int {
        var totalMinutes = 0
        for record in records {
            totalMinutes += record.minutes
        }
        return totalMinutes
    }
}

