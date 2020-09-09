//
//  ViewController.swift
//  AppVersionLocalPod
//
//  Created by Harlan Kellaway on 9/9/20.
//  Copyright © 2020 Harlan Kellaway. All rights reserved.
//

import AppVersion
import UIKit

class ViewController: UIViewController {
    
    private let versionLabel = UILabel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(versionLabel)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let appVersion: AppVersion? = .fromBundle
        versionLabel.text = "Version \(appVersion ?? "Unknown :(")"
        
        let minimumAppVersion: AppVersion = "0.1.0"
        guard let currentAppVersion: AppVersion = .fromBundle, currentAppVersion >= minimumAppVersion else {
            // send user to App Store
            fatalError()
        }
    }

}
