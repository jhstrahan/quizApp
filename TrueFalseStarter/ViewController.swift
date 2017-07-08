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
    
    // stored values for conters and number of questions per round
    let questionsPerRound = 5
    var questionsAsked = 0
    var correctQuestions = 0
    var correctAnswersInARow = 0
    
    
    // stored values for lightening round
    var lighteningTimer = Timer()
    var lighteningRound = Bool()
    var seconds = 45
    var isTimerRunning = false
    
    // stored values for the quiz questions and answers
    var quizQuestionSet = [QuestionModel]()
    var possibleAnswers = [String]()
    
    var gameSound: SystemSoundID = 0
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var correctWrong: UILabel!
    @IBOutlet weak var lighteningCountDown: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound(forSound: Sounds().start)
        
        // Start game
        lighteningRound = true
        runTimer()
        playGameStartSound()
        correctWrong.alpha = 0
        lighteningCountDown.alpha = 1
        lighteningCountDown.text = String(seconds)
    
        quizQuestionSet = QuestionSets().randomQuestionSets(forNumberOfQuestionsInQuiz: 6)
        let firstQuestion = quizQuestionSet[questionsAsked].question
        questionField.text = firstQuestion
        
        
        
        
        
        
        // round the corners of each buttion
        answer1.layer.cornerRadius = 10
        answer2.layer.cornerRadius = 10
        answer3.layer.cornerRadius = 10
        answer4.layer.cornerRadius = 10
        
        // set titiles for buttons from asnwers to question.
        // questionsAsked provides an index of the array of quizQuestionSet
        let answersToQuestion = quizQuestionSet[questionsAsked].randomAnswersForNumber(ofButtons: quizQuestionSet[questionsAsked].numberOfPossibleAnswersToQuestion())
        setTitleForButtonsWith(answers: answersToQuestion)
        
        /*
        answer1.setTitle(answersToQuestion[0], for: .normal)
        answer2.setTitle(answersToQuestion[1], for: .normal)
        answer3.setTitle(answersToQuestion[2], for: .normal)
        answer4.setTitle(answersToQuestion[3], for: .normal)
        */
        
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
            
            //dimButtons(exceptChosen: sender)
            
            // play sounds corresponding with correctAnswersInARow
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
            correctWrong.alpha = 1
            correctWrong.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            correctWrong.text = "Correct!"
            questionsAsked += 1
        } else {
            correctWrong.alpha = 1
            correctWrong.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            correctWrong.text = "The correct answer is \(correctAnswer)"
            
            //dimButtons(exceptChosen: sender)
            loadGameStartSound(forSound: Sounds().wrong)
            playGameStartSound()
            correctAnswersInARow = 0
            questionsAsked += 1
        }
        if Int(lighteningCountDown.text!)! >= 4 && questionsAsked <= 4 {
            loadNextRoundWithDelay(seconds: 2)
        } else if Int(lighteningCountDown.text!)! < 4 || questionsAsked == 5 {
            nextRound()
        }
        dimButtons(exceptChosen: sender)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            self.view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            lighteningRound = false
            
            lighteningTimer.invalidate()
            lighteningCountDown.alpha = 0
            correctWrong.alpha = 0
            questionField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            seconds = 15
            lighteningCountDown.text = timeString(time: TimeInterval(seconds))
            
        } else {
            // Continue game
            brightenButtons()
            correctWrong.alpha = 0
            let nextQestion = quizQuestionSet[questionsAsked].question
            questionField.text = nextQestion
            let answersToQuestion = quizQuestionSet[questionsAsked].randomAnswersForNumber(ofButtons: quizQuestionSet[questionsAsked].numberOfPossibleAnswersToQuestion())
            setTitleForButtonsWith(answers: answersToQuestion)
            /*
            answer1.setTitle(answersToQuestion[0], for: .normal)
            answer2.setTitle(answersToQuestion[1], for: .normal)
            answer3.setTitle(answersToQuestion[2], for: .normal)
            answer4.setTitle(answersToQuestion[3], for: .normal)
             */
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
        
        possibleAnswers = quizQuestionSet[questionsAsked].randomAnswersForNumber(ofButtons: quizQuestionSet[questionsAsked].numberOfPossibleAnswersToQuestion())
        setTitleForButtonsWith(answers: possibleAnswers)
        /*
        answer1.setTitle(possibleAnswers[0], for: .normal)
        answer2.setTitle(possibleAnswers[1], for: .normal)
        answer3.setTitle(possibleAnswers[2], for: .normal)
        answer4.setTitle(possibleAnswers[3], for: .normal)
        */
        runTimer()
        self.view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        questionField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        correctWrong.alpha = 0
        brightenButtons()
        seconds = 45
        lighteningCountDown.alpha = 1
        lighteningCountDown.text = timeString(time: TimeInterval(seconds))
    }
    

    
    // MARK: Helper Methods
    
            // Set title for buttons detirmened by number of possible answers
    func setTitleForButtonsWith(answers: [String]) {
        let fourButtonArray = [answer1, answer2, answer3, answer4]
        let threeButtonArray = [answer1, answer2, answer3]
        var index = 0
        if answers.count == 4 {
            brightenButtons()
            for button in fourButtonArray {
                button?.setTitle(answers[index], for: .normal)
                if index <= 4 {
                 index += 1
                }
            }
        } else if answers.count == 3 {
            for button in threeButtonArray {
                button?.setTitle(answers[index], for: .normal)
                if index <= 3 {
                    index += 1
                }
            }
            answer4.alpha = 0
            answer4.isEnabled = false
        }
    }

            // Quiz timing to start lightening round
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
    /*
    
    func lighteningRoundWithRemaining(seconds: Int) {
        let totalTime = Int64(NSEC_PER_SEC * UInt64(seconds))
        let dispatchTime = DispatchTime.now() + Double(totalTime) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            if self.lighteningRound == true {
                self.view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                self.displayScore()
                self.correctWrong.alpha = 1
                self.correctWrong.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.correctWrong.text = "Time's up!"
                self.lighteningCountDown.alpha = 0
                self.lighteningTimer.invalidate()
                
            } else {
                print("game over")
            }
        }
        
    }
    
    func lighteningRoundWithDelay(ofSeconds start: Int) {
        let regularTime = Int64(NSEC_PER_SEC * UInt64(start))
        
        let startLighteningRound = DispatchTime.now() + Double(regularTime) / Double(NSEC_PER_SEC)
        
        
        
            if lighteningRound == true {
                DispatchQueue.main.asyncAfter(deadline: startLighteningRound) {
                    self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                    self.questionField.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                    self.loadGameStartSound(forSound: Sounds().start)
                    self.playGameStartSound()
                    self.lighteningRoundWithRemaining(seconds: 15)
                    self.lighteningCountDown.alpha = 1
                    self.runTimer()
                    
            }
        }
    }
    
 */
            // Timer during lightening mode
    func runTimer() {
        lighteningTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        seconds -= 1
        if Int(lighteningCountDown.text!)! > 15 {
            self.view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            self.questionField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lighteningCountDown.alpha = 1
            lighteningCountDown.text = timeString(time: TimeInterval(seconds))
        } else if Int(lighteningCountDown.text!)! <= 15 && Int(lighteningCountDown.text!)! >= 1 {
            lighteningCountDown.alpha = 1
            lighteningCountDown.text = timeString(time: TimeInterval(seconds))
            loadGameStartSound(forSound: Sounds().start)
            playGameStartSound()
            view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            questionField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lighteningCountDown.textColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        } else if Int(lighteningCountDown.text!)! == 0 {
            lighteningCountDown.alpha = 0
            view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            displayScore()
            correctWrong.alpha = 1
            correctWrong.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            correctWrong.text = "Time's up!"
            lighteningTimer.invalidate()
            
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let seconds = Int(time) % 60
        return String(seconds)
    }
    
    
            // loading and playing sounds
    func loadGameStartSound(forSound sound: String) {
        let pathToSoundFile = Bundle.main.path(forResource: sound, ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    // dim buttons not chosen
    func dimButtons(exceptChosen button: UIButton) {
        let fourButtonArray = [answer1, answer2, answer3, answer4]
        let threeButtonArray = [answer1, answer2, answer3]
        if answer4.isEnabled == true {
            for buttons in fourButtonArray {
                buttons?.isEnabled = false
                if button != buttons {
                    buttons?.alpha = 0.5
                }
            }
        } else {
            for buttons in threeButtonArray {
                buttons?.isEnabled = false
                if button != buttons {
                    buttons?.alpha = 0.5
                }
            }
        }
    }
    
    // brighten all buttons
    func brightenButtons() {
        let buttonArray = [answer1, answer2, answer3, answer4]
        for buttons in buttonArray {
           
                buttons?.alpha = 1
                buttons?.isEnabled = true
        }
    }
}

