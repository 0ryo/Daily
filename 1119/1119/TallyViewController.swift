//
//  TallyViewController.swift
//  1119
//
//  Created by 伊藤瞭汰 on 2026/11/19.
//

import UIKit

final class TallyViewController: UIViewController {

    private let counter = TallyCounter()
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBAction private func plusButtonDidTap(_ sender: UIButton) {
        counter.increment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "数取り"
        countLabel.text = "0人"
        
        counter.onChange = { [weak self] count in
            self?.countLabel.text = "\(count)人"
        }
    }
    
    deinit {
        print("TallyViewControllerを解放しました")
    }
}
