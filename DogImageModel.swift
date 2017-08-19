//
//  DogImageModel.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/18/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//

import UIKit

struct Dog {
    let status: String
    let message: String
}

extension Dog: JSONDeserializable {
    init?(dictionary: JSONDictionary) {
        guard
            let status = dictionary["status"] as? String,
            let message = dictionary["message"] as? String
        else {
            return nil
        }
        self.status = status
        self.message = message
    }
}
