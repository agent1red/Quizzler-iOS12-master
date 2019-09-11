//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Audio
    var audioPlayer : AVAudioPlayer!
    
    var selectedSoundFileNameMP3 : String = ""
    var selectedSoundFileNameWave : String = ""
    let soundArray = ["correct", "negative"]
    
    // Initialize the new question bank object
    let allQuestions = QuestionBank()
    var questionListSize : Int = 0
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0 // keep track of the state of the app
    var score : Int = 0 // keep track of score
    
    //Place your instance variables here
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        questionListSize = allQuestions.list.count
        super.viewDidLoad()
        MusicPlayer.shared.startBackgroundMusic()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        // true/false tag true tag 1 false is tag 2
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Your Score is: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        
        progressWidth.constant = (view.frame.size.width / CGFloat(questionListSize)) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        
        if  questionNumber <= allQuestions.list.count - 1 {
            // put into question label by setting the question label text to equal firstQuestion text
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            
            
            let alert = UIAlertController(title: "Awesome!", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart?", style: .default, handler: { (UIAlertAction) in self.startOver()
            })
            alert.addAction(restartAction)
            //add Grand Central Dispatch for timer for alert window
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1300)) {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        if correctAnswer == pickedAnswer {
            score += 1
            ProgressHUD.showSuccess("Correct!")
            playSound(soundChoice: soundArray[0])
        } else {
            ProgressHUD.showError("Wrong!")
            playSound(soundChoice: soundArray[1])
        }
    }
    
    
    func startOver() {
       questionNumber = 0
       score = 0
       nextQuestion()
    }
    
    func playSound(soundChoice : String){
        selectedSoundFileNameMP3 = soundArray[0]
        selectedSoundFileNameWave = soundArray[1]
        let soundURLMP3 = Bundle.main.url(forResource: selectedSoundFileNameMP3, withExtension: "mp3")
        let soundURLWave = Bundle.main.url(forResource: selectedSoundFileNameWave, withExtension: "wav")
        
        if soundChoice ==  soundArray[0]  {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURLMP3!)
            } catch {
                print(error)
            }
            audioPlayer.play()
        } else if soundChoice ==  soundArray[1] {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURLWave!)
            } catch {
                print(error)
            }
            audioPlayer.play()
        }
        
    }
    

    
}
