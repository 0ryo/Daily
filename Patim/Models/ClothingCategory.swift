//
//  ClothingCategory.swift
//  Patim
//
//  Created by 伊藤瞭汰 on 2026/11/21.
//

enum ClothingCategory: CaseIterable {
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
