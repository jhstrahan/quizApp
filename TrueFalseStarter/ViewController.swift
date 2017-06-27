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
    
                //var displayedQuestion = QuestionData()
                //var currentQuestionIndex = 0
    
    /// this number keeps track of correct answers
                //var currentAnswerIndex = 0

    var quizQuestionSet = [QuestionModel]()
    var possibleAnswers = [String]()
    
    var gameSound: SystemSoundID = 0
    /*
    var questionsInQuiz = QuestionData()
     @IBOutlet weak var answerOne: UIButton!
     @IBOutlet weak var Answer1: UIButton!
     @IBOutlet weak var answer1: UIButton!
    var numberOfQuestionsInQuiz = [Int]()
    var questionSet = [String]()
    var answerSet = [String]()
    */
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound(forSound: Sounds().start)
        
        // Start game
        playGameStartSound()
    
        quizQuestionSet = QuestionSets().randomQuestionSets(forNumberOfQuestionsInQuiz: 6)
        let firstQuestion = quizQuestionSet[questionsAsked].question
        questionField.text = firstQuestion
        
        
        
        
        let answersToQuestion = quizQuestionSet[questionsAsked].randomAnswersForButtons()
        answer1.setTitle(answersToQuestion[0], for: .normal)
        answer2.setTitle(answersToQuestion[1], for: .normal)
        answer3.setTitle(answersToQuestion[2], for: .normal)
        answer4.setTitle(answersToQuestion[3], for: .normal)
        
        
        playAgainButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayScore() {
        // Hide the answer buttons
        answer1.isHidden = true
        answer2.isHidden = true
        answer3.isHidden = true
        answer4.isHidden = true
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        correctAnswersInARow = 0
        
    }
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        
        
       
        let correctAnswer = quizQuestionSet[questionsAsked].answer
        
        if (sender === answer1 &&  correctAnswer == answer1.titleLabel?.text) || (sender === answer2 && correctAnswer == answer2.titleLabel?.text) || (sender === answer3 && correctAnswer == answer3.titleLabel?.text) || (sender === answer4 && correctAnswer == answer4.titleLabel?.text) {
            
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
            questionsAsked += 1
        } else {
            
            questionField.text = "Sorry, wrong answer!"
            loadGameStartSound(forSound: Sounds().wrong)
            playGameStartSound()
            correctAnswersInARow = 0
            questionsAsked += 1
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            
        } else {
            // Continue game
            
            let nextQestion = quizQuestionSet[questionsAsked].question
            questionField.text = nextQestion
            let answersToQuestion = quizQuestionSet[questionsAsked].randomAnswersForButtons()
            answer1.setTitle(answersToQuestion[0], for: .normal)
            answer2.setTitle(answersToQuestion[1], for: .normal)
            answer3.setTitle(answersToQuestion[2], for: .normal)
            answer4.setTitle(answersToQuestion[3], for: .normal)
        
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        answer1.isHidden = false
        answer2.isHidden = false
        answer3.isHidden = false
        answer4.isHidden = false
        playAgainButton.isHidden = true
        
        questionsAsked = 0
        correctQuestions = 0
        
        quizQuestionSet = QuestionSets().randomQuestionSets(forNumberOfQuestionsInQuiz: 6)
        let newQuestionSet = quizQuestionSet[questionsAsked]
        let newQuestion = newQuestionSet.question
        questionField.text = newQuestion
        
        possibleAnswers = newQuestionSet.randomAnswersForButtons()
        answer1.setTitle(possibleAnswers[0], for: .normal)
        answer2.setTitle(possibleAnswers[1], for: .normal)
        answer3.setTitle(possibleAnswers[2], for: .normal)
        answer4.setTitle(possibleAnswers[3], for: .normal)
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

