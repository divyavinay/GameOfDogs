//
//  LandingView.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 9/6/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class LandingView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaultsHelper.isFirstTimeLaunch() {
             NetworkkHelper().requestCellarDataUse()
        }
    }
}
