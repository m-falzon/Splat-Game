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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var UITapRecognizer = UITapGestureRecognizer(target: self, action: "tappedTapped:")
        UITapRecognizer.delegate = self
        self.startButton.addGestureRecognizer(UITapRecognizer)
        self.startButton.userInteractionEnabled = true
    }

    func tappedTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("segueToGame", sender: self)
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
