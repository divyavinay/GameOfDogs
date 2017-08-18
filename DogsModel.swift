//
//  DogsModel.swift
//  GameOfDogs
//
//  Created by Divya Basappa on 8/17/17.
//  Copyright © 2017 Divya Basappa. All rights reserved.
//


typealias JSONDictionary = [String: AnyObject]

protocol JSONDeserializable {
    init?(dictionary: JSONDictionary)
}

struct Dogs {
    let status: String
    let message: [String]
}

extension Dogs: JSONDeserializable {
    init?(dictionary: JSONDictionary) {
        guard
            let status = dictionary["status"] as? String,
            let message = dictionary["message"] as? [String]
        else {
            return nil
        }
        self.status = status
        self.message = message
    }
}

