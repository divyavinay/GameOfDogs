//
//  DogCell.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/20/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class DogCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImage: UIImageView!
    
    override func prepareForReuse() {
        dogImage.image = nil
    }
    
    
}
