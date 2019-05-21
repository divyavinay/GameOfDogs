//
//  AppDelegateExtension.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 9/6/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import Foundation
import UIKit


extension AppDelegate {
    func setupNavigationBarUI() {
        UINavigationBar.appearance().barTintColor = UIColor.hexStringToUIColor(hex: "A9CE41")
        UINavigationBar.appearance().titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
