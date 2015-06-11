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
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var redColour: UIImageView!
    @IBOutlet weak var blueColour: UIImageView!
    
    func randomNumberFunc() -> Int {
        return Int(arc4random_uniform(3))
    }
    
//    var randomNumber = Int(arc4random_uniform(2)+1)
    
    var randomColour = ["Red", "Blue"]

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
//    @IBAction func swipe(sender: UISwipeGestureRecognizer) {
//        
//        switch sender.direction {
//        case UISwipeGestureRecognizerDirection.Up:
//            println("Swiped up")
//        case UISwipeGestureRecognizerDirection.Down:
//            println("Swiped down")
//        default:
//            break
//        }
//    }
    
    @IBAction func startButton(sender: AnyObject) {
        
        number.text = "\(randomNumberFunc())"
        
        //------------right  swipe gestures in view--------------//
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("rightSwiped"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        //-----------left swipe gestures in view--------------//
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("leftSwiped"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        //-----------down swipe gestures in view--------------//
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("downSwiped"))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        //-----------up swipe gestures in view--------------//
        let swipeUp = UISwipeGestureRecognizer(target: self, action: Selector("upSwiped"))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        number.text = String(randomNumberFunc())
    }
    
    func rightSwiped() {
        println("right swiped")
    }
    
    func leftSwiped() {
        println("left swiped")
    }
    
    func downSwiped() {
        if randomNumberFunc() == 2 {
            result.text = "True"
        } else {
            result.text = "False"
        }
    }
    
    func upSwiped() {
        if randomNumberFunc() == 1 {
            number.text = "\(randomNumberFunc())"
        } else {
            result.text = "False"
        }
    }
    
    
}


