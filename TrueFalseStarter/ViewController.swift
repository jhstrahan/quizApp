//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 5
    var questionsAsked = 0
    var correctQuestions = 0
    var correctAnswersInARow = 0
    
    var displayedQuestion = QuestionData()
    var currentQuestionIndex = 0
    /// this number keeps track of correct answers
    var currentAnswerIndex = 0

    
    var gameSound: SystemSoundID = 0
    
    var questionsInQuiz = QuestionData()
    var numberOfQuestionsInQuiz = [Int]()
    var questionSet = [String]()
    var answerSet = [String]()
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound(forSound: Sounds().start)
        
        // Start game
        playGameStartSound()
    
        numberOfQuestionsInQuiz = questionsInQuiz.indexArray(withNumberOfIndexes: 5)
        questionSet = questionsInQuiz.displayQuestion(fromQuestionsList: numberOfQuestionsInQuiz).questions
        answerSet = questionsInQuiz.displayQuestion(fromQuestionsList: numberOfQuestionsInQuiz).answers
        let firstQuestion = questionSet[0]
        questionField.text = firstQuestion
        currentAnswerIndex = 0
        playAgainButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayScore() {
        // Hide the answer buttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        correctAnswersInARow = 0
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
       
        let correctAnswer = answerSet[currentAnswerIndex]
        
        if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
            correctQuestions += 1
            correctAnswersInARow += 1
            
            if correctAnswersInARow == 0 {
                loadGameStartSound(forSound: Sounds().correct1)
                playGameStartSound()
            } else if correctAnswersInARow == 1 {
                loadGameStartSound(forSound: Sounds().correct2)
                playGameStartSound()
            } else if correctAnswersInARow == 2 {
                loadGameStartSound(forSound: Sounds().correct3)
                playGameStartSound()
            } else if correctAnswersInARow == 3 {
                loadGameStartSound(forSound: Sounds().correct4)
                playGameStartSound()
            } else if correctAnswersInARow == 4 {
                loadGameStartSound(forSound: Sounds().correct5)
                playGameStartSound()
            } else if correctAnswersInARow == 5 {
                loadGameStartSound(forSound: Sounds().correct6)
                playGameStartSound()
            }
            questionField.text = "Correct!"
        } else {
            
            questionField.text = "Sorry, wrong answer!"
            loadGameStartSound(forSound: Sounds().wrong)
            playGameStartSound()
            correctAnswersInARow = 0
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            
        } else {
            // Continue game
            currentQuestionIndex += 1
            let nextQestion = questionSet[currentQuestionIndex]
            questionField.text = nextQestion
            currentAnswerIndex += 1
        
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        trueButton.isHidden = false
        falseButton.isHidden = false
        playAgainButton.isHidden = true
        
        questionsAsked = 0
        correctQuestions = 0
        currentAnswerIndex = 0
        currentQuestionIndex = 0
        numberOfQuestionsInQuiz = questionsInQuiz.indexArray(withNumberOfIndexes: 5)
        questionSet = questionsInQuiz.displayQuestion(fromQuestionsList: numberOfQuestionsInQuiz).questions
        answerSet = questionsInQuiz.displayQuestion(fromQuestionsList: numberOfQuestionsInQuiz).answers
        let newQuestion = questionSet[0]
        questionField.text = newQuestion
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound(forSound sound: String) {
        let pathToSoundFile = Bundle.main.path(forResource: sound, ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
 
}

