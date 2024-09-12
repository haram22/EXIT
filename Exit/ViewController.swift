//
//  ViewController.swift
//  Exit
//
//  Created by 김하람 on 9/11/24.
//

import SwiftUI
import UIKit
import Exit_ActivityReport
import DeviceActivity

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appListView = AppListView()
        let hostingController = UIHostingController(rootView: appListView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
