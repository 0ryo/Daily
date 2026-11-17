//
//  BookEditViewController.swift
//  1117
//
//  Created by 伊藤瞭汰 on 2026/11/17.
//

import UIKit

final class BookEditViewController: UIViewController {
    
    let book: Book
    let index: Int
    weak var delegate: BookEditViewControllerDelegate?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var impressionField: UITextField!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBAction private func saveButtonDidTap(_ sender: UIButton) {
        let impression = impressionField.text ?? ""
        let trimmedImpression = impression.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedImpression.isEmpty else {
            messageLabel.text = "感想を入力してください"
            return
        }
        let newBook = Book(title: book.title, impression: trimmedImpression)
        delegate?.bookEditViewController(self, didSave: newBook, at: index)
        self.navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(book: Book, index: Int) {
        self.book = book
        self.index = index
        super.init(nibName: "BookEditViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "編集"
        titleLabel.text = book.title
        impressionField.text = book.impression
    }
}

protocol BookEditViewControllerDelegate: AnyObject {
    func bookEditViewController(_ controller: BookEditViewController, didSave book: Book, at index: Int)
}
