//
//  SignUpViewController.swift
//  ShopmiumApp
//
//  Screen dedicated to sign-up feature.
//
//  Created by Lorenzo Di Vita on 14/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController
{
    // MARK: - Constants
    
    let EMAIL_TEXT_FIELD_DEFAULT_Y_CONSTRAINT = CGFloat(30)
    let EMAIL_TEXT_FIELD_KEYBOARD_Y_CONSTRAINT = CGFloat(70)
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var emailTextFieldYConstraint: NSLayoutConstraint!
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.customizeUI()
        self.registerForKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.removeKeyboardNotifications()
    }
    
    
    // MARK: - Custom methods
    
    private func customizeUI()
    {
        self.registrationButton.drawRoundedCorners(CGFloat(5))
        self.registrationButton.setTitle(loc("Sign.up.registration.button.title"), forState: UIControlState.Normal)
        
        self.emailTextField.placeholder = loc("Sign.up.email.textfield.placeholder")
        
        self.spinnerView.hidden = true
    }
    
    private func registerForKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeShown:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeHidden:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillBeShown(notification: NSNotification) {
        self.moveEmailTextField(notification, yPosition: EMAIL_TEXT_FIELD_KEYBOARD_Y_CONSTRAINT)
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        self.moveEmailTextField(notification, yPosition: EMAIL_TEXT_FIELD_DEFAULT_Y_CONSTRAINT)
    }
    
    private func moveEmailTextField(notification: NSNotification, yPosition: CGFloat)
    {
        let info = notification.userInfo
        let keyboardFrame = (info![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let keyboardAnimationDuration = (info![UIKeyboardAnimationDurationUserInfoKey] as! NSValue) as! NSTimeInterval
        
        self.emailTextFieldYConstraint.constant = yPosition
        UIView.animateWithDuration(keyboardAnimationDuration, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func handleUIIntercation(#enableInteraction: Bool)
    {
        self.registrationButton.enabled = enableInteraction
        self.spinnerView.hidden = enableInteraction
        
        if !enableInteraction {
            self.spinnerView.startAnimating()
        }
    }
    
    @IBAction func sendRegistration(sender: UIButton)
    {
        if self.emailTextField.text.isEmailValid()
        {
            self.view.endEditing(true)
            self.handleUIIntercation(enableInteraction: false)
            
            UserRequest.signUpUser(self.emailTextField.text, successCompletionHandler: {
                (result) in
                    self.displayRootMenuContainerViewController(result)
                }, errorCompletionHandler: {
                    (error, JSON) in
                        self.handleUIIntercation(enableInteraction: true)
                    
                        let errorMessageDictionary = JSON as! [String: AnyObject]
                        let errorMessage = (errorMessageDictionary["message"] as! [String: AnyObject])["message"] as! String
                    
                        showAlertView(loc("Error.alertview.title"), errorMessage)
                }
            )
        }
        
        else {
            showAlertView(loc("Error.alertview.title"), loc("Sign.up.email.validation.error"))
        }
    }
    
    private func displayRootMenuContainerViewController(result: AnyObject)
    {
        let rootMenuContainerViewController = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdentifiers.ROOT_MENU_CONTAINER.rawValue) as! RootMenuContainerViewController
        
        User.sharedInstance.refreshUserWithJSON(result as! [String: AnyObject])
        User.sharedInstance.response = serializeToJSON(result)
        
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(rootMenuContainerViewController, animated: true, completion: nil)
    }
}
