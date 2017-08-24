//
//  GameView.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/23/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class GameView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private let reuseIdentifier = "Cell"
    private let questionConstant = "Which of these dogs is a"
    
    @IBAction func nextButtonClick(_ sender: UIButton) {
        getRandomDogs(breedList: listOfAllDogs)
    }
    
    private var listOfAllDogs = [String]()
    private var question: String = ""
    
    var questionBank: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        getData { (list) in
            self.listOfAllDogs = list
            self.getRandomDogs(breedList: list)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionBank.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogCollectionViewCell
        cell.activityIndicator.startAnimating()
        let dogName = questionBank[indexPath.row]
        let downLoadImageUrl = DownloadImageURL()
        downLoadImageUrl.getImageURL(dogBreedName: dogName) { (downloadedImage) in
            DispatchQueue.main.async() {
                cell.dogImage.image = downloadedImage
                cell.activityIndicator.stopAnimating()
                cell.activityIndicator.isHidden = true
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if questionBank[indexPath.row] == question {
            print("Answer:\(question), selected: \(questionBank[indexPath.row])")
        }
        else {
            print("Wrong answer")
        }
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
        DispatchQueue.main.async {
            self.generateQuestion()
        }
    }
    
    func generateQuestion() {
        let randomImageGenerator = RandomImageGenerater()
        question = randomImageGenerator.randomDogPicker(listOfFourDogs: questionBank)
        self.questionLabel.text = "\(questionConstant) \(self.question) ?"
    }
}
