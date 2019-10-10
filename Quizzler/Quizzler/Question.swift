//
//  Question.swift
//  Quizzler
//
//  Created by Licardo on 2019/10/10.
//  Copyright © 2019 rongcosme. All rights reserved.
//

import Foundation

class Question {
    
    let questionText: String
    let answer: Bool
    
    init(text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
}
