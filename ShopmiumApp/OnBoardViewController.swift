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
    // MARK: - IBOutlets
    
    @IBOutlet weak var responseLabel: UILabel!
    
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.responseLabel.text = User.sharedInstance.response
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.setUpNavigationBar(loc("On.board.navbar.title"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
