//
//  Question.swift
//  Quizzler
//
//  Created by Kevin Hudson on 9/8/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    
    // properties
    let questionText : String
    let answer : Bool
    
    // Initializer method
    init(text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
    
    
    
}


