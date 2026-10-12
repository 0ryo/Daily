//
//  TicketStockViewController.swift
//  1007
//
//  Created by 伊藤瞭汰 on 2026/10/07.
//

import UIKit

class TicketStockViewController: UIViewController {
    var ticketModel = TicketStock(initialCount: 5)
    
    @IBOutlet weak var initialCountLabel: UILabel!
    @IBOutlet weak var remainingCountLabel: UILabel!
    @IBOutlet weak var isSoldOutLabel: UILabel!
    @IBAction func sellButton(_ sender: UIButton) {
        _ = ticketModel.sell()
        updateView()
    }
    @IBAction func resetButton(_ sender: UIButton) {
        _ = ticketModel.reset()
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        initialCountLabel.text = "全\(ticketModel.initialCount)枚"
        remainingCountLabel.text = "残り\(ticketModel.remainingCount)枚"
        
        if ticketModel.isSoldOut {
            isSoldOutLabel.text = "売り切れ"
        } else {
            isSoldOutLabel.text = "販売中"
        }
    }
}

class TicketStock {
    let initialCount: Int
    private(set) lazy var remainingCount: Int = initialCount
    var isSoldOut: Bool {
        return remainingCount == 0
    }
    
    func sell() -> Bool {
        guard isSoldOut == false else { return false }
        remainingCount -= 1
        return true
    }
    func reset() -> Bool {
        guard remainingCount != initialCount else { return false }
        remainingCount = initialCount
        return true
    }
    
    init(initialCount: Int) {
        self.initialCount = initialCount
    }
}
