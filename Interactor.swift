//
//  Interactor.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/26/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import Foundation

protocol InteractorProtocol {
    func getBreedList(list: @escaping ([String]) -> Void)
}

class Interactor: InteractorProtocol {
    private let dataProvider: DataProvidingProtocol
    
    init(dataProvider: DataProvidingProtocol = DataProvider()) {
        self.dataProvider =  dataProvider
    }
    
    func getBreedList(list: @escaping ([String]) -> Void) {
        var breedList = [String]()
        let urlString = "https://dog.ceo/api/breeds/list"
        dataProvider.fetchData(urlString: urlString) { (JSONDictionary) in
            guard let dogs = Dogs(dictionary: JSONDictionary) else { return }
            for dog in dogs.message {
                breedList.append(dog)
            }
            list(breedList)
        }
    }
}
