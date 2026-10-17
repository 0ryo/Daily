//
//  ResaveListViewController.swift
//  1014
//
//  Created by 伊藤瞭汰 on 2026/10/14.
//

import UIKit

class ResaveListViewController: UIViewController {
    
    var receptionList = ReceptionList(resavations: [
        Resavation(name: "鈴木", resaverCount: 3, checkedInCount: 0),
        Resavation(name: "田中", resaverCount: 2, checkedInCount: 0),
        Resavation(name: "佐藤", resaverCount: 4, checkedInCount: 0),
    ])
    
    @IBOutlet private var receptionLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var undoButton: UIButton!
    @IBAction func undoButtonTapped(_ sender: UIButton) {
        _ = receptionList.undoLast()
        updateView()
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        receptionList.reset()
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ResaveListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updateView() {
        tableView.reloadData()
        undoButton.isEnabled = receptionList.canUndo
        
        if receptionList.totalReservedCount == 0 {
            receptionLabel.text = "予約がありません。"
        } else {
            receptionLabel.text = "受付人数: \(receptionList.totalCheckedInCount)/\(receptionList.totalReservedCount)"
        }
    }

}

struct Resavation {
    let name: String
    var resaverCount: Int
    var checkedInCount: Int
    var isFullyCheckedIn: Bool {
        return checkedInCount == resaverCount
    }
}

struct ReceptionList {
    var resavations: [Resavation]
    var lastCheckedInIndex: Int? = nil
    
    var totalCheckedInCount: Int {
        var count = 0
        for resavation in resavations {
            count += resavation.checkedInCount
        }
        return count
    }
    
    var totalReservedCount: Int {
        var count = 0
        for resavation in resavations {
            count += resavation.resaverCount
        }
        return count
    }
    
    var canUndo: Bool {
        return lastCheckedInIndex != nil
    }
    
    mutating func checkIn(index: Int) -> Bool {
        guard index >= 0 && index < resavations.count else { return false }
        guard !resavations[index].isFullyCheckedIn else { return false }
        resavations[index].checkedInCount += 1
        lastCheckedInIndex = index
        return true
    }
    
    mutating func undoLast() -> Bool {
        defer { lastCheckedInIndex = nil }
        guard canUndo else { return false }
        guard let lastCheckedInIndex = lastCheckedInIndex else { return false }
        resavations[lastCheckedInIndex].checkedInCount -= 1
        return true
    }
    
    mutating func reset() {
        for index in resavations.indices {
            resavations[index].checkedInCount = 0
        }
        lastCheckedInIndex = nil
    }
    
    init(resavations: [Resavation]) {
        self.resavations = resavations
    }
}

extension ResaveListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receptionList.resavations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = receptionList.resavations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResaveListCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        if content.isFullyCheckedIn {
            config.text = "\(content.name)様 受付状況: \(content.checkedInCount)人/\(content.resaverCount)人 全員受付済み"
        } else {
            config.text = "\(content.name)様 受付状況: \(content.checkedInCount)人/\(content.resaverCount)人 受付中"
        }
        
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = receptionList.checkIn(index: indexPath.row)
        updateView()
    }
}
