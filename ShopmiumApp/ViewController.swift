//
//  ViewController.swift
//  ShopmiumApp
//
//  Extension dealing with view controllers.
//
//  Created by Lorenzo Di Vita on 19/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

extension UIViewController
{
    func setUpNavigationBar(title: String)
    {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = title
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon_navbar"), style: UIBarButtonItemStyle.Plain, target: self, action: "openLeftMenu")
    }
    
    func getRootMenuContainerViewController() -> RootMenuContainerViewController?
    {
        var parent = self.parentViewController
        
        while parent != nil
        {
            if (parent is RootMenuContainerViewController) {
                return parent as? RootMenuContainerViewController
            }
            
            else if parent!.parentViewController != nil && parent!.parentViewController != parent {
                parent = parent!.parentViewController
            }
            
            else {
                parent = nil
            }
        }
        
        return nil
    }
    
    func openLeftMenu() {
        self.getRootMenuContainerViewController()!.toggleLeftMenu()
    }
}
