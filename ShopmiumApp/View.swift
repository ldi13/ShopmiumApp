//
//  View.swift
//  ShopmiumApp
//
//  Created by Lorenzo Di Vita on 14/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit


extension UIView
{
    // MARK: - Method to draw rounded corners on UIView
    
    func drawRoundedCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
}
