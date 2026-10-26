import Foundation

enum MovieError: Error {
    case titleIsEmpty
    case minuteIsTooLong
    case minuteIsTooShort
}

struct Movie: Codable, Equatable {
    let title: String
    let minutes: Int
    let isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case title = "movie_title"
        case minutes = "running_minutes"
        case isFavorite = "is_favorite"
    }
}

func buildMovie(title: String, minutes: Int, isFavorite: Bool) -> Movie?{
    let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmedTitle.isEmpty else {
        print("タイトルが空です。")
        return nil
    }
    guard minutes > 0 else {
        print("時間が短すぎます。")
        return nil
    }
    guard minutes <= 600 else {
        print("時間が長すぎます。")
        return nil
    }
    return Movie(title: trimmedTitle, minutes: minutes, isFavorite: isFavorite)
}

func encodeMovie(_ movie: Movie) -> String{
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try encoder.encode(movie)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            return jsonString
        }
    } catch {
        print("Encoding failed:", error)
    }
    return ""
}

func decodeMovie(_ jsonString: String) -> Movie?{
    do {
        let jsonData = Data(jsonString.utf8)
        
        let decoder = JSONDecoder()
        
        let movie = try decoder.decode(Movie.self, from: jsonData)
        print(movie)
        return movie
    } catch {
        print("Decoding failed:", error)
        return nil
    }
}

if let movie1 = buildMovie(title: "君の名は。    ", minutes: 106, isFavorite: true) {
    let encodedString = encodeMovie(movie1)
    if let decodedMovie1 = decodeMovie(encodedString) {
        print(movie1 == decodedMovie1)
    }
}

if let decodedMovie2 = decodeMovie("""
{"movie_title": "千と千尋の神隠し", "running_minutes": 125, "is_favorite": true}
""") {
    print(decodedMovie2.title)
    print(decodedMovie2.minutes)
    print(decodedMovie2.isFavorite)
}

let decodedMovie3 = decodeMovie("""
[
  {"movie_title": "トイ・ストーリー", "running_minutes": 81, "is_favorite": false},
  {"movie_title": "天空の城ラピュタ", "running_minutes": 124, "is_favorite": true},
  {"movie_title": "インサイド・ヘッド", "running_minutes": 94, "is_favorite": false}
]
""")

let _ = buildMovie(title: "  ", minutes: 100, isFavorite: false)
let _ = buildMovie(title: "パン", minutes: 0, isFavorite: false)
let _ = buildMovie(title: "ぱん", minutes: 601, isFavorite: false)
