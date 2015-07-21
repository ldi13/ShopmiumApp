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
    let MAX_ALPHA_OVERLAY = CGFloat(0.8)
    let MIN_ALPHA_OVERLAY = CGFloat(0)
    
    // MARK: - Enum
    
    enum SlideOutState
    {
        case BothCollapsed
        case LeftPanelExpanded
    }
    
    
    // MARK: - Properties
    
    var contentNavigationController: UINavigationController!
    var contentViewController: UIViewController!
    var currentState: SlideOutState = .BothCollapsed
    var leftMenuViewController: LeftMenuViewController!
    var panGestureRecognizer: UIPanGestureRecognizer!
    var overlayView: UIView!
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Deal with content view controller and navigation
        self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdentifiers.ON_BOARD.rawValue) as! UIViewController
        self.contentNavigationController = UINavigationController(rootViewController: self.contentViewController)
        
        // Define content navigation view controller as child view into container
        self.view.addSubview(self.contentNavigationController.view)
        self.addChildViewController(self.contentNavigationController)
        self.contentNavigationController.didMoveToParentViewController(self)
        
        // Pan gesture recognizer
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.contentNavigationController.view.addGestureRecognizer(self.panGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Custom methods
    
    func toggleLeftMenu()
    {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            self.addLeftMenuViewController()
        }
        
        self.animateLeftMenu(shouldExpand: notAlreadyExpanded)
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
                    self.overlayView.layer.backgroundColor = UIColor(white: 0.1, alpha: self.calculateAlphaOverlayForLayer(leftViewController.view.frame.origin.x)).CGColor
                }
                
            case UIGestureRecognizerState.Ended:
                if let leftViewController = self.leftMenuViewController {
                    self.animateLeftMenu(shouldExpand: gestureIsDraggingFromLeftToRight)
                }
                
            default:
                break
        }
    }
    
    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        self.animateLeftMenu(shouldExpand: false)
    }
    
    private func addChildLeftMenuViewController()
    {
        self.leftMenuViewController.view.frame = CGRectMake(-MENU_WIDTH, 0, MENU_WIDTH, self.leftMenuViewController.view.frame.height)
        
        self.overlayView = UIView(frame: UIScreen.mainScreen().bounds)
        self.overlayView.layer.backgroundColor = UIColor(white: 0.1, alpha: 0).CGColor
        self.overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:")))
        
        UIApplication.sharedApplication().keyWindow!.addSubview(self.overlayView)
        UIApplication.sharedApplication().keyWindow!.addSubview(self.leftMenuViewController.view)
        
        self.addChildViewController(self.leftMenuViewController)
        self.leftMenuViewController.didMoveToParentViewController(self)
    }
    
    private func animateLeftMenuXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.leftMenuViewController?.view.frame.origin.x = targetPosition
            self.overlayView.layer.backgroundColor = UIColor(white: 0.1, alpha: self.calculateAlphaOverlayForLayer(targetPosition)).CGColor
            }, completion: completion)
    }
    
    private func addLeftMenuViewController()
    {
        if (self.leftMenuViewController == nil)
        {
            self.leftMenuViewController = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdentifiers.LEFT_MENU.rawValue) as? LeftMenuViewController
            self.addChildLeftMenuViewController()
        }
    }
    
    private func animateLeftMenu(#shouldExpand: Bool)
    {
        if (shouldExpand)
        {
            self.currentState = .LeftPanelExpanded
            
            self.animateLeftMenuXPosition(targetPosition: 0) {
                finished in
                    self.leftMenuViewController.view.addGestureRecognizer(self.panGestureRecognizer)
            }
        }
            
        else
        {
            self.animateLeftMenuXPosition(targetPosition: -MENU_WIDTH) {
                finished in
                    self.currentState = .BothCollapsed
                    self.leftMenuViewController?.view.removeFromSuperview()
                    self.leftMenuViewController = nil;
                    self.overlayView.removeFromSuperview()
                    self.overlayView = nil
                    self.contentViewController.view.addGestureRecognizer(self.panGestureRecognizer)
            }
        }
    }
    
    private func calculateAlphaOverlayForLayer(targetPosition: CGFloat) -> CGFloat
    {
        let totalDistance = MENU_WIDTH
        let delta = MENU_WIDTH - abs(targetPosition)
        let percentage = delta / totalDistance
        
        let calculatedAlphaOverlay = MAX_ALPHA_OVERLAY * percentage
        
        return calculatedAlphaOverlay
    }
}
