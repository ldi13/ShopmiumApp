//
//  OnBoardViewController.swift
//  ShopmiumApp
//
//  Screen to display when on-board effective.
//
//  Created by Lorenzo Di Vita on 19/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class OnBoardViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.setUpNavigationBar("Welcome to Shopmium !")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
