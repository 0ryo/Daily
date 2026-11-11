//
//  BookDetailViewController.swift
//  1110
//
//  Created by 伊藤瞭汰 on 2026/11/10.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var isFinishedSwitch: UISwitch!
    @IBAction private func saveButtonDidTap(_ sender: UIButton) {
        delegate?.bookDetailViewController(self, didSave: isFinishedSwitch.isOn)
        guard let navigationController = self.navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    weak var delegate: BookDetailViewControllerDelegate?
    var bookTitle = ""
    var isFinished = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = bookTitle
        isFinishedSwitch.isOn = isFinished
    }
}

extension BookDetailViewController {
    func bookDetailViewController(_ controller: BookDetailViewController, didSave isFinished: Bool) {
        delegate?.bookDetailViewController(controller, didSave: isFinished)
    }
}

protocol BookDetailViewControllerDelegate: AnyObject {
    func bookDetailViewController(_ controller: BookDetailViewController, didSave isFinished: Bool)
}
