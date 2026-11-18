//
//  BookListViewController.swift
//  1117
//
//  Created by 伊藤瞭汰 on 2026/11/17.
//

import UIKit

final class BookListViewController: UIViewController {
    
    private let reuseIdentifier = "BookCell"
    private let store = BookStore()
    private var books: [Book] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "本"
        
        do{
            books = try store.load()
        } catch {
            self.title = "本(読み込み失敗)"
        }
        
        tableView.reloadData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension BookListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.title)：\(content.impression)"
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookEditViewController = BookEditViewController(book: books[indexPath.row], index: indexPath.row)
        bookEditViewController.delegate = self
        self.navigationController?.pushViewController(bookEditViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BookListViewController: BookEditViewControllerDelegate {
    func bookEditViewController(_ controller: BookEditViewController, didSave book: Book, at index: Int) {
        self.books[index] = book
        tableView.reloadData()
        do {
            try store.save(self.books)
        } catch {
            self.title = "本(保存失敗)"
        }
    }
}

struct Book: Codable {
    let title: String
    var impression: String
    
    static let samples: [Book] = [
        Book(title: "星の地図", impression: "図が多くて読みやすい"),
        Book(title: "海辺の図書館", impression: "最後の章が良かった"),
        Book(title: "雨の日の数学", impression: "途中で難しくなった"),
    ]
}
