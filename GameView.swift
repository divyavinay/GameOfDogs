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
    @IBOutlet weak var checkAnswer: UIButton!
    
    fileprivate var selectedCell: DogCollectionViewCell?
    fileprivate var cellSize: CGRect?
    fileprivate var selectedDog: String?
    
    private var score = 0
    private var round = 1
    private var listOfAllDogs = [String]()
    private var question: String = ""
    
    // protocols
    fileprivate var wireframe: WirefameProtocol!
    private var random: RandomQuestionHelperProtocol!
    fileprivate var presenter: PresenterProtocol!
    fileprivate var interactor: InteractorProtocol!
    private var networkHelper: NetworkkHelper!
    
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
        
        disableButton()
        instantiateProtocolObjects()
        setupCollectionView()
        setupBackgroundImage()
        fetchData()
    }
    
    func instantiateProtocolObjects() {
        interactor = Interactor()
        presenter = Presenter(interactor: Interactor())
        random = RandomQuestionHelper()
        wireframe = GameOfDogsWireframe()
        networkHelper = NetworkkHelper()
    }
    
    func fetchData() {
        if networkHelper.isInternetAvailable() {
            presenter.fetchBreedList { list in
                self.listOfAllDogs = list
                self.getRandomDogs(breedList: list)
            }
        }
        else {
            DispatchQueue.main.async {
                self.createAlertController()
            }
        }
    }
    
    func setupCollectionView() {
        collectionView.collectionViewLayout = CustomCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupBackgroundImage() {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "Black-Grunge-Wallpapers")?.draw(in: view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image)
    }
    
    func getRandomDogs(breedList: [String]) {
        if networkHelper.isInternetAvailable() {
            questionBank = random.generateImage(breedList: breedList)
            DispatchQueue.main.async {
                self.generateQuestion()
            }
        }
        else {
            DispatchQueue.main.async {
                self.createAlertController()
            }
        }
    }
    
    func generateQuestion() {
        let questionConstant = "Which of these dogs is a"
        question = random.randomDogPicker(listOfFourDogs: questionBank)
        self.questionLabel.text = "\(questionConstant) \(self.question) ?"
        disableButton()
    }
    
    @objc func backButtonClicked() {
        guard let cell = selectedCell as? DogCollectionViewCell else { return }
        collectionView.sendSubviewToBack(cell)
        guard let size = cellSize else { return }
        selectedCell?.frame = UICollectionViewCell.init(frame: size).frame
        cell.setClick(value: 0)
        disableButton()
    }
    
    func getNextQuestion() {
        if round < 10 {
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
        cell.isUserInteractionEnabled = false
        
        cell.activityIndicator.startAnimating()
        let dogName = questionBank[indexPath.row]
        presenter.fetchImage(dogBreedName: dogName) { (downloadedImage) in
            DispatchQueue.main.async() {
                cell.dogImage.image = downloadedImage
                cell.activityIndicator.stopAnimating()
                cell.isUserInteractionEnabled = true
                cell.activityIndicator.isHidden = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DogCollectionViewCell else { return }
        if cell.getNumberOFClicks() < 1 {
            cell.superview?.bringSubviewToFront(cell)
            selectedCell = collectionView.cellForItem(at: indexPath) as? DogCollectionViewCell
            cellSize = selectedCell?.frame
            backButton?.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
            cell.setClick(value: nil)
            animateSelectedCell(cell: cell)
            selectedDog = questionBank[indexPath.row]
        }
    }
    
    func animateSelectedCell(cell: UICollectionViewCell) {
        enableButton()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            cell.frame = self.collectionView.bounds
            self.collectionView.isScrollEnabled = false
        }, completion: nil)
    }
    
    func disableButton() {
        checkAnswer.isEnabled = false
        backButton?.isEnabled = false
        checkAnswer.alpha = 0.7
        backButton?.alpha = 0.7
    }
    
    func enableButton() {
        checkAnswer.isEnabled = true
        backButton?.isEnabled = true
        checkAnswer.alpha = 1
        backButton?.alpha = 1
    }
    
    func createAlertController() {
        let alertController = UIAlertController(title: "No Network", message: "Please ensure that you are connected to the network.", preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        self.wireframe.navigateToLandingView(view: self)
        }
        alertController.addAction(OKAction)
    }
}
