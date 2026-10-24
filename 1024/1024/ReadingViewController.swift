//
//  ReadingViewController.swift
//  1024
//
//  Created by 伊藤瞭汰 on 2026/10/24.
//

import UIKit
import Foundation

class ReadingViewController: UIViewController {
    
    var bookshelf1 = BookShelf(books: [])
    
    @IBOutlet private weak var titleField: UITextField!
    @IBOutlet private weak var ratingField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBAction func registerButtonDidTapped(_ sender: Any) {
        let rawTitle = titleField.text ?? ""
        let title = rawTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let rawRating = ratingField.text ?? ""
        let rating = Int(rawRating.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        let result = bookshelf1.add(book: Book(title: title, rating: rating))
        let encodedData = try encodeData(Book(title: title, rating: rating))
        updateView(result)
    }
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReadingCell")
        tableView.dataSource = self
    }
    
    private func updateView(_ result: Bool) {
        tableView.reloadData()
        
        if result {
            resultLabel.text = "保存しました"
        } else {
            resultLabel.text = "保存に失敗しました"
        }
    }
    
    func encodeData(_ book: Book) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data: Data? = try? encoder.encode(book)
        guard let checkedData = data else { throw encodeError }
        print(String(data: checkedData, encoding: .utf8) ?? "")
        return checkedData
    }
    
    func decodeData() {
        let decoder = JSONDecoder()
        let book: Book? = try? decoder.decode(Book.self, from: Data)
    }
}

extension ReadingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookshelf1.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = bookshelf1.books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.title) \(content.rating)"
        cell.contentConfiguration = config
        return cell
    }
}

struct Book: Codable {
    let title: String
    let rating: Int
}

struct BookShelf: Codable {
    var books: [Book]
    
    mutating func add(book: Book) -> Bool {
        guard !book.title.isEmpty else { return false }
        guard book.rating > 0 && book.rating <= 5 else { return false }
        books.append(book)
        return true
    }
}
