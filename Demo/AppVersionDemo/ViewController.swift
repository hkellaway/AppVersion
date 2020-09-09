//
//  ViewController.swift
//  AppVersionDemo
//
//  Created by Harlan Kellaway on 9/8/20.
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
        
        let appVersion = AppVersion().speak()
        versionLabel.text = appVersion
    }


}

