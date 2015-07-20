//
//  LeftMenuViewController.swift
//  ShopmiumApp
//
//  Left menu displaying side panel features.
//
//  Created by Lorenzo Di Vita on 19/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController
{
    // MARK: Constants
    
    let USER_PROFILE_CELL_HEIGHT = CGFloat(190)
    let OPTION_MENU_CELL_HEIGHT = CGFloat(50)
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Enum defining table structure
    
    enum LeftMenuRows
    {
        case UserProfile
        case Offers
        case Shops
        case Reviews
        case Sponsorship
        case Purchase
        case Preferences
        case Help
        
        case count
    }
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Cells registration
        self.tableView.registerNib(UINib(nibName: "UserProfileMenuCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.UserProfileMenuCell.rawValue)
        self.tableView.registerNib(UINib(nibName: "OptionMenuCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.OptionMenuCell.rawValue)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LeftMenuViewController: UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeftMenuRows.count.hashValue
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Cell to display
        var cell: UITableViewCell!
        
        switch indexPath.row
        {
            case LeftMenuRows.UserProfile.hashValue:
                let userProfileMenuCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.UserProfileMenuCell.rawValue) as! UserProfileMenuCell
                cell = userProfileMenuCell
            
            case LeftMenuRows.Offers.hashValue:
                cell = self.createOptionMenuCell("offers_icon", title: loc("Left.menu.offers.title"))
            
            case LeftMenuRows.Shops.hashValue:
                cell = self.createOptionMenuCell("shops_icon", title: loc("Left.menu.shops.title"))
            
            case LeftMenuRows.Reviews.hashValue:
                cell = self.createOptionMenuCell("reviews_icon", title: loc("Left.menu.reviews.title"))
            
            case LeftMenuRows.Sponsorship.hashValue:
                cell = self.createOptionMenuCell("sponsorship_icon", title: loc("Left.menu.sponsorship.title"))
            
            case LeftMenuRows.Purchase.hashValue:
                cell = self.createOptionMenuCell("purchase_icon", title: loc("Left.menu.purchase.title"))
            
            case LeftMenuRows.Preferences.hashValue:
                cell = self.createOptionMenuCell("preferences_icon", title: loc("Left.menu.preferences.title"))
            
            case LeftMenuRows.Help.hashValue:
                cell = self.createOptionMenuCell("help_icon", title: loc("Left.menu.help.title"))
            
            default:
                break
        }
        
        return cell
    }
    
    private func createOptionMenuCell(iconImageName: String, title: String) -> OptionMenuCell
    {
        let optionMenuCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.OptionMenuCell.rawValue) as! OptionMenuCell
        optionMenuCell.refreshCell(iconImageName, title: title)
        
        return optionMenuCell
    }
}

extension LeftMenuViewController: UITableViewDelegate
{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        // Height to define
        var height: CGFloat!
        
        switch indexPath.row
        {
            case LeftMenuRows.UserProfile.hashValue:
                height = USER_PROFILE_CELL_HEIGHT
            
            default:
                height = OPTION_MENU_CELL_HEIGHT
                break
        }
        
        return height
    }
}




