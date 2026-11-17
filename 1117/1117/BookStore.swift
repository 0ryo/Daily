//
//  BookStore.swift
//  1117
//
//  Created by 伊藤瞭汰 on 2026/11/17.
//

import Foundation

struct BookStore {
    static let fileURL = URL.documentsDirectory.appendingPathComponent("books.json")
    
    func save(_ books: [Book]) throws {
        let fileURL = Self.fileURL
        let data = try JSONEncoder().encode(books)
        try data.write(to: fileURL, options: .atomic)
    }
    
    func load() throws -> [Book] {
        let fileURL = Self.fileURL
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return Book.samples }
        
        let json = try Data(contentsOf: fileURL)
        let books = try JSONDecoder().decode([Book].self, from: json)
        return books
    }
}
