//
//  RandomImageGenerater.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/18/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class RandomImageGenerater {
    
    var questionBank = [String]()
    
    func generateImage(breedList: [String]) -> [String] {
        for _ in 0...3 {
          var arrayIndex =  randomElement(array: breedList)
            if questionBank.contains(breedList[arrayIndex]) {
                arrayIndex = randomElement(array: breedList)
            }
            questionBank.append(breedList[arrayIndex])
        }
        return questionBank
    }
    
    func randomElement(array: [String]) -> Int {
        return Int(arc4random_uniform(UInt32(array.count)))
    }
    
    func randomDogPicker(listOfFourDogs: [String]) -> String {
         let index = Int(arc4random_uniform(UInt32(listOfFourDogs.count)))
         return listOfFourDogs[index]
    }
}
