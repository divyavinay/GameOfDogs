//
//  UserdefaultsHelper.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 9/6/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import Foundation

class UserdefaultsHelper {
    static func canUseCellularData() -> Bool {
        return UserDefaults.standard.bool(forKey: "canUseCellularData")
    }
    
    static func setCanUseCellularData(canUse: Bool) {
        UserDefaults.standard.set(canUse, forKey: "canUseCellularData")
    }
    
    static func isFirstTimeLaunch() -> Bool {
        return UserDefaults.standard.bool(forKey: "isFirstTimeLaunch")
    }
    
    static func setIsFirstTimeLaunch(isFirstTime: String) {
        UserDefaults.standard.set(isFirstTime, forKey: "isFirstTimeLaunch")
    }
}
