//
//  BookViewController.swift
//  1110
//
//  Created by 伊藤瞭汰 on 2026/11/10.
//

import UIKit

final class BookViewController: UIViewController {
    var book = Book(title: "坊ちゃん", isFinished: true)
    
    @IBOutlet private weak var bookLabel: UILabel!
    @IBAction private func toDetailButtonDidTap(_ sender: UIButton) {
        let bookDetailViewController = BookDetailViewController(nibName: "BookDetailViewController", bundle: nil)
        bookDetailViewController.bookTitle = book.title
        bookDetailViewController.isFinished = book.isFinished
        bookDetailViewController.delegate = self
        guard let navigationController = self.navigationController else { return }
        navigationController.pushViewController(bookDetailViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "本棚"
        updateLabel()
    }
    
    private func updateLabel() {
        bookLabel.text = "\(book.title)：\(book.isFinished ? "読み終えた" : "まだ読んでない")"
    }
}

extension BookViewController: BookDetailViewControllerDelegate {
    func bookDetailViewController(_ controller: BookDetailViewController, didSave isFinished: Bool) {
        book.isFinished = isFinished
        updateLabel()
    }
}


struct Book {
    let title: String
    var isFinished: Bool
}
