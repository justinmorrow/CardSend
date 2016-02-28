//
//  PersonPoster.swift
//  CardSend
//
//  Created by Russell Ladd on 2/28/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

class DataPoster {
    
    let session = NSURLSession.sharedSession()
    
    func postData(data: NSData, completionBlock: (NSError?) -> Void) {
        
        let url = NSURL(string: "http://sheltered-bastion-56935.herokuapp.com")!
        
        let request = NSMutableURLRequest(URL: url)
        
        request.setValue("application/x-vcard", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = data
        
        let task = session.dataTaskWithURL(url) { data, response, error in
            completionBlock(error)
        }
        
        task.resume()
    }
}
