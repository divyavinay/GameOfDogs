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
    
    override func prepareForReuse() {
        dogImage.image = nil
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = false
    }
}
