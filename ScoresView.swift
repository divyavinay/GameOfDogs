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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
