import Foundation

enum menuError: Error {
    case invalidJSON
    case noKey(String)
    case wrongType(String)
    case noValue(String)
}

struct Menu: Decodable {
    let name: String
    let price: Int
    let isSoldOut: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case isSoldOut = "sold_out"
    }
}


struct Menus: Decodable {
    private(set) var menuArray: [Menu] = []
    
    mutating func decodeMenu(json: String) throws {
        guard let data = json.data(using: .utf8) else { throw menuError.invalidJSON }
        do {
            let menus = try JSONDecoder().decode([Menu].self, from: data)
            for menu in menus {
                guard menu.name.count > 0 else { throw menuError.noValue("name") }
                guard menu.price > 0 else { throw menuError.noValue("price") }
            }
            menuArray = menus
        } catch DecodingError.keyNotFound(let property) {
            throw menuError.noKey(property.0.stringValue)
            
        } catch DecodingError.typeMismatch(let property) {
            guard let propertyStr = property.1.codingPath.last?.stringValue else { return }
            throw menuError.wrongType(propertyStr)
            
        } catch DecodingError.valueNotFound(let property) {
            guard let propertyStr = property.1.codingPath.last?.stringValue else { return }
            throw menuError.noValue(propertyStr)
            
        } catch {
            throw error
        }
        
    }
    
    mutating func decodeMenuTry(json: String) throws -> [Menu] {
        guard let data = json.data(using: .utf8) else { throw menuError.invalidJSON }
        if let menus = try? JSONDecoder().decode([Menu].self, from: data) {
            for menu in menus {
                guard menu.name.count > 0 else { throw menuError.noValue("name") }
                guard menu.price > 0 else { throw menuError.noValue("price") }
            }
            menuArray = menus
        } else { menuArray = [] }
        return menuArray
    }
}

let test1 = """
[{"name": "ブレンド", "sold_out": false}]
"""

var Menus1: Menus = .init()
do {
    try Menus1.decodeMenu(json: test1)
} catch menuError.noKey(let property) {
    print("\(property)がありません")
} catch menuError.noValue(let property) {
    print("\(property)の値がありません")
} catch menuError.wrongType(let property) {
    print("\(property)の型が違います")
} catch DecodingError.dataCorrupted {
    print("invalidJSON")
}
print(Menus1.menuArray)
