//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Joel Strahan on 6/26/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct QuestionModel {
    var question: String
    var answer: String
    var possibleAnswerOne: String
    var possibleAnswerTwo: String
    var possibleAnswerThree: String
    
    
    func randomAnswersForButtons() -> [String] {
        var answerArray = [String]()
        // stored property to establish number of buttons
        let buttons = 4
        var questionAnswers = [answer, possibleAnswerOne, possibleAnswerTwo, possibleAnswerThree]
        var counter = 0
        
        for _ in 1...buttons {
            counter = questionAnswers.count
            let randomButton = GKRandomSource.sharedRandom().nextInt(upperBound: counter)
            answerArray.append(questionAnswers[randomButton])
            questionAnswers.remove(at: randomButton)
            
        }
        
        return answerArray
    }
    
    
}

struct QuestionSets {
    let questionSet1 = QuestionModel(question: "Which planet in our solar system has the most oxygen?", answer: "Earth", possibleAnswerOne: "Saturn", possibleAnswerTwo: "Pluto", possibleAnswerThree: "Mars")
    let questionSet2 = QuestionModel(question: "What is the largest planet in our solar system?", answer: "Jupiter", possibleAnswerOne: "Neptune", possibleAnswerTwo: "Saturn", possibleAnswerThree: "Sun")
    let questionSet3 = QuestionModel(question: "What is the chemical symbol for table salt?", answer: "NaCl", possibleAnswerOne: "H2O", possibleAnswerTwo: "Sa", possibleAnswerThree: "Cl")
    let questionSet4 = QuestionModel(question: "In what year did the French revolution began?", answer: "1789", possibleAnswerOne: "1780", possibleAnswerTwo: "1812", possibleAnswerThree: "1788")
    let questionSet5 = QuestionModel(question: "How many feet are in a mile?", answer: "5280", possibleAnswerOne: "5000", possibleAnswerTwo: "4280", possibleAnswerThree: "5820")
    let questionSet6 = QuestionModel(question: "The term wake, kettle, or committee refers to a group of what bird?", answer: "Vulture", possibleAnswerOne: "Crow", possibleAnswerTwo: "Red Bird", possibleAnswerThree: "Humming Bird")
    let questionSet7 = QuestionModel(question: "Which of the traditional five senses are dolphins believed not to possess?", answer: "smell", possibleAnswerOne: "sight", possibleAnswerTwo: "touch", possibleAnswerThree: "taste")
    let questionSet8 = QuestionModel(question: "Flamboyance is a group of what animal?", answer: "Flamingos", possibleAnswerOne: "Owls", possibleAnswerTwo: "Monkeys", possibleAnswerThree: "Cats")
    let questionSet9 = QuestionModel(question: "The Chihauahua is a breed of dog believed to originate from what country?", answer: "Mexico", possibleAnswerOne: "Alaska", possibleAnswerTwo: "Europe", possibleAnswerThree: "Spain")
    let questionSet10 = QuestionModel(question: "What is a group of whales called?", answer: "A pod", possibleAnswerOne: "A group", possibleAnswerTwo: "A family", possibleAnswerThree: "A mass")
    
    
    
    func randomQuestionSets(forNumberOfQuestionsInQuiz questions: Int) -> [QuestionModel] {
        var setsInQuiz = [QuestionModel]()
        var setsInDatabase = [QuestionSets().questionSet1, QuestionSets().questionSet2, QuestionSets().questionSet3, QuestionSets().questionSet4, QuestionSets().questionSet5, QuestionSets().questionSet6, QuestionSets().questionSet7, QuestionSets().questionSet8, QuestionSets().questionSet9, QuestionSets().questionSet10]
        var counter = 0
        
        for _ in 1...questions {
            counter = setsInDatabase.count
            let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: counter)
            setsInQuiz.append(setsInDatabase[randomNumber])
            setsInDatabase.remove(at: randomNumber)
        }
        
        return setsInQuiz
    }
    
    
}
