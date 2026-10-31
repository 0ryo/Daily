//
//  main.swift
//  1030
//
//  Created by 伊藤瞭汰 on 2026/10/30.
//

import Foundation

struct TodoItem: Codable {
    let title: String
    let isDone: Bool
}

struct TodoStorage {
    let fileURL = URL.documentsDirectory.appendingPathComponent("todos.json")
    
    // MARK: - fileURLの実ファイルに保存する関数
    func save(_ items: [TodoItem]) throws {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            throw error
        }
    }
    
    // MARK: - fileURLの実ファイルの中身を読み込む関数
    func load() throws -> [TodoItem] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        do {
            let json = try String(contentsOf: fileURL, encoding: .utf8)
            guard let data = json.data(using: .utf8) else { return [] }
            let items = try JSONDecoder().decode([TodoItem].self, from: data)
            return items
        } catch {
            throw error
        }
    }
    
    // MARK: - fileURLの実ファイルにエンコードしていないStringを書き込む関数
    func writeText(_ text: String) throws {
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            throw error
        }
    }
    
    // MARK: - fileURLの実ファイルを削除する関数
    func deleteFile() throws {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            throw error
        }
    }
}

// MARK: - アプリの起動時に一覧を用意する関数
func loadItemsAtLaunch(from storage: TodoStorage) -> [TodoItem] {
    do {
        let items = try storage.load()
        return items
    } catch let decodeError as DecodingError {
        print("保存データが壊れているため、空の一覧で始めます: \(decodeError)")
        return []
    } catch {
        print("読み込みに失敗したため、空の一覧で始めます: \(error)")
        return []
    }
}

// MARK: - テスト用コード
var storage = TodoStorage()
print("Test 1 ------------------------------------------------------")
do {
    try storage.deleteFile()
    let items = try storage.load()
    print("\(items.count)件読み込み成功, \(items)")
} catch {
    print(error)
}

print("Test 2 ------------------------------------------------------")
let test2 = [
    TodoItem(title: "牛乳を買う", isDone: false),
    TodoItem(title: "部屋の掃除", isDone: true)
]
do {
    try storage.save(test2)
    print("保存完了")
} catch {
    print(error)
}

print("Test 3 ------------------------------------------------------")
do {
    let items = try storage.load()
    print("\(items.count)件 読み込み成功, \(items)")
} catch {
    print(error)
}

print("Test 4 ------------------------------------------------------")
let test4 = """
    {"title": "牛乳を買う
"""
do {
    try storage.writeText(test4)
    print("保存完了")
} catch {
    print(error)
}
do {
    let items = try storage.load()
    print("\(items.count)件 読み込み成功, \(items)")
} catch {
    print(error)
}

print("Test 5 ------------------------------------------------------")
let itemsAtLaunch5 = loadItemsAtLaunch(from: storage)
print("\(itemsAtLaunch5.count)件 読み込み成功, \(itemsAtLaunch5)")

print("Test 6 ------------------------------------------------------")
let test6 = """
    [{"title": 1, "isDone": false}]
"""
do {
    try storage.writeText(test6)
    print("保存完了")
} catch {
    print(error)
}
let itemsAtLaunch6 = loadItemsAtLaunch(from: storage)
print("\(itemsAtLaunch6.count)件 読み込み成功, \(itemsAtLaunch6)")

print("Test 7 ------------------------------------------------------")
do {
   try storage.deleteFile()
} catch {
    print(error)
}
let itemsAtLaunch7 = loadItemsAtLaunch(from: storage)
print("\(itemsAtLaunch7.count)件 読み込み成功, \(itemsAtLaunch7)")
