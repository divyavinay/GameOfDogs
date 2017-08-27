//
//  DataProvider.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/17/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit
import Foundation

protocol InteractorProtocol {
    func fetchData(urlString: String, dogsList: @escaping (JSONDictionary) -> Void)
    func downloadImage(url: URL, downloadedImage: @escaping (UIImage) -> Void)
}

class Interactor: InteractorProtocol {
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
    
    func downloadImage(url: URL, downloadedImage: @escaping (UIImage) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            guard error == nil else { return }
            guard let urlResponse = response as? HTTPURLResponse else { return }
            guard urlResponse.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            downloadedImage(image)
        })
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
