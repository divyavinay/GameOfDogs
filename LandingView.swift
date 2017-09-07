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
        requestCellarDataUse()
    }

    func requestCellarDataUse() {
        let alertController = UIAlertController(title: "Celluar Data request", message: "This application will use network connection. If there is no WiFi connection, do you want to continue playing this game using your cellular connection ?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            UserdefaultsHelper.setCanUseCellularData(canUse: true)
        }
        
        let noAction = UIAlertAction(title: "NO", style: .cancel) { (action) in
            UserdefaultsHelper.setCanUseCellularData(canUse: false)
        }
    
        self.present(alertController, animated: true, completion: nil)
        alertController.addAction(OKAction)
        alertController.addAction(noAction)
    }
}
