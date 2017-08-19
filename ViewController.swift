//
//  ViewController.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/17/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var breedList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func display() {
        let dataProvider = DataProvider()
        let urlString = "https://dog.ceo/api/breeds/list"
        dataProvider.fetchData(urlString: urlString) { (JSONDictionary) in
        guard let dogs = Dogs(dictionary: JSONDictionary) else { return }
        for dog in dogs.message {
            self.breedList.append(dog)
            }
            let randomImageGenerator = RandomImageGenerater()
            let downLoadImageUrl = DownloadImageURL()
            downLoadImageUrl.getImageURL(dogsList: randomImageGenerator.generateImage(breedList: self.breedList))
        }
    }
    
}
