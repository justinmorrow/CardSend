//
//  ContactViewController.swift
//  CardSend
//
//  Created by Justin Morrow on 2/27/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        let doneButton = UIButton(type: .System)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", forState: .Normal)
        view.addSubview(doneButton)
        
//        doneButton.backgroundColor = UIColor.redColor()
        doneButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        doneButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        doneButton.addTarget(self, action: "presentTransactionViewController", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func presentTransactionViewController() {
        let transactionViewController = TransactionViewController()
        presentViewController(transactionViewController, animated: true, completion: nil)
    }
}