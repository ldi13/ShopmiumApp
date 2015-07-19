//
//  ApiRequest.swift
//  ShopmiumApp
//
//  Abstract layer to deal with REST requests.
//
//  Created by Lorenzo Di Vita on 14/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

class ApiRequest: NSObject
{
    // MARK: Properties
    
    var method: Method!
    var path: String!
    var base: String!
    var bodyParameters: [String: AnyObject]?
    var queryParameters: [String: AnyObject]?
    var successHandler: SuccessRequestHandler!
    var errorHandler: ErrorRequestHandler!
    
    
    // MARK: Default constructor
    
    override init() {
        // Empty
    }
    
    
    // MARK: ApiRequest methods
    
    func createUrlRequest() -> NSMutableURLRequest
    {
        // URL based on base / path
        var url = NSURL(string: String(format: CONCATENATION_FORMAT_PATTERN, arguments: [self.base, self.path]))
        
        // URL Request based on URL
        var urlRequest = NSURLRequest(URL: url!)
        
        // Query parameters
        if self.queryParameters == nil {
            self.queryParameters = [String: AnyObject]()
        }
        
        // Query parameters encoding
        let queryParametersEncoding = ParameterEncoding.URL
        (urlRequest, _) = queryParametersEncoding.encode(urlRequest, parameters: self.queryParameters)
        
        // Body parameters encoding
        if let bodyParameters = self.bodyParameters
        {
            let bodyParametersEncoding = ParameterEncoding.JSON
            (urlRequest, _) = bodyParametersEncoding.encode(urlRequest, parameters: bodyParameters)
        }
        
        // Request method verb
        var mutableRequest = urlRequest.mutableCopy() as! NSMutableURLRequest
        mutableRequest.HTTPMethod = self.method.rawValue
        
        return mutableRequest
    }
    
    
    // MARK: - Custom methods
    
    class func createRequest(base: String, path: String, method: Method, queryParameters: [String: AnyObject]?, bodyParameters: [String: AnyObject]?, successHandler: SuccessRequestHandler, errorHandler: ErrorRequestHandler)
    {
        // Define API request
        let apiRequest = ApiRequest()
        
        // Request attributes
        apiRequest.method = method
        apiRequest.base = base
        apiRequest.path = path
        apiRequest.queryParameters = queryParameters
        apiRequest.bodyParameters = bodyParameters
        apiRequest.successHandler = successHandler
        apiRequest.errorHandler = errorHandler
        
        // Send API request
        ApiRequest.sendRequest(apiRequest)
    }

    class func sendRequest(apiRequest: ApiRequest)
    {
        // Define request manager
        let manager = Manager.sharedInstance
        
        // Create URL request based from API request
        var urlRequest = apiRequest.createUrlRequest()
        
        // Send request via manager
        manager
            .request(urlRequest)
            .validate()
            .responseJSON {
                (request, response, JSON, error) -> Void in
                    if let error = error {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            apiRequest.errorHandler(error: error, JSON: JSON!)
                        })
                    }
                        
                    else if let JSON: AnyObject = JSON
                    {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            apiRequest.successHandler(result: JSON)
                        })
                    }
        }
    }

}
