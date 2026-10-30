import Foundation

struct StepRecord: Codable {
    let date: String
    let steps: Int
}

struct StepStorage {
    let fileURL: URL
}

// テスト1
var stepStorage = StepStorage(fileURL: URL.documentsDirectory.appending(path: "steps.json"))
print(stepStorage.fileURL)
