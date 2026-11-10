//
//  BookDetailViewController.swift
//  1110
//
//  Created by 伊藤瞭汰 on 2026/11/10.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var isFinishedSwitch: UISwitch!
    @IBAction private func isFinishedSwitchValueChanged(_ sender: UISwitch) {
        bookDetailViewController(self, didSave: sender.isOn)
    }
    @IBAction private func saveButtonDidTap(_ sender: UIButton) {
        delegate?.bookDetailViewController(self, didSave: isFinishedSwitch.isOn)
        self.navigationController?.popViewController(animated: true)
    }

    weak var delegate: BookDetailViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BookDetailViewController: BookDetailViewControllerDelegate {
    func bookDetailViewController(_ controller: BookDetailViewController, didSave isFinished: Bool) {
        delegate?.bookDetailViewController(controller, didSave: isFinished)
    }
}

protocol BookDetailViewControllerDelegate: AnyObject {
    func bookDetailViewController(_ controller: BookDetailViewController, didSave isFinished: Bool)
}
