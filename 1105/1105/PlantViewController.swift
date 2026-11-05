//
//  PlantViewController.swift
//  1105
//
//  Created by 伊藤瞭汰 on 2026/11/05.
//

import UIKit

class PlantViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

struct Plant: Codable {
    let name: String
    let wateringInterval: Int
}

struct PlantList {
    private(set) var plants: [Plant]
    
    func makePlant(name: String, wateringInterval: Int) -> Plant? {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return nil }
        let plant = Plant(name: trimmedName, wateringInterval: wateringInterval)
        return plant
    }
    
    mutating func append(_ plant: Plant) {
        plants.append(plant)
    }
    
    init(plants: [Plant]) {
        self.plants = plants
    }
}

struct PlantStorage {
    let fileURL: URL
    static let normalFileURL = URL.documentsDirectory.appendingPathComponent("plants.json")
    static let failingFileURL = URL.documentsDirectory.appendingPathComponent("no-such-folder/plants.json")
    
    func save(_ plants: [Plant]) throws {
        do{
            let data = try JSONEncoder().encode(plants)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            throw error
        }
    }
    
    init(fileURL: URL) {
        self.fileURL = fileURL
    }
}
