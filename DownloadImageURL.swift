//
//  DownloadImage.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/18/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class DownloadImageURL {
    
    var imageUrlArray = [String]()
    
    func getImageURL(dogsList: [String]) {
        let imageProvider = ImageProvider()
        for index in 0...3 {
            let urlString = "https://dog.ceo/api/breed/\(dogsList[index])/images/random"
            imageProvider.fetchData(urlString: urlString) { (JSONDictionary) in
                guard let dog = Dog(dictionary: JSONDictionary) else { return }
                self.imageUrlArray.append(dog.message)
            }
        }
    }
}
