//
//  Util.swift
//  ShopmiumApp
//
//  Utilitary class providing miscellaneous helper methods.
//
//  Created by Lorenzo Di Vita on 13/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit


// MARK: -  Method to handle localized content

func loc(key: String) -> String {
    return NSLocalizedString(key, comment: "No key found")
}