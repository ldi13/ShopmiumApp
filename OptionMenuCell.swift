//
//  OptionMenuCell.swift
//  ShopmiumApp
//
//  Cell representing option into left menu.
//
//  Created by Lorenzo Di Vita on 20/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class OptionMenuCell: UITableViewCell
{
    // MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: - Custom methods
    
    func refreshCell(iconImageName: String, title: String)
    {
        self.iconImageView.image = UIImage(named: iconImageName)
        self.titleLabel.text = title
    }
}
