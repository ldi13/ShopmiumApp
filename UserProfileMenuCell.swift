//
//  UserProfileMenuCell.swift
//  ShopmiumApp
//
//  Cell representing user profile into left menu.
//
//  Created by Lorenzo Di Vita on 20/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class UserProfileMenuCell: UITableViewCell
{
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    // MARK: - Custom methods
    
    func refreshCell() {
        self.emailLabel.text = User.sharedInstance.email
    }
}
