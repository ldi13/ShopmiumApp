//
//  SignUpViewController.swift
//  ShopmiumApp
//
//  Screen dedicated to sign-up feature.
//
//  Created by Lorenzo Di Vita on 13/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController
{
    // MARK: - IBOutlets
    
    @IBOutlet weak var testLabel: UILabel!
    
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.testLabel.text = loc("test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
