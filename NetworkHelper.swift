//
//  NetworkHelper.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 9/6/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

struct NetworkkHelper {
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func requestCellarDataUse() {
        let alertController = UIAlertController(title: "Celluar Data request", message: "This application will use network connection. If there is no WiFi connection, do you want to continue playing this game using your cellular connection ?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES", style: .default) { (action) in
            UserDefaultsHelper.setCanUseCellularData(canUse: true)
            UserDefaultsHelper.setIsFirstTimeLaunch()
        }
        let noAction = UIAlertAction(title: "NO", style: .default) { (action) in
            UserDefaultsHelper.setCanUseCellularData(canUse: false)
            UserDefaultsHelper.setIsFirstTimeLaunch()
        }
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
    }
}
