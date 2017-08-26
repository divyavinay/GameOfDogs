//
//  GameView.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/23/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class GameView: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
 
    let reuseIdentifier = "Cell"
    let questionConstant = "Which of these dogs is a"
    let column: CGFloat = 2
    let inset: CGFloat = 8
    var selectedCell: DogCollectionViewCell?
    var cellSize: CGRect?
    var score = 0
    var round = 0
    var selectedDog: String?
   
    @IBOutlet weak var backButton: UIButton?
    private var listOfAllDogs = [String]()
    var question: String = ""
    
    var questionBank: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    @IBAction func checkAnswer(_ sender: Any) {
        if selectedDog == question {
            score = score + 10
            scoreLable.text = String(score)
            getNextQuestion()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.collectionViewLayout = CustomCollectionView()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "dark-grunge-background2")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
      
        getData { (list) in
            self.listOfAllDogs = list
            self.getRandomDogs(breedList: list)
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
    
    @objc func backButtonClicked() {
        self.collectionView.sendSubview(toBack: self.selectedCell!)
        self.selectedCell?.frame = UICollectionViewCell.init(frame: self.cellSize!).frame
    }
    
    func getNextQuestion() {
        if round < 1 {
                round = round + 1
                roundLabel.text = String(round)
                getRandomDogs(breedList: listOfAllDogs)
        } else {
            performSegue(withIdentifier: "scoreSegue", sender: nil)
        }
    }
}

extension GameView: UICollectionViewDelegate, UICollectionViewDataSource {
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
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.superview?.bringSubview(toFront: cell)
        selectedCell = collectionView.cellForItem(at: indexPath) as? DogCollectionViewCell
        cellSize = selectedCell?.frame
        backButton?.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
        animateSelectedCell(cell: cell)
        selectedDog = questionBank[indexPath.row]
    }
    
    func animateSelectedCell(cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            cell.frame = self.collectionView.bounds
            self.collectionView.isScrollEnabled = false
        }, completion: nil)
    }
}
