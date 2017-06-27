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
    let questionSet1 = QuestionModel(question: "Paul introduces himself as an apostle of Christ Jesus by what?", answer: "the command of God", possibleAnswerOne: "his choice to obey", possibleAnswerTwo: "the vote of the church", possibleAnswerThree: "his love for the nations")
    let questionSet2 = QuestionModel(question: "Paul calls Timothy his ______", answer: "true child in the faith", possibleAnswerOne: "close friend in Christ", possibleAnswerTwo: "dicsiple", possibleAnswerThree: "partner in ministry")
    let questionSet3 = QuestionModel(question: "Paul is asking Timothy to remain in Ephesus. Why?", answer: "To correct a teaching problem in the church", possibleAnswerOne: "To collect money", possibleAnswerTwo: "To perform miracles", possibleAnswerThree: "to deliver a letter")
    let questionSet4 = QuestionModel(question: "Teachers in Ephesus were ______", answer: "all to the above", possibleAnswerOne: "teaching false doctrine", possibleAnswerTwo: "arguing about meaningless things", possibleAnswerThree: "focused on the wrong goal")
    let questionSet5 = QuestionModel(question: "According to Paul, the law is good if ______?", answer: "it is used lawfully", possibleAnswerOne: "it is read in Hebrew", possibleAnswerTwo: "it is written down", possibleAnswerThree: "it applies to our situation")
    let questionSet6 = QuestionModel(question: "What does Paul mean when he says that the law is not for the just?", answer: "The law does not depense grace.", possibleAnswerOne: "The just don't have to obey God.", possibleAnswerTwo: "The law isn't useful anymore.", possibleAnswerThree: "The law is only for people who believe it.")
    let questionSet7 = QuestionModel(question: "From where did Paul receive strength?", answer: "Christ Jesus", possibleAnswerOne: "the Word", possibleAnswerTwo: "the church", possibleAnswerThree: "the law")
    let questionSet8 = QuestionModel(question: "Why did Paul receive mercy?", answer: "He acted in unbelief.", possibleAnswerOne: "He performed the right services.", possibleAnswerTwo: "He paid enough money to the church.", possibleAnswerThree: "He deserved it.")
    let questionSet9 = QuestionModel(question: "Paul views himself as ______", answer: "a picture of God's patience", possibleAnswerOne: "a super Christian", possibleAnswerTwo: "an important person", possibleAnswerThree: "a master teacher")
    let questionSet10 = QuestionModel(question: "Why does Paul charge Timothy to wage the good warefare?", answer: "The problem was spiritual.", possibleAnswerOne: "It has a ring to it.", possibleAnswerTwo: "Timothy would lead an army.", possibleAnswerThree: "Paul is dramatic.")
    
    
    
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
