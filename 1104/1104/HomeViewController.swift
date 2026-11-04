//
//  HomeViewController.swift
//  1104
//
//  Created by 伊藤瞭汰 on 2026/11/04.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func openSettings(_ sender: UIButton) {
        let settingsView = SettingsViewController()
        settingsView.modalPresentationStyle = .fullScreen
        self.present(settingsView, animated: true)
    }
    
    @IBAction func openSettingsBySheet(_ sender: UIButton) {
        let settingsView = SettingsViewController()
        settingsView.modalPresentationStyle = .pageSheet
        self.present(settingsView, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        printLifecycle(screen: "Home", method: "viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printLifecycle(screen: "Home", method: "viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printLifecycle(screen: "Home", method: "viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        printLifecycle(screen: "Home", method: "viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printLifecycle(screen: "Home", method: "viewDidDDisappear")
    }
}
