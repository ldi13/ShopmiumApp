//
//  UserRequest.swift
//  ShopmiumApp
//
//  Class handling user requests.
//
//  Created by Lorenzo Di Vita on 14/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class UserRequest: ApiRequest
{
    // MARK: - Method allowing to sign-up a user with his given email
    
    class func signUpUser(email: String, successCompletionHandler: SuccessRequestHandler, errorCompletionHandler: ErrorRequestHandler)
    {
        // Body parameters
        
        var bodyParameters = [String: AnyObject]()
        
        var user = [String: AnyObject]()
        user[BodyParameters.EMAIL.rawValue] = email
        bodyParameters[BodyParameters.USER.rawValue] = user
        
        bodyParameters[BodyParameters.TIMEZONE_OFFSET.rawValue] = TIMEZONE_OFFSET_VALUE
        bodyParameters[BodyParameters.TI_ID.rawValue] = TI_ID_VALUE
        bodyParameters[BodyParameters.APP_KEY.rawValue] = APP_KEY_VALUE
        bodyParameters[BodyParameters.INSTALLATION_SOURCE.rawValue] = 1
        bodyParameters[BodyParameters.LOGOUT.rawValue] = 1
        bodyParameters[BodyParameters.DEVICE.rawValue] = DEVICE_PATTERN_VALUE
        bodyParameters[BodyParameters.ROLE.rawValue] = 1
        bodyParameters[BodyParameters.LANGUAGE.rawValue] = NSLocale.preferredLanguages()[0]
        
        UserRequest.createRequest(API_BASE_PATH, path: USER_PATH, method: Method.POST, queryParameters: nil, bodyParameters: bodyParameters, successHandler: successCompletionHandler, errorHandler: errorCompletionHandler)
    }
}
