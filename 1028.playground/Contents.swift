import Foundation

struct Plant: Codable {
    let name: String
    let intervalDays: Int
}

func encodePlant(_ plant: [Plant]) throws -> String{
    do {
        let jsonData = try JSONEncoder().encode(plant)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
    } catch {
        print("エンコードに失敗しました: \(error)")
        throw error
    }
    return ""
}

func decodePlant(_ json: String) throws -> [Plant]{
    guard let data = json.data(using: .utf8) else { return [] }
    do {
        let plant = try JSONDecoder().decode([Plant].self, from: data)
        return plant
    } catch {
        print("デコードに失敗しました: \(error)")
        throw error
    }
}

func deleteFileIfExists(at url: URL) {
    guard FileManager.default.fileExists(atPath: url.path) else {
        print("削除するファイルはありません")
        return
    }
    do {
        try FileManager.default.removeItem(at: url)
        print("ファイルを削除しました")
    } catch {
        print("削除に失敗しました: \(error)")
    }
}

let plantURL = URL.documentsDirectory.appending(path: "plants.json")
print(plantURL) // テスト1

// テスト2
deleteFileIfExists(at: plantURL)
// テスト2
do {
    let data = try decodePlant(try String(contentsOf: plantURL))
    print("テスト2: \(data)")
} catch {
    print("テスト2: \(error)")
}

let plant1 = Plant(name: "モンステラ", intervalDays: 7)
let plant2 = Plant(name: "サボテン", intervalDays: 14)
let plant3 = Plant(name: "バジル", intervalDays: 2)
let plantArray = [plant1, plant2, plant3]

// テスト3
do {
    let data = try Data(encodePlant(plantArray).utf8)
    try data.write(to: plantURL, options: .atomic)
    print("テスト3: 保存しました")
} catch {
    print("テスト3: 保存に失敗しました: \(error)")
}

// テスト4
do {
    let data = try decodePlant(try String(contentsOf: plantURL))
    print("テスト4: \(data)、件数: \(data.count)件")
} catch {
    print("テスト4: \(error)")
}

// テスト5
let plant4 = [Plant(name: "ポトス", intervalDays: 5)]
do {
    let data = try Data(encodePlant(plant4).utf8)
    try data.write(to: plantURL, options: .atomic)
    print("テスト5: 保存しました")
} catch {
    print("テスト5: 保存に失敗しました: \(error)")
}

do {
    let data = try decodePlant(try String(contentsOf: plantURL))
    print("テスト5: \(data)、件数: \(data.count)件")
} catch {
    print("テスト5: \(error)")
}

// テスト6
let plant5: [Plant] = []
do {
    let data = try Data(encodePlant(plant5).utf8)
    try data.write(to: plantURL, options: .atomic)
    print("テスト6: 保存しました")
} catch {
    print("テスト6: 保存に失敗しました: \(error)")
}

do {
    let data = try decodePlant(try String(contentsOf: plantURL))
    print("テスト6: \(data)、件数: \(data.count)件")
} catch {
    print("テスト6: \(error)")
}
