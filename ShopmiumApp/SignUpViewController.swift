//
//  SignUpViewController.swift
//  ShopmiumApp
//
//  Screen dedicated to sign-up feature.
//
//  Created by Lorenzo Di Vita on 14/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController
{
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserRequest.signUpUser("dididi@test.com", successCompletionHandler: {
            (result) in
                println(result)
            }, errorCompletionHandler: {
                (error) in
                    println(error)
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
