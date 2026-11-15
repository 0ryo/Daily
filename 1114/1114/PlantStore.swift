//
//  PlantStore.swift
//  1114
//
//  Created by 伊藤瞭汰 on 2026/11/15.
//

import Foundation

struct PlantStore {
    static let fileURL: URL = URL.documentsDirectory.appendingPathComponent("plants.json")
    func save(_ plants: [Plant]) throws {
        let fileURL = Self.fileURL
        do {
            let data = try JSONEncoder().encode(plants)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            throw error
        }
    }
    
    func load() throws -> [Plant] {
        let fileURL = Self.fileURL
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return Plant.samples }
        do {
            let data = try Data(contentsOf: fileURL)
            let plants = try JSONDecoder().decode([Plant].self, from: data)
            return plants
        } catch {
            throw error
        }
    }
}
