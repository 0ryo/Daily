//
//  ReadingListViewController.swift
//  1010
//
//  Created by 伊藤瞭汰 on 2026/10/10.
//

import UIKit

class ReadingListViewController: UIViewController {
    var bookShelf = ReadingList(books: [
        Book(title: "A", isRead: false),
        Book(title: "B", isRead: false),
        Book(title: "C", isRead: false),
    ])
    
    @IBOutlet private weak var isReadLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if bookShelf.books.isEmpty {
            isReadLabel.text = "本がありません。"
        } else {
            isReadLabel.text = "読了: \(bookShelf.readBooksCount)/\(bookShelf.books.count)冊"

        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReadingListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

struct Book {
    let title: String
    var isRead: Bool
}

struct ReadingList {
    var books: [Book]
    var readBooksCount: Int {
        var count: Int = 0
        for book in books {
            if book.isRead {
                count += 1
            }
            continue
        }
        return count
    }
    
    mutating func changeRead(index: Int) -> Bool{
        guard index >= 0 else { return false }
        guard books.count > index else { return false }
        books[index].isRead.toggle()
        return true
    }
    
}

extension ReadingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookShelf.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = bookShelf.books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingListCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(item.title) - \(item.isRead ? "読了":"未読")"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = bookShelf.changeRead(index: indexPath.row)
        print(bookShelf.books[indexPath.row])
        tableView.reloadData()
        isReadLabel.text = "読了: \(bookShelf.readBooksCount)/\(bookShelf.books.count)冊"
    }
}
