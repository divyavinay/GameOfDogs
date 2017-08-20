//
//  CollectionViewController.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/20/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    var questionBank: [String] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData { (list) in
            self.getRandomDogs(breedList: list)
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionBank.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogCell
        let dogName = questionBank[indexPath.row]
        let downLoadImageUrl = DownloadImageURL()
        downLoadImageUrl.getImageURL(dogBreedName: dogName) { (downloadedImage) in
            DispatchQueue.main.async {
                cell.dogImage.image = downloadedImage
            }
        }
        
        return cell
    }
    
    func getData(list: @escaping ([String]) -> Void ) {
        var breedList = [String]()
        let dataProvider = DataProvider()
        let urlString = "https://dog.ceo/api/breeds/list"
        dataProvider.fetchData(urlString: urlString) { (JSONDictionary) in
            guard let dogs = Dogs(dictionary: JSONDictionary) else { return }
            for dog in dogs.message {
               breedList.append(dog)
            }
            list(breedList)
        }
    }
    
    func getRandomDogs(breedList: [String]) {
        let randomImageGenerator = RandomImageGenerater()
        questionBank = randomImageGenerator.generateImage(breedList: breedList)
    }
}
