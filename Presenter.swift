//
//  Presenter.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/26/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterProtocol {
    func fetchImage(dogBreedName:String, downloadedImage: @escaping(UIImage) -> Void)
    func fetchBreedList(list: @escaping ([String]) -> Void)
}

class Presenter: PresenterProtocol {
    private let interactor: InteractorProtocol
    
    init(interactor: InteractorProtocol) {
        self.interactor = interactor
    }
    
    func fetchImage(dogBreedName:String, downloadedImage: @escaping (UIImage) -> Void) {
        fetchURL(dogBreedName: dogBreedName) { [weak self] (url) in
            self?.interactor.downloadImage(url: url, downloadedImage: { (image) in
                downloadedImage(image)
            })
        }
    }

    func fetchURL(dogBreedName: String, downloadedUrl: @escaping (URL) -> Void) {
        let urlString = "https://dog.ceo/api/breed/\(dogBreedName)/images/random"
        interactor.fetchData(urlString: urlString) { (JSONDictionary) in
            guard let dog = Dog(dictionary: JSONDictionary) else { return }
            let urlFromString = URL(string: dog.message)
            guard let url = urlFromString else { return }
            downloadedUrl(url)
        }
    }
    
    func fetchBreedList(list: @escaping ([String]) -> Void) {
        var breedList = [String]()
        let urlString = "https://dog.ceo/api/breeds/list"
        interactor.fetchData(urlString: urlString) { (JSONDictionary) in
            guard let dogs = Dogs(dictionary: JSONDictionary) else { return }
            for dog in dogs.message {
                breedList.append(dog)
            }
            list(breedList)
        }
    }
}
