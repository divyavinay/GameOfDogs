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
    
    private var listOfAllDogs = [String]()

    var questionBank: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData { (list) in
            self.listOfAllDogs = list
            self.getRandomDogs(breedList: list)
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: UIBarButtonItem) {
        getRandomDogs(breedList: listOfAllDogs)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionBank.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogCell
        cell.activityIndicator.startAnimating()
        let dogName = questionBank[indexPath.row]
        let downLoadImageUrl = DownloadImageURL()
        downLoadImageUrl.getImageURL(dogBreedName: dogName) { (downloadedImage) in
            DispatchQueue.main.async(){
                cell.dogImage.image = downloadedImage
            }
        cell.activityIndicator.stopAnimating()
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
                print(dog)
            }
            list(breedList)
        }
    }
    
    func getRandomDogs(breedList: [String]) {
        let randomImageGenerator = RandomImageGenerater()
        questionBank = randomImageGenerator.generateImage(breedList: breedList)
    }
}
