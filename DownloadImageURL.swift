//
//  DownloadImage.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/18/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit
import Foundation

class DownloadImageURL {
    
    func getImageURL(dogBreedName:String, downloadedImage: @escaping(UIImage) -> Void) {
        let imageProvider = ImageProvider()
        let urlString = "https://dog.ceo/api/breed/\(dogBreedName)/images/random"
        imageProvider.fetchData(urlString: urlString) { (JSONDictionary) in
            guard let dog = Dog(dictionary: JSONDictionary) else { return }
           
            let urlFromString = URL(string: dog.message)
            guard let url = urlFromString else { return }
            
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
    }
}
