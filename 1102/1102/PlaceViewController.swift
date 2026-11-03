//
//  PlaceViewController.swift
//  1102
//
//  Created by 伊藤瞭汰 on 2026/11/02.
//

import UIKit
import Foundation

final class PlaceViewController: UIViewController {
    private let placeList = PlaceList(places: [
        Place(name: "京都"),
        Place(name: "札幌"),
        Place(name: "那覇"),
        Place(name: "金沢"),
    ])
    private let displaySettings = DisplaySettings()
    private let cellIdentifier = "PlaceListCell"
    private var placeListForDisplay: [Place] = []
    @IBOutlet private weak var switcher: UISwitch!
    @IBOutlet private weak var tableView: UITableView!
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        let value = sender.isOn
        displaySettings.saveNewestFirst(value)
        placeListForDisplay = placeList.sortedPlaces(newestFirst: value)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = displaySettings.loadNewestFirst()
        let places = placeList.sortedPlaces(newestFirst: value)
        placeListForDisplay = places
        switcher.isOn = value
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
    }
}

extension PlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeListForDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = placeListForDisplay[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = content.name
        cell.contentConfiguration = config
        return cell
    }
}

struct Place {
    let name: String
}

struct PlaceList {
    private(set) var places: [Place]
    
    func sortedPlaces(newestFirst: Bool) -> [Place] {
        var copyPlaces = places
        if newestFirst {
            copyPlaces.reverse()
            return copyPlaces
        } else {
            return copyPlaces
        }
    }
    
    init(places: [Place]) {
        self.places = places
    }
}

struct DisplaySettings {
    let defaults =  UserDefaults.standard
    let newestFirstKey: String = "newestFirst"
    
    func saveNewestFirst(_ value: Bool) {
        defaults.set(value, forKey: newestFirstKey)
    }
    
    func loadNewestFirst() -> Bool {
        return defaults.bool(forKey: newestFirstKey)
    }
}
