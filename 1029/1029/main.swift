//
//  main.swift
//  1029
//
//  Created by 伊藤瞭汰 on 2026/10/29.
//

import Foundation

struct StepRecord: Codable {
    let date: String
    let steps: Int
}

struct StepStorage {
    let fileURL: URL
    
    func save(_ records: [StepRecord]) throws {
        do {
            let data = try JSONEncoder().encode(records)
            if let jsonString = String(data: data, encoding: .utf8) {
                try data.write(to: fileURL, options: .atomic)
            }
        } catch {
            throw error
        }
    }
    
    func load() throws -> [StepRecord] {
        do {
            let json = try String(contentsOf: fileURL, encoding: .utf8)
            guard let data = json.data(using: .utf8) else { return [] }
            
            let records = try JSONDecoder().decode([StepRecord].self, from: data)
            return records
        } catch {
            throw error
        }
    }
    
    func deleteFile() throws {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            throw error
        }
    }
}

print("テスト1")
var stepStorage = StepStorage(fileURL: URL.documentsDirectory.appending(path: "steps.json"))
print(stepStorage.fileURL)

print("テスト2")
do {
    try stepStorage.deleteFile()
    
} catch {
    print("ファイルが削除できませんでした\(error)")
}
do {
    let _ = try stepStorage.load()
} catch {
    print("ファイルが読込できませんでした\(error)")
}

print("テスト3")
let test3: [StepRecord] = [
    StepRecord(date: "2026-10-27", steps: 6500),
    StepRecord(date: "2026-10-28", steps: 8200),
    StepRecord(date: "2026-10-29", steps: 4300)
]
do {
    try stepStorage.save(test3)
} catch {
    print("ファイルが保存できませんでした\(error)")
}

print("テスト4")
do {
    let test4 = try stepStorage.load()
    print(test4, test4.count)
} catch {
    print("ファイルが読込できませんでした\(error)")
}

print("テスト5")
let test5: [StepRecord] = [
    StepRecord(date: "2026-10-30", steps: 9000),
    StepRecord(date: "2026-10-31", steps: 7100)
]
do {
    try stepStorage.save(test5)
} catch {
    print("ファイルが保存できませんでした\(error)")
}
do {
    let test5 = try stepStorage.load()
    print(test5, test5.count)
} catch {
    print("ファイルが読込できませんでした\(error)")
}

print("テスト6")
let test6: [StepRecord] = []
do {
    try stepStorage.save(test6)
} catch {
    print("ファイルが保存できませんでした\(error)")
}
do {
    let test6 = try stepStorage.load()
    print(test6, test6.count)
} catch {
    print("ファイルが読込できませんでした\(error)")
}

print("テスト7")
do {
    try stepStorage.deleteFile()
    print("ファイルを削除しました。")
} catch {
    print(error)
}
do {
    try stepStorage.deleteFile()
    
} catch {
    print("ファイルが削除できませんでした\(error)")
}
do {
    let _ = try stepStorage.load()
} catch {
    print("ファイルが読込できませんでした\(error)")
}
