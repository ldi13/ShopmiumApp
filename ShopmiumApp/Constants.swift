//
//  Constants.swift
//  ShopmiumApp
//
//  Constants declaration file to be reused in whole application.
//
//  Created by Lorenzo Di Vita on 13/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit


// MARK: - Typealias for requests handlers

typealias SuccessRequestHandler = (result: AnyObject) -> Void
typealias ErrorRequestHandler = (error: NSError) -> Void


// MARK: - Format patterns

let CONCATENATION_FORMAT_PATTERN = "%@%@"


// MARK: - API

let API_BASE_PATH = "https://app-staging.shopmium.com/mobileapp/v39"
let USER_PATH = "/user"
let TI_ID_VALUE = "A5F9DCD3-E1D1-4424-BC7A-99121D5073E6"
let APP_KEY_VALUE = "U2FsdGVkX19zc3Nzc3Nzc9opL1kESmS2aGqN8T4To8U=\n"
let TIMEZONE_OFFSET_VALUE = "-120"
let DEVICE_PATTERN_VALUE = "{\"app_platform\":\"3\",\"ti_id\":\"A5F9DCD3-E1D1-4424-BC7A-99121D5073E9\",\"model\":\"\(UIDevice.currentDevice().model)\",\"version\":\"\(UIDevice.currentDevice().systemVersion)\",\"address\":\"192.168.40.260\",\"country\":\"FR\",\"locale\":\"fr\",\"name\":\"\(UIDevice.currentDevice().localizedModel)\",\"osname\":\"\(UIDevice.currentDevice().systemName)\",\"username\":\"\(UIDevice.currentDevice().name)\",\"netmask\":\"0.0.0.0\",\"appVersion\":\"5.0.0\",\"parse_identifier\":\"XXXXXX\"}"