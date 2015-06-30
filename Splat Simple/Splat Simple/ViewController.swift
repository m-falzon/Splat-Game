//
//  ViewController.swift
//  Splat Simple
//
//  Created by Matthew Falzon on 21/06/2015.
//  Copyright (c) 2015 Matthew Falzon. All rights reserved.
//

// LayerOne not swiped, ball will spawn on LayerTwo
// Top layer swiped, LayerTwo will become layerOne

// LayerOne swiped, ball will spawn on LayerOne


import UIKit

let BALL_INTERVAL:NSTimeInterval = 2

let MAX_BALLS = 3

let BALL_VERTICAL_POSITION_OFFSET:CGFloat = -15

let BALL_TIME_REDUCE_RATIO = 0.1

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreCounter: UILabel!
    
    let topColourBallImage:UIImage = UIImage(named:"red")!
    let bottomColourBallImage:UIImage = UIImage(named:"blue")!
    
    var isGameOver = true
    
    var colouredBallImages:[UIImage] = []
    
    var balls:[UIImageView] = []
    
    var currentLayerIndex = 0
    
    var score = 0 {
        didSet {
            updateScore()
        }
    }
    
    var screenDimensions:(width:CGFloat, height:CGFloat) {
        get {
            let screenRect = UIScreen.mainScreen().bounds
            return (width:screenRect.size.width, height:screenRect.size.height)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func currentBall() -> UIImageView {
        return balls.first!
    }
    
    // 1. Check if we can keep playing
    // 2. Get a new ball instance based on available colours
    // 3. Add to list of balls currently in play
    // 4. Set timer for when new ball should be created
    func createBall() {
        
        // If we've reached the max amount of balls, it's game over
        if isMaxBalls() {
            return gameOver()
        }
        
        let randomImage:UIImage = colouredBallImages[Int(arc4random_uniform(UInt32(colouredBallImages.count)))]
        
        let newBall:UIImageView = UIImageView(image: randomImage)
        newBall.layer.borderColor = UIColor.whiteColor().CGColor
        newBall.layer.cornerRadius = 50
        newBall.layer.masksToBounds = true
        newBall.layer.borderWidth = 1
        
        // Calcuate vertical ball offset
        let verticalOffset = CGFloat(balls.count) * BALL_VERTICAL_POSITION_OFFSET
        
        // Calculate ball position
        let ballPositionX = (screenDimensions.width/2)-(randomImage.size.width/2)
        let ballPositionY = (screenDimensions.height/2)-(randomImage.size.height/2) + verticalOffset
        
        // Position new ball
        newBall.frame = CGRect(x: ballPositionX, y: ballPositionY, width: randomImage.size.width, height:randomImage.size.height)
        
        balls.append(newBall)
        
        self.view.insertSubview(newBall, atIndex: 0)
        
        // Reduce timer between ball drops
        NSTimer.scheduledTimerWithTimeInterval(BALL_INTERVAL - (Double(score) * BALL_TIME_REDUCE_RATIO), target: self, selector: Selector("createBall"), userInfo: nil, repeats: false)
    }
    
    // 1. Remove current ball from balls
    // 2. Remove that ball from self.view
    func removeBall() {
        let currentBallIndex = find(balls, currentBall())

        // The position of the ballIndex is certain to match the view index as that is the rule that createBall enforces.
        // Therefore, because we have the currentBallIndex value, we know which subview to remove
        let ballToRemove = balls.removeAtIndex(currentBallIndex!)
        
        ballToRemove.removeFromSuperview()
        
        repositionBalls()
    }
    
    // 1. On swipe, if more than one ball on the screen, drop each ball down into the next balls position
    func repositionBalls() {
        for ball in balls {
            let ballOrigin = ball.frame.origin
            let ballYPosition = ballOrigin.y  + (-1 *  BALL_VERTICAL_POSITION_OFFSET)
            ball.frame.origin = CGPoint(x: ballOrigin.x, y: ballYPosition)
        }
    }
    
    func isMaxBalls() -> Bool{
        return balls.count == MAX_BALLS
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the possible colours to choose from
        colouredBallImages.append(topColourBallImage)
        colouredBallImages.append(bottomColourBallImage)
        
        setupGame()
        
    }
    
    func setupGame () {
        
        // MARK: Swipe Gestures
        
        //-----------up swipe gestures in view--------------//
        let swipeUp = UISwipeGestureRecognizer(target: self, action: Selector("upSwiped"))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        
        //-----------down swipe gestures in view--------------//
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("downSwiped"))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        createBall()
        
    }
    
    // Update Score
    func updateScore() {
        scoreCounter.text = "\(score)"
    }
    
    
    // Swiping algorithm
    
    // 1. Get the ball image of the top layer
    // 2. On swipe, check if ball colour matches the swipe direction
    // 3. If correct, remove ball, else game over
    
    func upSwiped() {
//       if isGameOver {
//            return
//        }
        
        if currentBall().image == topColourBallImage {
            correctSwipe()
        }
        else {
            gameOver()
        }
    }
    
    func downSwiped() {
//        if isGameOver {
//            return
//        }
        
        if currentBall().image == bottomColourBallImage {
            correctSwipe()
        }
        else {
            gameOver()
        }
    }
    
    func correctSwipe() {
        score += 1
        removeBall()
    }
    
    func gameOver() {
        isGameOver = true
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
    
    func restartedGame() {
        score = 0
        setupGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

