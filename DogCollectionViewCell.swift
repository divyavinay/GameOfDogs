//
//  DogCollectionViewCell.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/23/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class DogCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dogImage: UIImageView!
    
    private var numberOfclicks = 0
    
    override func prepareForReuse() {
        dogImage.image = nil
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = false
        numberOfclicks = 0
    }
    
    func setClick(value: Int?) {
        if let value = value {
            numberOfclicks = value
        } else {
            numberOfclicks += 1
        }
    }

    func getNumberOFClicks() -> Int {
        return numberOfclicks
    }

}
