//
//  ClothingItem.swift
//  Patim
//
//  Created by 伊藤瞭汰 on 2026/11/21.
//

import Foundation

struct ClothingItem {
    let name: String
    let brand: String
    let category: ClothingCategory
    let isReusableBeforeWash: Bool
    
    init?(name: String, brand: String, category: ClothingCategory, isReusableBeforeWash: Bool) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedBrand = brand.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return nil }
        guard !trimmedBrand.isEmpty else { return nil }
        self.name = trimmedName
        self.brand = trimmedBrand
        self.category = category
        self.isReusableBeforeWash = isReusableBeforeWash
    }
}
