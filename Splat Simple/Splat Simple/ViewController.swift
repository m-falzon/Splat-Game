//
//  ViewController.swift
//  Splat Simple
//
//  Created by Matthew Falzon on 21/06/2015.
//  Copyright (c) 2015 Matthew Falzon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redBall: UIImageView!
    @IBOutlet weak var blueBall: UIImageView!
    @IBOutlet weak var scoreCounter: UILabel!
    
    var score = 0 {
        didSet {
            updateScore()
        }
    }
    
    func createBall() {
        
        let colouredBalls = [blueBall, redBall]
        let randomBallColour = Int(arc4random_uniform(UInt32(colouredBalls.count)))
        
        (colouredBalls[randomBallColour]).hidden = false
        
    }
    
    func createNextBall() {
        
        self.blueBall.alpha = 0
        self.redBall.alpha = 0
        
        self.view.addSubview(blueBall)
        self.view.addSubview(redBall)
        
        UIView.animateWithDuration(1, animations: {
            self.blueBall.alpha = 1.0
            self.redBall.alpha = 1.0
        })
        
        blueBall.hidden = true
        redBall.hidden = true
        let colouredBalls = [blueBall, redBall]
        let randomBallColour = Int(arc4random_uniform(UInt32(colouredBalls.count)))
        
        (colouredBalls[randomBallColour]).hidden = false
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupGame()
        
    }
    
    // Update Function
    func update() {
        createBall()
        println("Spawned")
    }
    
    func updateScore() {
        scoreCounter.text = "\(score)"
    }
    
    func setupGame () {
        
        // Timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: false)
        
        // MARK: Swipe Gestures
        
        //-----------up swipe gestures in view--------------//
        let swipeUp = UISwipeGestureRecognizer(target: self, action: Selector("upSwiped"))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        
        //-----------down swipe gestures in view--------------//
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("downSwiped"))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    // Swipe Functions
    func upSwiped() {
        if blueBall.hidden {
            score++
            createNextBall()
            println("Correct")
        } else {
            println("Game Over")
            let alert = UIAlertController(title: "Game Over",
                message: "You scored \(score) points",
                preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.restartedGame()
            }))
            
            alert.addAction(UIAlertAction(title: "Home", style: UIAlertActionStyle.Default, handler: {
                action in self.setupGame()
            }))
            
            presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    func downSwiped() {
        if redBall.hidden {
            score++
            createNextBall()
            println("Correct")
        } else {
            println("Game Over")
            let alert = UIAlertController(title: "Game Over",
                message: "You scored \(score) points",
                preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.restartedGame()
            }))
            presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    func restartedGame() {
        score = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

