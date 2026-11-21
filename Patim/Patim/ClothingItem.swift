//
//  ClothingItem.swift
//  Patim
//
//  Created by 伊藤瞭汰 on 2026/11/21.
//

enum ClothingCategory {
    case tops
    case pants
    case outer
    case other
    
    var displayName: String {
        switch self {
        case .tops: return "トップス"
        case .pants: return "パンツ"
        case .outer: return "アウター"
        case .other: return "その他"
        }
    }
}

struct ClothingItem {
    let name: String
    let brand: String
    let category: ClothingCategory
    let isReusableBeforeWash: Bool
}
