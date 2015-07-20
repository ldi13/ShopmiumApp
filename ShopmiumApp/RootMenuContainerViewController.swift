//
//  ContainerViewController.swift
//  ShopmiumApp
//
//  Root menu container with left component.
//
//  Created by Lorenzo Di Vita on 19/07/2015.
//  Copyright (c) 2015 ldi. All rights reserved.
//

import UIKit

class RootMenuContainerViewController: UIViewController
{
    // MARK: - Constants
    
    let MENU_WIDTH = CGFloat(270)
    
    // MARK: - Enum
    
    enum SlideOutState
    {
        case BothCollapsed
        case LeftPanelExpanded
        case RightPanelExpanded
    }
    
    
    // MARK: - Properties
    
    var contentNavigationController: UINavigationController!
    var contentViewController: UIViewController!
    var currentState: SlideOutState = .BothCollapsed
    var leftMenuViewController: LeftMenuViewController!
    
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Deal with content view controller and navigation
        self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("onBoardViewController") as! UIViewController
        self.contentNavigationController = UINavigationController(rootViewController: self.contentViewController)
        
        // Define content navigation view controller as child view into container
        self.view.addSubview(self.contentNavigationController.view)
        self.addChildViewController(self.contentNavigationController)
        self.contentNavigationController.didMoveToParentViewController(self)
        
        // Pan gesture recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.contentNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addChildLeftMenuViewController()
    {
        self.leftMenuViewController.view.frame = CGRectMake(-MENU_WIDTH, 0, MENU_WIDTH, self.leftMenuViewController.view.frame.height)
        
        self.view.insertSubview(self.leftMenuViewController.view, aboveSubview: self.view)
        self.addChildViewController(self.leftMenuViewController)
        self.leftMenuViewController.didMoveToParentViewController(self)
    }
    
    func animateLeftMenuXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.leftMenuViewController?.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer)
    {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(self.view).x > 0)
        
        switch(recognizer.state)
        {
        case UIGestureRecognizerState.Began:
            if (self.currentState == .BothCollapsed)
            {
                if (gestureIsDraggingFromLeftToRight) {
                    self.addLeftMenuViewController()
                }
            }
            
        case UIGestureRecognizerState.Changed:
            if let leftViewController = self.leftMenuViewController
            {
                leftViewController.view.center.x = min(leftViewController.view.center.x + recognizer.translationInView(view).x, leftViewController.view.frame.width / 2)
                recognizer.setTranslation(CGPointZero, inView: self.leftMenuViewController!.view)
            }
            
        case UIGestureRecognizerState.Ended:
            if let leftViewController = self.leftMenuViewController {
                self.animateLeftMenu(shouldExpand: gestureIsDraggingFromLeftToRight)
            }
            
        default:
            break
        }
    }
}

extension RootMenuContainerViewController
{
    func toggleLeftMenu()
    {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            self.addLeftMenuViewController()
        }
        
        self.animateLeftMenu(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftMenuViewController()
    {
        if (self.leftMenuViewController == nil)
        {
            self.leftMenuViewController = self.storyboard?.instantiateViewControllerWithIdentifier("leftMenuViewController") as? LeftMenuViewController
            self.addChildLeftMenuViewController()
        }
    }
    
    func animateLeftMenu(#shouldExpand: Bool)
    {
        if (shouldExpand) {
            self.currentState = .LeftPanelExpanded
            
            self.animateLeftMenuXPosition(targetPosition: 0)
        }
            
        else {
            self.animateLeftMenuXPosition(targetPosition: -MENU_WIDTH) {
                finished in
                    self.currentState = .BothCollapsed
                    self.leftMenuViewController?.view.removeFromSuperview()
                    self.leftMenuViewController = nil;
            }
        }
        
    }
}
