import Foundation

struct Plant: Codable {
    let name: String
    let intervalDays: Int
}

func encodePlant(_ plant: Plant) -> String{
    do {
        let jsonData = try JSONEncoder().encode(plant)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
    } catch {
        print("エンコードに失敗しました: \(error)")
    }
    return ""
}

let plantURL = URL.documentsDirectory.appending(path: "plants.json")
print(plantURL)

do {
    let data = Data("aaa".utf8)
    try data.write(to: plantURL, options: .atomic)
    print("保存しました")
} catch {
    print("保存に失敗しました: \(error)")
}
