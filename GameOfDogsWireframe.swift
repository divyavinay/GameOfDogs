//
//  GameOfDogsWireframe.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/26/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import Foundation
import UIKit


protocol WirefameProtocol {
    func navigateToScoresView(score: Int, view: UIViewController)
    func navigateToLandingView(view: UIViewController)
}

class GameOfDogsWireframe: WirefameProtocol {
    func navigateToScoresView(score: Int, view: UIViewController) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let scoresView = storyBoard.instantiateViewController(withIdentifier: "scoresViewID") as! ScoresView
        scoresView.score = String(score)
        let navController = UINavigationController(rootViewController: scoresView)
        view.present(navController, animated:true, completion: nil)
    }
    
    func navigateToLandingView(view: UIViewController) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let landingView = storyBoard.instantiateViewController(withIdentifier: "landingViewID") as! LandingView
        view.present(landingView, animated:true, completion: nil)
    }
}


