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
    
    @IBOutlet weak var ball: UIImageView!
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var result: UILabel!
    
    
    func randomizeColor() {
        
        var red = UIColor(red: (221/255.0), green: (0/255.0), blue: (37/255.0), alpha: 1.0)
        var blue = UIColor(red: (160/255.0), green: (97/255.0), blue: (5/255.0), alpha: 1.0)
        
        var colours = [red, blue]
        
        ball.tintColor = blue
        
    }

    func randomNumberFunc() -> Int {
        return Int(arc4random_uniform(2)+1)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // Timer
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        number.text = "\(randomNumberFunc())"

        
        
        // MARK: Swipe Gestures
        
//        //------------right  swipe gestures in view--------------//
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("rightSwiped"))
//        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
//        self.view.addGestureRecognizer(swipeRight)
//        
//        //-----------left swipe gestures in view--------------//
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("leftSwiped"))
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
//        self.view.addGestureRecognizer(swipeLeft)
        
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
            randomNumberFunc()
        }
    
    
        // Swipe Functions
    
//        func rightSwiped() {
//            println("right swiped")
//        }
//    
//        func leftSwiped() {
//            println("left swiped")
//        }
    
        func downSwiped() {
            if randomNumberFunc() == 2 {
                result.text = "True"
                println("swipe down")
            } else {
                result.text = "False"
            }
        }
    
        func upSwiped() {
            if randomNumberFunc() == 1 {
                result.text = "True"
                println("swipe up")
            } else {
                result.text = "False"
            }
        }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}