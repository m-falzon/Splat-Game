//
//  HomeViewController.swift
//  Splat Simple
//
//  Created by Matthew Falzon on 23/06/2015.
//  Copyright (c) 2015 Matthew Falzon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var startButton: UIImageView!
    @IBOutlet weak var howToButton: UIImageView!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var UIPlayTapRecognizer = UITapGestureRecognizer(target: self, action: "playTapped:")
        UIPlayTapRecognizer.delegate = self
        self.startButton.addGestureRecognizer(UIPlayTapRecognizer)
        self.startButton.userInteractionEnabled = true
        
        var UIHowToTapRecognizer = UITapGestureRecognizer(target: self, action: "howToTapped:")
        UIHowToTapRecognizer.delegate = self
        self.howToButton.addGestureRecognizer(UIHowToTapRecognizer)
        self.howToButton.userInteractionEnabled = true
        
    }

    func playTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("segueToGame", sender: self)
    }

    func howToTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("segueToHowTo", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
