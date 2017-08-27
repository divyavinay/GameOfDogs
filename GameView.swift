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
    @IBOutlet weak var backButton: UIButton?
    
    fileprivate var selectedCell: DogCollectionViewCell?
    fileprivate var cellSize: CGRect?
    fileprivate var selectedDog: String?
    
    private var score = 0
    private var round = 0
    private var listOfAllDogs = [String]()
    private var question: String = ""
    
    // protocols
    private var interactor: InteractorProtocol!
    private var wireframe: WirefameProtocol!
    private var random: RandomQuestionManagerProtocol!
    fileprivate var imageDownloader: DownloadImageProtocol!
    
    fileprivate var questionBank: [String] = [] {
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
        else {
            getNextQuestion()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        instantiateProtocolObjects()
        setupCollectionView()
        setupBackgroundImage()
        fetchData()
    }
    
    func instantiateProtocolObjects() {
        interactor = Interactor()
        random = RandomQuestionManager()
        wireframe = GameOfDogsWireframe()
        imageDownloader = DownloadImage()
    }
    
    func fetchData() {
        interactor.getBreedList { list in
            self.listOfAllDogs = list
            self.getRandomDogs(breedList: list)
        }
    }
    
    func setupCollectionView() {
        collectionView.collectionViewLayout = CustomCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupBackgroundImage() {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "dark-grunge-background2")?.draw(in: view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image)
    }
    
    func getRandomDogs(breedList: [String]) {
        questionBank = random.generateImage(breedList: breedList)
        DispatchQueue.main.async {
            self.generateQuestion()
        }
    }
    
    func generateQuestion() {
        let questionConstant = "Which of these dogs is a"
        question = random.randomDogPicker(listOfFourDogs: questionBank)
        self.questionLabel.text = "\(questionConstant) \(self.question) ?"
    }
    
    @objc func backButtonClicked() {
        guard let cell = selectedCell else { return }
        collectionView.sendSubview(toBack: cell)
        guard let size = cellSize else { return }
        selectedCell?.frame = UICollectionViewCell.init(frame: size).frame
    }
    
    func getNextQuestion() {
        if round < 1 {
                round = round + 1
                roundLabel.text = String(round)
                getRandomDogs(breedList: listOfAllDogs)
        } else {
            wireframe.navigateToScoresView(score: score, view: self)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DogCollectionViewCell
        cell.activityIndicator.startAnimating()
        let dogName = questionBank[indexPath.row]
        imageDownloader.getImage(dogBreedName: dogName) { (downloadedImage) in
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
