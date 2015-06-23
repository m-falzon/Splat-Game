//
//  ViewController.swift
//  Splat
//
//  Created by Matthew Falzon on 9/06/2015.
//  Copyright (c) 2015 Matthew Falzon. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ballSpotOne: UIImageView!
    @IBOutlet weak var ballSpotTwo: UIImageView!
    @IBOutlet weak var ballSpotThree: UIImageView!

    @IBOutlet weak var redBall: UIImageView!
    @IBOutlet weak var blueBall: UIImageView!
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var result: UILabel!
    
    func createBall() {
        
        let colouredBalls = [
            UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), // Red
            UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0) // Blue
        ]
        
        let randomBallColour = Int(arc4random_uniform(UInt32(colouredBalls.count)))
        
        ballSpotOne.tintColor = UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0)
        
    }
    
    func randomizeColor() {
        
        let colours = [redBall, blueBall]
        let randomIndex = Int(arc4random_uniform(UInt32(colours.count)))
        (colours[randomIndex]).hidden = false
        
    }
    
    func onlyShowOne() {
        
        if blueBall.hidden {
            redBall.hidden = false
        } else if redBall.hidden {
            blueBall.hidden = false
        }
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // Timer
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        // MARK: Swipe Gestures
        
        
        //-----------down swipe gestures in view--------------//
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("downSwiped"))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        //-----------up swipe gestures in view--------------//
        let swipeUp = UISwipeGestureRecognizer(target: self, action: Selector("upSwiped"))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        }
    
    
        // Update Function
    
        func update() {
            createBall()
        }
    
        func downSwiped() {
            if redBall.hidden {
                result.text = "Correct"
                println("swipe down")
            } else {
                result.text = "Wrong"
            }
        }
    
        func upSwiped() {
            if blueBall.hidden {
                result.text = "Correct"
                println("swipe up")
            } else {
                result.text = "Wrong"
            }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}