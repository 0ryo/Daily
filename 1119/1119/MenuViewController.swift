//
//  MenuViewController.swift
//  1119
//
//  Created by 伊藤瞭汰 on 2026/11/19.
//

import UIKit

final class MenuViewController: UIViewController {
    
    @IBAction private func toTallyViewButtonDidTap(_ sender: UIButton) {
        let tallyViewController = TallyViewController()
        self.navigationController?.pushViewController(tallyViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
