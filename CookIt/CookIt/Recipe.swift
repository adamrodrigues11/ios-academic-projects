//
//  Recipe.swift
//  CookIt
//
//  Created by Adam Rodrigues on 2022-11-01.
//

import Foundation

class Recipe{
    
    var title: String
    var steps: [String]
    var imageURL: String
    
    init(title: String, steps: [String], imageURL: String) {
        self.title = title
        self.steps = steps
        self.imageURL = imageURL
    }
    
}

