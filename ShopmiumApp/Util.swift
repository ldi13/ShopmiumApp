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


// MARK: - Method to trigger on screen an alert view

func showAlertView(title: String!, message: String!)
{
    let alertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
    alertView.show()
}


// MARK: - Method serializing a dictionary into string

func serializeToJSON(dictionary: AnyObject) -> String {
    return SDJSONPrettyPrint.stringFromJSONObject(dictionary as! NSObject)
}