//
//  WaterCounterViewController.swift
//  1006
//
//  Created by 伊藤瞭汰 on 2026/10/06.
//

import UIKit

class WaterCounterViewController: UIViewController {
    var counter = WaterCounter(goalCount: 4) // インスタンスを作る！
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var isCompleteLabel: UILabel!
    @IBAction private func recordButtonTapped(_ sender: UIButton) {
        _ = counter.record()
        updateDisplay()
    }
    @IBAction private func resetButtonTapped(_ sender: UIButton) {
        _ = counter.reset()
        updateDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }
    
    private func updateDisplay() {
        goalLabel.text = "目標\(counter.goalCount)杯"
        currentLabel.text = "現在\(counter.currentCount)杯"
        
        if counter.isComplete {
            isCompleteLabel.text = "目標達成！"
        } else {
            isCompleteLabel.text = "未達成"
        }
    }
}

class WaterCounter {
    let goalCount: Int
    private(set) var currentCount: Int = 0
    var isComplete: Bool {
        return currentCount >= goalCount
    }
    
    func record() -> Bool {
        guard !isComplete else { return false }
        currentCount += 1
        print("currentCount:\(currentCount)")
        return true
    }
    
    func reset() -> Bool {
        guard currentCount != 0 else { return false }
        currentCount = 0
        print("currentCount:\(currentCount)")
        return true
    }
    
    init(goalCount: Int) {
        self.goalCount = goalCount
    }
}
