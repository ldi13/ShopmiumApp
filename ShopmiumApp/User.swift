//
//  User.swift
//  ShopmiumApp
//
//  Singleton design for user.
//
//  Created by Lorenzo Di Vita on 21/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class User: NSObject
{
    // MARK: - Singleton
    
    static let sharedInstance = User()

    
    // MARK: - Properties
    
    var email: String!
    var response: String!

    
    // MARK: - Constructors
    
    override init() {
        // Empty
    }
    
    
    // MARK: - Custom methods
    
    func refreshUserWithJSON(JSON: [String: AnyObject]) {
        self.email = (JSON["profile"] as! [String: AnyObject])["email"] as! String
    }
}
