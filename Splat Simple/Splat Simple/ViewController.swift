//
//  ViewController.swift
//  Splat Simple
//
//  Created by Matthew Falzon on 21/06/2015.
//  Copyright (c) 2015 Matthew Falzon. All rights reserved.
//

// LayerOne not swiped, ball will spawn on LayerTwo
// LayerTwo not swiped, ball will spawn on LayerOne

// LayerOne swiped, ball will spawn on LayerOne


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var layerOne: ballImageView!
    @IBOutlet weak var layerTwo: ballImageView!
    @IBOutlet weak var scoreCounter: UILabel!
    
    var blueImage = UIImage(named:"blue")
    var redImage = UIImage(named:"red")
    
    var timeOfSpawn: NSDate = NSDate()
    
    var score = 0 {
        didSet {
            updateScore()
        }
    }
    
    let blue = 0
    let red = 1
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // Return next ball
    func nextLayer() -> ballImageView {
        return layerTwo
    }
    
    // Return in front
    func currentLayer() -> ballImageView {
        return layerTwo
    }
    
    func createBall(anyLayer:ballImageView) {
        
        let colouredBalls = [blueImage, redImage]
        let randomImage = Int(arc4random_uniform(UInt32(colouredBalls.count)))
        
        anyLayer.colour = randomImage
        anyLayer.image = colouredBalls[randomImage]
        anyLayer.alpha = 0
        anyLayer.hidden = false
        
        timeOfSpawn = NSDate()
        
        UIView.animateWithDuration(1, animations: {
            anyLayer.alpha = 1.0
        })
        
    }
    
    func createNextBall(swipedLayer:ballImageView) {
        
        swipedLayer.alpha = 0
        self.view.addSubview(swipedLayer)
        swipedLayer.hidden = true
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var layers = [layerOne, layerTwo]
        setupGame()
        
    }
    
    // Update Function
    func update() {
        
        var difference = timeOfSpawn.timeIntervalSinceNow;
        if (difference < -2) {
            createBall(nextLayer())
//            println("2 Seconds has passed");
        }
    
    }
    
    func setupGame () {
        
        // Timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
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
    
    // Update Score
    func updateScore() {
        scoreCounter.text = "\(score)"
    }
    
    // Swipe Functions
    func upSwiped() {
        var curLayer = currentLayer()
        if curLayer.colour == red {
            score++
            createNextBall(curLayer)
            println("Correct Red")
        } else {
            println("Game Over")
            let alert = UIAlertController(title: "Game Over",
                message: "You scored \(score) points",
                preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.restartedGame()
            }))
            
            alert.addAction(UIAlertAction(title: "Home", style: UIAlertActionStyle.Default, handler: {
                action in self.performSegueWithIdentifier("backToHome", sender: self)
            }))
            
            presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    func downSwiped() {
        var curLayer = currentLayer()
        if curLayer.colour == blue {
            score++
            createNextBall(curLayer)
            println("Correct Blue")
        } else {
            println("Game Over")
            let alert = UIAlertController(title: "Game Over",
                message: "You scored \(score) points",
                preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.restartedGame()
            }))
            
            alert.addAction(UIAlertAction(title: "Home", style: UIAlertActionStyle.Default, handler: {
                action in self.performSegueWithIdentifier("backToHome", sender: self)
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

