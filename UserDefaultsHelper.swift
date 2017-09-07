//
//  UserdefaultsHelper.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 9/6/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    static func canUseCellularData() -> Bool {
        return UserDefaults.standard.bool(forKey: "canUseCellularData")
    }
    
    static func setCanUseCellularData(canUse: Bool) {
        UserDefaults.standard.set(canUse, forKey: "canUseCellularData")
    }
    
    static func isFirstTimeLaunch() -> Bool {
        let isFirstUseString = UserDefaults.standard.string(forKey: "isFirstTimeLaunch")
        if isFirstUseString == nil {
            return true
        }
        return false
    }
    
    static func setIsFirstTimeLaunch() {
        UserDefaults.standard.set("launched", forKey: "isFirstTimeLaunch")
    }
}
