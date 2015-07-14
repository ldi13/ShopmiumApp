//
//  HomeViewController.swift
//  ShopmiumApp
//
//  Screen displaying home.
//
//  Created by Lorenzo Di Vita on 13/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    // MARK: - IBOutlets
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // UI customization
        self.customizeSignUpButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Custom methods
    
    func customizeSignUpButton()
    {
        self.signUpButton.setTitle(loc("Home.sign.up.button.title"), forState: UIControlState.Normal)
        self.signUpButton.drawRoundedCorners(CGFloat(5))
    }
    
    
    // MARK: - IBAction methods
    
    @IBAction func signUp(sender: UIButton) {
        self.performSegueWithIdentifier(SegueIdentifiers.SIGN_UP.rawValue, sender: nil)
    }
}
