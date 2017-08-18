//
//  DataProvider.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/17/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit
import Foundation

protocol DataProvidingProtocol {
    func fetchData(urlString: String, dogsList: @escaping (JSONDictionary) -> Void)
}

class DataProvider: DataProvidingProtocol {
    
    func fetchData(urlString: String, dogsList: @escaping (JSONDictionary) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            guard let res = response as? HTTPURLResponse else { return }
            if res.statusCode != 200 { return }
            guard let data = data else { return }
            guard let JSONData = self.serializable(data: data) else { return }
            dogsList(JSONData)
        }
        task.resume()
    }
    
    func serializable(data: Data) -> JSONDictionary? {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonData as? JSONDictionary
        } catch {
            print("Error \(error.localizedDescription)")
        }
        return nil
    }
}
