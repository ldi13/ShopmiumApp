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
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.customizeUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Custom methods
    
    private func customizeUI()
    {
        self.registrationButton.drawRoundedCorners(CGFloat(5))
        self.registrationButton.setTitle(loc("Sign.up.registration.button.title"), forState: UIControlState.Normal)
        
        self.emailTextField.placeholder = loc("Sign.up.email.textfield.placeholder")
        
        self.spinnerView.hidden = true
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
            self.handleUIIntercation(enableInteraction: false)
            
            UserRequest.signUpUser(self.emailTextField.text, successCompletionHandler: {
                (result) in
                    println(result)
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
}
