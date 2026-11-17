//
//  StampCardViewController.swift
//  1116
//
//  Created by 伊藤瞭汰 on 2026/11/16.
//

import UIKit

final class StampCardViewController: UIViewController {
    var card = StampCard(stampCount: 0, goal: 10)
    let spacing: CGFloat = 16
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBAction private func stampButtonDidTap(_ sender: UIButton) {
        card.addStamp()
        updateLabel()
    }
    @IBAction private func resetButtonDidTap(_ sender: UIButton) {
        card.reset()
        updateLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "スタンプカード"
        updateLabel()
    }
    
    func updateLabel() {
        countLabel.text = "スタンプ：\(card.stampCount)/\(card.goal)"
    }
}

struct StampCard {
    var stampCount: Int
    var goal: Int
    
    mutating func addStamp() {
        guard stampCount < goal else { return }
        stampCount += 1
    }
    
    mutating func reset() {
        stampCount = 0
    }
}
