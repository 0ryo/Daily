//
//  SettingsViewController.swift
//  1104
//
//  Created by 伊藤瞭汰 on 2026/11/04.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func closeSettings(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        printLifecycle(screen: "Settings", method: "viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printLifecycle(screen: "Settings", method: "viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printLifecycle(screen: "Settings", method: "viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        printLifecycle(screen: "Settings", method: "viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printLifecycle(screen: "Settings", method: "viewDidDDisappear")
    }
}

