//
//  ImageProvider.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/18/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit
import Foundation

class ImageProvider: DataProvidingProtocol {
    func fetchData(urlString: String, dogsList: @escaping (JSONDictionary) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            guard let res = response as? HTTPURLResponse else { return }
            guard res.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let jsonData = self.serializeData(data: data) else { return }
            dogsList(jsonData)
        }
        task.resume()
    }
    
    func serializeData(data: Data) -> JSONDictionary? {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonData as? JSONDictionary
            
        } catch {
            print("Error \(error.localizedDescription)")
        }
         return nil
    }
}
