//
//  PersonPoster.swift
//  CardSend
//
//  Created by Russell Ladd on 2/28/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit
import Contacts

class ContactPoster {
    
    let session = NSURLSession.sharedSession()
    
    func postData(contact: CNContact, completionBlock: (NSError?) -> Void) {
        
        let url = NSURL(string: "http://sheltered-bastion-56935.herokuapp.com")!
        
        let request = NSMutableURLRequest(URL: url)
        
        request.setValue("application/x-vcard", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = try! CNContactVCardSerialization.dataWithContacts([contact])
        
        let task = session.dataTaskWithURL(url) { data, response, error in
            completionBlock(error)
        }
        
        task.resume()
    }
}
