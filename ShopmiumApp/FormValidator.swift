//
//  FormValidator
//  ShopmiumApp
//
//  Extension providing helper methods used into forms.
//
//  Created by Lorenzo Di Vita on 17/07/2015.
//  Copyright (c) 2015 shopmium. All rights reserved.
//

import UIKit

extension String
{
    func isEmailValid() -> Bool
    {
        var error: NSError?
        let emailRegularExpression = NSRegularExpression(pattern: EMAIL_REGEXP, options: NSRegularExpressionOptions.CaseInsensitive, error: &error)
        let matches = emailRegularExpression?.matchesInString(self, options: nil, range: NSMakeRange(0, count(self)))
        return matches?.count > 0
    }
}
