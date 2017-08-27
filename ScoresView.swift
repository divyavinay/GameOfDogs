//
//  ScoresView.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/26/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

class ScoresView: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = score
    }
}
