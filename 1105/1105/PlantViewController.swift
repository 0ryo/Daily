//
//  PlantViewController.swift
//  1105
//
//  Created by 伊藤瞭汰 on 2026/11/05.
//

import UIKit

enum viewState {
    case errConvert
    case start
    case successSave
    case failureSave
}

class PlantViewController: UIViewController {
    
    private var plantList: PlantList = .init(plants: [])
    private var storage = PlantStorage(fileURL: PlantStorage.normalFileURL)
    let cellReuseIdentifier = "PlantCell"
    var didFailToLoad = false
    
    @IBOutlet private weak var plantNameField: UITextField!
    @IBOutlet private weak var wateringIntervalField: UITextField!
    @IBOutlet private weak var settingSwitch: UISwitch!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction private func switchDidChanged(_ sender: UISwitch) {
        if sender.isOn {
            storage = PlantStorage(fileURL: PlantStorage.failingFileURL)
        } else {
            storage = PlantStorage(fileURL: PlantStorage.normalFileURL)
        }
    }
    
    @IBAction private func addPlant(_ sender: UIButton) {
        guard let name = plantNameField.text else { return updateView(.errConvert) }
        guard let interval = wateringIntervalField.text else { return updateView(.errConvert) }
        guard let intervalInt = Int(interval.trimmingCharacters(in: .whitespacesAndNewlines)) else { return updateView(.errConvert) }
        guard let plant = plantList.makePlant(name: name, wateringInterval: intervalInt) else { return updateView(.errConvert) }
        var newPlantList = plantList.plants
        newPlantList.append(plant)
        
        do{
            try storage.save(newPlantList)
            plantList.append(plant)
            updateView(.successSave)
        } catch {
            print(error)
            updateView(.failureSave)
            let alert = UIAlertController(title: "保存できませんでした", message: "入力した内容はそのまま残っています。もう一度お試しください。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(storage.fileURL)
        
        do{
            plantList = try .init(plants: storage.load())
            updateView(.start)
        } catch {
            print(error)
            plantList = .init(plants: [])
            updateView(.start)
            didFailToLoad = true
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if didFailToLoad {
            let alert = UIAlertController(title: "読み込めませんでした", message: "保存データを読み込めなかったため、空の一覧で始めます。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            didFailToLoad = false
        }
    }
    
    private func updateView(_ state: viewState) {
        tableView.reloadData()
        
        switch state {
        case .start:
            settingSwitch.isOn = false
            resultLabel.text = "植物を入力してください"
        case .errConvert:
            resultLabel.text = "名前と水やりの間隔を確認してください"
        case .successSave:
            resultLabel.text = "追加しました"
            plantNameField.text = ""
            wateringIntervalField.text = ""
            self.view.endEditing(true)
        case .failureSave:
            resultLabel.text = "保存に失敗しました"
        }
    }
}

extension PlantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantList.plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = plantList.plants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(content.name): \(content.wateringInterval)日ごと"
        cell.contentConfiguration = config
        return cell
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
        guard wateringInterval > 0 && wateringInterval <= 30 else { return nil }
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
    var fileURL: URL
    static let normalFileURL = URL.documentsDirectory.appendingPathComponent("plants.json")
    static let failingFileURL = URL.documentsDirectory
        .appending(path: "no-such-directory")
        .appending(path: "plants.json")
    
    func save(_ plants: [Plant]) throws {
        do{
            let data = try JSONEncoder().encode(plants)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            throw error
        }
    }
    
    func load() throws -> [Plant] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        do {
            let data = try Data(contentsOf: fileURL)
            let plants = try JSONDecoder().decode([Plant].self, from: data)
            return plants
        } catch {
            throw error
        }
    }
    
    init(fileURL: URL) {
        self.fileURL = fileURL
    }
}
